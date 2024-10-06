import 'package:dartz/dartz.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';

abstract class SessionRepository {
  Future<Either<Exception, SessionInfo>> startSession({
    required String userName,
    required String deviceId,
    required SensorPosition devicePosition,
  });
}
