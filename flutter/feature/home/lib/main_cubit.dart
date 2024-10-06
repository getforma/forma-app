import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/use_case/initialize_sensor_use_case.dart';
import 'package:sensor_component_domain/use_case/start_sensor_discovery_use_case.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/model/session_request.dart';
import 'package:session_component_domain/use_case/create_session_use_case.dart';

part 'main_cubit.freezed.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  final InitializeSensorUseCase _initializeSensorUseCase;
  final StartSensorDiscoveryUseCase _startSensorDiscoveryUseCase;
  final CreateSessionUseCase _createSessionUseCase;

  MainCubit(
    this._initializeSensorUseCase,
    this._startSensorDiscoveryUseCase,
    this._createSessionUseCase,
  ) : super(const MainState());

  Future<void> startDeviceDiscovery() async {
    _initializeSensorUseCase.invoke(EmptyParam());
    _startSensorDiscoveryUseCase.invoke(EmptyParam());

    // TODO: delete after testing
    await _createSessionUseCase.invoke(SessionRequest(
      deviceId: "test",
      devicePosition: SensorPosition.pelvisRight,
      userName: "Alex",
    ));
  }
}
