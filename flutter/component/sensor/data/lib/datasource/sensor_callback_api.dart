import 'package:flutter/foundation.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';

class SensorCallbackApiImpl implements SensorCallbackApi {
  @override
  void onSensorDataRecorded(SensorData sensorData) {
    if (kDebugMode) {
      print(sensorData);
    }
  }
}