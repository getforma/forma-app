import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/use_case/initialize_sensor_use_case.dart';
import 'package:core_component_domain/use_case/use_case.dart';

part 'main_cubit.freezed.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  final InitializeSensorUseCase _initializeSensorUseCase;

  MainCubit(this._initializeSensorUseCase) : super(const MainState());

  Future<void> startDeviceDiscovery() async {
    _initializeSensorUseCase.invoke(EmptyParam());
    // _sensorApi.startDiscovery();
  }
}
