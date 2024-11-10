import 'dart:async';

import 'package:core_component_domain/app_configuration_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';
import 'package:sensor_component_data/datasource/sensor_store_worker.dart';

@singleton
class SensorCallbackApiImpl implements SensorCallbackApi {
  final SensorStoreWorker _sensorStoreWorker;
  final AppConfigurationRepository _appConfigurationRepository;

  StreamSubscription<String?>? _currentSessionIdSubscription;
  String? _currentSessionId;

  SensorCallbackApiImpl(
    this._appConfigurationRepository,
    this._sensorStoreWorker,
  );

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    _currentSessionIdSubscription = _appConfigurationRepository
        .getCurrentSessionIdStream()
        .listen((sessionId) {
      _currentSessionId = sessionId;
    });
  }

  @override
  void onSensorDataRecorded(SensorDataModel sensorData) {
    if (_currentSessionId == null) {
      return;
    }
    _sensorStoreWorker.storeData(sensorData, _currentSessionId!);
  }

  @override
  Future<void> onSensorConnected(bool isConnected) async {
    await _appConfigurationRepository.setIsSensorConnected(isConnected);
  }

  @disposeMethod
  void dispose() {
    _currentSessionIdSubscription?.cancel();
  }
}

extension SensorDataString on SensorDataModel {
  String stringify() {
    return """{
name: $name,
acceleration: { x: ${acceleration.x}, y: ${acceleration.y}, z: ${acceleration.z}},
angularVelocity:  { x: ${angularVelocity.x}, y: ${angularVelocity.y}, z: ${angularVelocity.z}},
magneticField:  { x: ${magneticField.x}, y: ${magneticField.y}, z: ${magneticField.z}},
angle:  { x: ${angle.x}, y: ${angle.y}, z: ${angle.z}},
}""";
  }
}
