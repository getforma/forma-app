import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/sensor_repository.dart';

@injectable
class StartSensorDiscoveryUseCase implements UseCase<EmptyParam, void> {
  final SensorRepository _repository;

  StartSensorDiscoveryUseCase(this._repository);

  @override
  Future<Either<Exception, void>> invoke(EmptyParam param) async {
    _repository.startDiscovery();
    return const Right(null);
  }
}
