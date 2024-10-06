import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class CreateSessionUseCase implements UseCase<SessionRequest, SessionInfo> {
  final SessionRepository _sessionRepository;

  CreateSessionUseCase(this._sessionRepository);

  @override
  Future<Either<Exception, SessionInfo>> invoke(SessionRequest param) {
    return _sessionRepository.createSession(param);
  }
}
