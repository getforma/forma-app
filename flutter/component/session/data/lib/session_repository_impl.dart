import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:core_component_domain/shared_preferences_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
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

const _kDataSyncDuration = Duration(seconds: 30);

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final SessionDataSource _sessionDataSource;
  final LocalSensorDataSource _localDataSource;
  final SharedPreferencesRepository _sharedPreferencesRepository;

  StreamSubscription<Position>? positionStream;
  Position? latestPosition;

  Timer? _syncDataTimer;

  SessionRepositoryImpl(
    this._sessionDataSource,
    this._localDataSource,
    this._sharedPreferencesRepository,
  );

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

      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      );
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

      _syncDataTimer = Timer.periodic(_kDataSyncDuration, (timer) {
        _syncData(response.id);
      });

      await _sharedPreferencesRepository.set(
        SharedPreferencesKey.currentSession,
        jsonEncode(response.toJson()),
      );

      return Right(response);
    } on Exception catch (e) {
      return Left(e);
    }
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

    _syncDataTimer?.cancel();
    _syncDataTimer = null;
    positionStream?.cancel();
    positionStream = null;

    return await _syncData(currentSession.id);
  }

  Future<Either<Exception, MeasurementAnalysis>> _syncData(
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
