import 'package:dartz/dartz.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';

abstract class SessionRepository {
  Future<Either<Exception, SessionInfo>> createSession({
    required String userName,
    required SensorPosition sensorPosition,
  });

  Future<Either<Exception, void>> trackSensorData(SensorData sensorData);
}
