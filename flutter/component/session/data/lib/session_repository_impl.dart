import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_data/datasource/session_datasource.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/session_repository.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {
  final SessionDataSource _sessionDataSource;

  SessionRepositoryImpl(this._sessionDataSource);

  @override
  Future<Either<Exception, SessionInfo>> createSession(
      SessionRequest sessionRequest) async {
    try {
      final response = await _sessionDataSource.createSession(sessionRequest);
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
}
