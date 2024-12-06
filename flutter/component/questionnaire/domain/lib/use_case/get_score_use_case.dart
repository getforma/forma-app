import 'package:core_component_domain/use_case/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:core_component_domain/app_configuration_repository.dart';

@injectable
class GetScoreStreamUseCase
    implements SynchronousUseCase<EmptyParam, Stream<int?>> {
  final AppConfigurationRepository _appConfigurationRepository;

  GetScoreStreamUseCase(this._appConfigurationRepository);

  @override
  Stream<int?> invoke(EmptyParam param) {
    return _appConfigurationRepository.getScoreStream();
  }
}
