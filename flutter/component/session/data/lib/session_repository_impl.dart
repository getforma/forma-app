import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:dartz/dartz.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_data/datasource/session_datasource.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/session_repository.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final SessionDataSource _sessionDataSource;

  SessionRepositoryImpl(this._sessionDataSource);

  @override
  Future<Either<Exception, SessionInfo>> createSession({
    required String userName,
    required SensorPosition sensorPosition,
  }) async {
    try {
      final deviceId = await _getDeviceId();
      final response = await _sessionDataSource.createSession(SessionRequest(
        deviceId: deviceId,
        devicePosition: sensorPosition,
        userName: userName,
      ));
      return Right(response);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> trackSessionData(
      String sessionId, List<SessionMeasurement> measurements) async {
    try {
      await _sessionDataSource.trackSessionData(sessionId, measurements);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<String> _getDeviceId() async {
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
}
