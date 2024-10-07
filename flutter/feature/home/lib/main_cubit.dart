import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/use_case/initialize_sensor_use_case.dart';
import 'package:sensor_component_domain/use_case/start_sensor_discovery_use_case.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_measurement.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/model/three_axis_model.dart';
import 'package:session_component_domain/use_case/create_session_use_case.dart';
import 'package:session_component_domain/use_case/track_session_data_use_case.dart';

part 'main_cubit.freezed.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  final InitializeSensorUseCase _initializeSensorUseCase;
  final StartSensorDiscoveryUseCase _startSensorDiscoveryUseCase;
  final CreateSessionUseCase _createSessionUseCase;
  final TrackSessionDataUseCase _trackSessionDataUseCase;

  MainCubit(
    this._initializeSensorUseCase,
    this._startSensorDiscoveryUseCase,
    this._createSessionUseCase,
    this._trackSessionDataUseCase,
  ) : super(const MainState());

  Future<void> startDeviceDiscovery() async {
    _initializeSensorUseCase.invoke(EmptyParam());
    _startSensorDiscoveryUseCase.invoke(EmptyParam());

    return;
    // TODO: delete after testing
    final sessionResult = await _createSessionUseCase.invoke(const SessionRequest(
      deviceId: "test",
      devicePosition: SensorPosition.pelvisRight,
      userName: "Alex",
    ));
    
    if (sessionResult.isLeft()){
      return;
    }

    final session = sessionResult.toOption().toNullable();
    if (session == null) {
      return;
    }

    await _trackSessionDataUseCase.invoke(TrackSessionDataUseCaseParam(
      sessionId: session.id,
      measurements: [
        SessionMeasurement(
          time: DateTime.now(),
          latitude: 0,
          longitude: 0,
          acceleration: const ThreeAxisModel(x: 0, y: 0, z: 0),
          angularVelocity: const ThreeAxisModel(x: 0, y: 0, z: 0),
          magneticField: const ThreeAxisModel(x: 0, y: 0, z: 0),
          angle: const ThreeAxisModel(x: 0, y: 0, z: 0),
        ),
        SessionMeasurement(
          time: DateTime.now(),
          latitude: 0,
          longitude: 0,
          acceleration: const ThreeAxisModel(x: 0, y: 0, z: 0),
          angularVelocity: const ThreeAxisModel(x: 0, y: 0, z: 0),
          magneticField: const ThreeAxisModel(x: 0, y: 0, z: 0),
          angle: const ThreeAxisModel(x: 0, y: 0, z: 0),
        ),
      ],
    ));
  }

  void updateUserName(String name) {
    emit(state.copyWith(userName: name));
  }

  void updateSensorPosition(SensorPosition? position) {
    emit(state.copyWith(sensorPosition: position));
  }
}
