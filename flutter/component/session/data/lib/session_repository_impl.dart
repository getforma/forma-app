import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:android_id/android_id.dart';
import 'package:core_component_domain/shared_preferences_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
import 'package:session_component_data/datasource/local_measurement_datasource.dart';
import 'package:session_component_data/datasource/session_datasource.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/session_repository.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:forma_app/injection/injection.dart';

const _kDataSyncDuration = Duration(seconds: 30);

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final SessionDataSource _sessionDataSource;
  final LocalSensorDataSource _localDataSource;
  final SharedPreferencesRepository _sharedPreferencesRepository;

  StreamSubscription<Position>? positionStream;
  Position? latestPosition;

  SessionRepositoryImpl(this._sessionDataSource,
      this._localDataSource,
      this._sharedPreferencesRepository,);

  @override
  Future<Either<Exception, SessionInfo>> createSession({
    required String userName,
    required SensorPosition sensorPosition,
  }) async {
    try {
      final isLocationPermissionGranted = await _requestLocationPermission();
      if (!isLocationPermissionGranted) {
        return Left(Exception("Location permission not granted"));
      }

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 2,
      );
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.best,
          activityType: ActivityType.fitness,
          distanceFilter: 2,
          pauseLocationUpdatesAutomatically: false,
          showBackgroundLocationIndicator: true,
          allowBackgroundLocationUpdates: true,
        );
      }
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) {
            latestPosition = position;
          });

      final deviceId = await _getDeviceId();
      final response = await _sessionDataSource.createSession(SessionRequest(
        deviceId: deviceId,
        devicePosition: sensorPosition,
        userName: userName,
      ));

      // Start the background service instead of using a Timer
      await _startBackgroundService(response.id);

      await _sharedPreferencesRepository.set(
        SharedPreferencesKey.currentSession,
        jsonEncode(response.toJson()),
      );

      return Right(response);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<void> _startBackgroundService(String sessionId) async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    await service.startService();
    // Pass the sessionId to the background service
    service.invoke('setSessionId', {'sessionId': sessionId});
  }

  @override
  Future<Either<Exception, void>> storeMeasurementLocally({
    required SensorData data,
    double? longitude,
    double? latitude,
    SensorPosition? sensorPosition,
  }) async {
    try {
      final sessionInfoString = _sharedPreferencesRepository
          .get<String>(SharedPreferencesKey.currentSession);
      if (sessionInfoString == null) {
        return const Right(null);
      }

      final sessionInfo = SessionInfo.fromJson(jsonDecode(sessionInfoString));
      final position = latestPosition;
      if (position == null) {
        return Left(Exception("GPS position not established"));
      }

      await _localDataSource.saveMeasurement(
        data: data,
        longitude: position.longitude,
        latitude: position.latitude,
        sensorPosition: SensorPosition.pelvisRight,
        sessionId: sessionInfo.id,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, MeasurementAnalysis>> stopSession() async {
    final sessionString = _sharedPreferencesRepository
        .get<String>(SharedPreferencesKey.currentSession);
    if (sessionString == null) {
      return Left(Exception("No session started"));
    }

    final currentSession = SessionInfo.fromJson(jsonDecode(sessionString));

    await _sharedPreferencesRepository
        .remove(SharedPreferencesKey.currentSession);

    final service = FlutterBackgroundService();
    service.invoke('stopService');
    positionStream?.cancel();
    positionStream = null;

    return await syncData(currentSession.id);
  }

  Future<Either<Exception, MeasurementAnalysis>> syncData(
      String sessionId) async {
    try {
      final unsyncedMeasurements =
      await _localDataSource.getUnsynedMeasurements(sessionId);
      final measurementAnalysis = await _sessionDataSource.trackSessionData(
          sessionId,
          unsyncedMeasurements
              .map((measurement) =>
              SessionMeasurement.fromMeasurement(measurement))
              .toList(growable: false));

      await _localDataSource.saveMeasurementAnalysis(
          measurementAnalysis, sessionId);
      await _localDataSource.markDataAsSynced(sessionId);

      return Right(measurementAnalysis);
    } on Exception catch (e) {
      return Left(Exception("Couldn't sync data: $e"));
    }
  }

  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    String? id;
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      final androidId = await const AndroidId().getId();
      id = androidId;
    }
    return id ?? DateTime.now().toIso8601String();
  }

  Future<bool> _requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Stream<MeasurementAnalysis?> getMeasurementAnalysisStream(String sessionId) {
    return _localDataSource.getMeasurementAnalysisStream(sessionId);
  }
}

// This function will be called when the background service is started
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  String? sessionId;

  service.on('setSessionId').listen((event) {
    sessionId = event?['sessionId'] as String?;
  });

  service.on('stopService').listen((event) async {
    await service.stopSelf();
  });

  await configureDependencies();
  final sessionRepository = GetIt.I.get<SessionRepository>();

  // This timer replaces the one in the main app
  Timer.periodic(_kDataSyncDuration, (timer) async {
    final _sessionId = sessionId;
    if (_sessionId != null) {
      await sessionRepository.syncData(_sessionId);
    }
  });
}

// iOS-specific background handler
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}
