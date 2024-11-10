import 'dart:async';
import 'dart:isolate';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';
import 'package:session_component_domain/session_repository.dart';

@singleton
class SensorStoreWorker {
  SendPort? _sendPort;
  Isolate? _isolate;
  final Completer<void> _isolateReady = Completer.sync();

  SessionRepository? _sessionRepository;

  Future<void> initialize() async {
    try {
      final receivePort = ReceivePort();
      receivePort.listen(_handleResponsesFromIsolate);

      _sessionRepository = GetIt.I.get<SessionRepository>();

      _isolate = await Isolate.spawn(
        _startRemoteIsolate,
        receivePort.sendPort,
        debugName: 'WorkerIsolate',
      );

      await _isolateReady.future;
    } catch (e) {
      print('Failed to initialize worker: $e');
      rethrow;
    }
  }

  void _handleResponsesFromIsolate(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
    } else if (message is _StoreDataMessage) {
      final _StoreDataMessage storeDataMessage = message;
      final sensorData = storeDataMessage.data;
      final sessionId = storeDataMessage.sessionId;
      _sessionRepository?.storeMeasurementLocally(
        sessionId: sessionId,
        data: SensorData(
          name: sensorData.name,
          acceleration: ThreeAxisMeasurement(
            x: sensorData.acceleration.x,
            y: sensorData.acceleration.y,
            z: sensorData.acceleration.z,
          ),
          angularVelocity: ThreeAxisMeasurement(
            x: sensorData.angularVelocity.x,
            y: sensorData.angularVelocity.y,
            z: sensorData.angularVelocity.z,
          ),
          magneticField: ThreeAxisMeasurement(
            x: sensorData.magneticField.x,
            y: sensorData.magneticField.y,
            z: sensorData.magneticField.z,
          ),
          angle: ThreeAxisMeasurement(
            x: sensorData.angle.x,
            y: sensorData.angle.y,
            z: sensorData.angle.z,
          ),
        ),
      );
    }
  }

  static void _startRemoteIsolate(SendPort port) {
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);

    receivePort.listen((dynamic message) async {
      if (message is _StoreDataMessage) {
        try {
          port.send(message);
        } catch (e) {
          print('Error in isolate: $e');
        }
      }
    });
  }

  Future<void> storeData(SensorDataModel message, String sessionId) async {
    if (_sendPort == null) {
      throw StateError('Worker not initialized');
    }
    _sendPort!.send(_StoreDataMessage(message, sessionId));
  }

  void dispose() {
    _isolate?.kill();
    _isolate = null;
    _sendPort = null;
  }
}

class _StoreDataMessage {
  final SensorDataModel data;
  final String sessionId;

  _StoreDataMessage(this.data, this.sessionId);
}
