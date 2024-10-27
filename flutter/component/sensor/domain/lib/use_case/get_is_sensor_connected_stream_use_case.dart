import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:core_component_domain/app_configuration_repository.dart';

@injectable
class GetIsSensorConnectedStreamUseCase
    implements SynchronousUseCase<EmptyParam, Stream<bool>> {
  final AppConfigurationRepository _appConfigurationRepository;

  GetIsSensorConnectedStreamUseCase(this._appConfigurationRepository);

  @override
  Stream<bool> invoke(EmptyParam param) {
    return _appConfigurationRepository.getIsSensorConnectedStream();
  }
}
