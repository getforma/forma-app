import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/split_analysis.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class GetSplitAnalysisUseCase
    implements UseCase<GetSplitAnalysisBody, SplitAnalysis> {
  final SessionRepository _sessionRepository;

  GetSplitAnalysisUseCase(this._sessionRepository);

  @override
  Future<Either<Exception, SplitAnalysis>> invoke(
    GetSplitAnalysisBody body,
  ) async {
    return _sessionRepository.analyzeSessionData(
      body.sessionId,
      body.startTime,
      body.endTime,
    );
  }
}

class GetSplitAnalysisBody {
  final String sessionId;
  final DateTime startTime;
  final DateTime endTime;

  GetSplitAnalysisBody({
    required this.sessionId,
    required this.startTime,
    required this.endTime,
  });
}
