import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';

part 'recommendation_response.freezed.dart';
part 'recommendation_response.g.dart';

@freezed
class RecommendationResponse with _$RecommendationResponse {
  const RecommendationResponse._();

  const factory RecommendationResponse({
    required List<Recommendation> recommendations,
  }) = _RecommendationResponse;

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseFromJson(json);
}
