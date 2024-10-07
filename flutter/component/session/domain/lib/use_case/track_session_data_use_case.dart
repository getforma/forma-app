import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class TrackSessionDataUseCase implements UseCase<TrackSessionDataUseCaseParam, void> {
  final SessionRepository _sessionRepository;

  TrackSessionDataUseCase(this._sessionRepository);

  @override
  Future<Either<Exception, void>> invoke(TrackSessionDataUseCaseParam param) {
    return _sessionRepository.trackSessionData(
        param.sessionId, param.measurements);
  }
}

class TrackSessionDataUseCaseParam {
  final String sessionId;
  final List<SessionMeasurement> measurements;

  TrackSessionDataUseCaseParam({
    required this.sessionId,
    required this.measurements,
  });
}
