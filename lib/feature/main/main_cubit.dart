import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forma_app/service/sensor_messages.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'main_cubit.freezed.dart';
part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  final SensorApi _sensorApi = SensorApi();

  MainCubit() : super(const MainState());

  Future<void> startDeviceDiscovery() async {
    _sensorApi.initialize();
    _sensorApi.startDiscovery();
  }
}
