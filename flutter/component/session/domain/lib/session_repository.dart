import 'package:dartz/dartz.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';

abstract class SessionRepository {
  Future<Either<Exception, SessionInfo>> createSession(
      SessionRequest sessionRequest);

  Future<Either<Exception, void>> trackSessionData(
      String sessionId, List<SessionMeasurement> measurements);
}
