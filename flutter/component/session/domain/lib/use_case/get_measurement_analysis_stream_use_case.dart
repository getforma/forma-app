import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class GetMeasurementAnalysisStreamUseCase
    implements SynchronousUseCase<String, Stream<MeasurementAnalysis>> {
  final SessionRepository _sessionRepository;

  GetMeasurementAnalysisStreamUseCase(this._sessionRepository);

  @override
  Stream<MeasurementAnalysis> invoke(String param) {
    return _sessionRepository.getMeasurementAnalysisStream(param);
  }
}
