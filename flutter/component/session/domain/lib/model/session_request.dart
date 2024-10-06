import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_component_domain/model/sensor_position.dart';

part 'session_request.freezed.dart';
part 'session_request.g.dart';

@freezed
class SessionRequest with _$SessionRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionRequest({
    required String deviceId,
    required SensorPosition devicePosition,
    required String userName,
  }) = _SessionRequest;

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);
}
