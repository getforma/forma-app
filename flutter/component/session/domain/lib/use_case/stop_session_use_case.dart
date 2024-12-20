import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class StopSessionUseCase implements UseCase<EmptyParam, MeasurementAnalysis> {
  final SessionRepository _sessionRepository;

  StopSessionUseCase(this._sessionRepository);

  @override
  Future<Either<Exception, MeasurementAnalysis>> invoke(EmptyParam param) {
    return _sessionRepository.stopSession();
  }
}
