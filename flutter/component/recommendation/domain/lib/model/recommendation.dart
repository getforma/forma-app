import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recommendation_component_domain/model/recommendation_type.dart';

part 'recommendation.freezed.dart';
part 'recommendation.g.dart';

@freezed
class Recommendation with _$Recommendation {
  const Recommendation._();

  const factory Recommendation({
    required DateTime date,
    @JsonKey(
      required: true,
      disallowNullValue: true,
      unknownEnumValue: RecommendationType.easy,
    )
    required RecommendationType trainingType,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}
