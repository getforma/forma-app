import 'package:core_component_domain/app_configuration_repository.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetIsSensorConnectedUseCase implements NotLensUseCase<bool, void> {
  final AppConfigurationRepository _appConfigurationRepository;

  SetIsSensorConnectedUseCase(this._appConfigurationRepository);

  @override
  Future<void> invoke(bool isConnected) async {
    await _appConfigurationRepository.setIsSensorConnected(isConnected);
  }
}
