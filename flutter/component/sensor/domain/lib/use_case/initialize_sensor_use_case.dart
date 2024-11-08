import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/sensor_repository.dart';

@injectable
class InitializeSensorUseCase implements UseCase<EmptyParam, bool> {
  final SensorRepository _repository;

  InitializeSensorUseCase(this._repository);

  @override
  Future<Either<Exception, bool>> invoke(EmptyParam param) async {
    return Right(await _repository.initialize());
  }
}
