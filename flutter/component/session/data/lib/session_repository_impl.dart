import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_data/datasource/local_sensor_datasource.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
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

  SessionRepositoryImpl(this._sessionDataSource, this._localDataSource);

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
  Future<Either<Exception, void>> trackSensorData(SensorData sensorData) async {
    try {
      // TODO: do that only when shared prefs flag is set to recording data
      await _localDataSource.saveSensorData(sensorData);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<String> _getDeviceId() async {
    // TODO: implment proper device id
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
