import 'dart:io';

import 'package:recommendation_component_data/recommendation_service.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecommendationDataSource {
  final RecommendationService _recommendationService;

  RecommendationDataSource(this._recommendationService);

  Future<List<Recommendation>> getRecommendations() async {
    final response = await _recommendationService.getRecommendation();
    if (response.response.statusCode == HttpStatus.ok) {
      return response.data.recommendations;
    }
    throw Exception();
  }
}
