import 'package:flutter/foundation.dart';
import 'package:forma_app/service/sensor_messages.g.dart';

class SensorFlutterApiImpl implements SensorFlutterApi {
  @override
  void onSensorDataRecorded(SensorData sensorData) {
    if (kDebugMode) {
      print(sensorData);
    }
  }
}