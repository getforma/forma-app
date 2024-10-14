import 'dart:async';
import 'dart:convert';

import 'package:core_component_domain/shared_preferences_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
import 'package:session_component_data/datasource/local_measurement_datasource.dart';
import 'package:session_component_data/datasource/session_datasource.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/session_repository.dart';

// import 'package:device_info_plus/device_info_plus.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final SessionDataSource _sessionDataSource;
  final LocalSensorDataSource _localDataSource;
  final SharedPreferencesRepository _sharedPreferencesRepository;

  late final StreamSubscription<Position> positionStream;
  Position? latestPosition;

  SessionRepositoryImpl(
    this._sessionDataSource,
    this._localDataSource,
    this._sharedPreferencesRepository,
  ) {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      latestPosition = position;
    });
  }

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

      final deviceId = await _getDeviceId();
      final response = await _sessionDataSource.createSession(SessionRequest(
        deviceId: deviceId,
        devicePosition: sensorPosition,
        userName: userName,
      ));

      await _sharedPreferencesRepository.set(
        SharedPreferencesKey.currentSession.toString(),
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
      final SessionInfo? sessionInfo = _sharedPreferencesRepository
          .get(SharedPreferencesKey.currentSession.toString());
      if (sessionInfo == null) {
        return const Right(null);
      }

      final position = latestPosition;
      if (position == null) {
        return Left(Exception("GPS position not established"));
      }

      await _localDataSource.saveMeasurement(
        data: data,
        longitude: position.longitude,
        latitude: position.latitude,
        sensorPosition: SensorPosition.pelvisRight,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<String> _getDeviceId() async {
    // TODO: implement proper device id
    return DateTime.now().toIso8601String();
    // final deviceInfo = DeviceInfoPlugin();
    // String? id;
    // if (Platform.isIOS) {
    //   final iosDeviceInfo = await deviceInfo.iosInfo;
    //   id = iosDeviceInfo.identifierForVendor;
    // } else if (Platform.isAndroid) {
    //   final androidId = await const AndroidId().getId();
    //   id = androidId;
    // }
    // return id ?? DateTime.now().toIso8601String();
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
}
