import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/usecase/get_sensor_data_use_case.dart';

part 'main_cubit.freezed.dart';
part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  // final SensorApi _sensorApi = SensorApi();

  MainCubit() : super(const MainState());

  Future<void> startDeviceDiscovery() async {
    // _sensorApi.initialize();
    // _sensorApi.startDiscovery();
  }
}
