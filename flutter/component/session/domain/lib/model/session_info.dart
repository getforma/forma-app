import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_component_domain/model/sensor_position.dart';

part 'session_info.freezed.dart';
part 'session_info.g.dart';

@freezed
class SessionInfo with _$SessionInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionInfo({
    required DateTime createdAt,
    required String deviceId,
    required SensorPosition devicePosition,
    required String id,
    required String userName,
  }) = _SessionInfo;

  factory SessionInfo.fromJson(Map<String, dynamic> json) =>
      _$SessionInfoFromJson(json);
}
