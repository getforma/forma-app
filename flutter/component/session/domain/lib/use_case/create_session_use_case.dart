import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_info.dart';
import 'package:session_component_domain/session_repository.dart';

@injectable
class CreateSessionUseCase
    implements UseCase<CreateSessionUseCaseParam, SessionInfo> {
  final SessionRepository _sessionRepository;

  CreateSessionUseCase(this._sessionRepository);

  @override
  Future<Either<Exception, SessionInfo>> invoke(
      CreateSessionUseCaseParam param) {
    return _sessionRepository.createSession(
      userName: param.userName,
      sensorPosition: param.sensorPosition,
    );
  }
}

class CreateSessionUseCaseParam {
  final SensorPosition sensorPosition;
  final String userName;

  CreateSessionUseCaseParam({
    required this.sensorPosition,
    required this.userName,
  });
}
