import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/sensor_repository.dart';

@injectable
class GetSensorDataUseCase {
  final SensorRepository _repository;

  GetSensorDataUseCase(this._repository);

  void invoke() {
    final result = _repository.hello();
    print(result);
  }
}