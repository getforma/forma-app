import 'package:recommendation_component_data/recommendation_service.dart';

import 'package:injectable/injectable.dart';

@injectable
class RecommendationDataSource {
  final RecommendationService _recommendationService;

  RecommendationDataSource(this._recommendationService);
}
