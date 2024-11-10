import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:core_component_data/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:forma_app/application.dart';
import 'package:forma_app/injection/injection.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:sensor_component_data/datasource/sensor_callback_api.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  GetIt.I.get<AppDatabase>();

  final sensorCallbackApi = GetIt.I<SensorCallbackApiImpl>();
  SensorCallbackApi.setUp(sensorCallbackApi);

  final worker = Worker();
  await worker.initialize();

  Timer(const Duration(seconds: 5), () {
    worker.parseJson('{"key":"value"}');
  });

  runApp(Application(appRouter: getIt.get<AppRouter>()));
}

class Worker {
  SendPort? _sendPort;
  Isolate? _isolate;
  final Completer<void> _isolateReady = Completer.sync();

  Future<void> initialize() async {
    try {
      final receivePort = ReceivePort();
      receivePort.listen(_handleResponsesFromIsolate);
      
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
    } else if (message is Map<String, dynamic>) {
      print('Received from isolate: $message');
    }
  }

  static void _startRemoteIsolate(SendPort port) {
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);

    receivePort.listen((dynamic message) async {
      if (message is String) {
        try {
          final transformed = jsonDecode(message);
          port.send(transformed);
        } catch (e) {
          print('Error in isolate: $e');
        }
      }
    });
  }

  Future<void> parseJson(String message) async {
    if (_sendPort == null) {
      throw StateError('Worker not initialized');
    }
    _sendPort!.send(message);
  }

  void dispose() {
    _isolate?.kill();
    _isolate = null;
    _sendPort = null;
  }
}
 