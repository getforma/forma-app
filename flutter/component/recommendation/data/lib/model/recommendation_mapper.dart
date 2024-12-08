import 'package:core_component_data/database/app_database.dart';
import 'package:core_component_data/database/model/recommendation_table.dart'
    as db;
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:recommendation_component_domain/model/recommendation_type.dart'
    as domain;

extension RecommendationMapper on RecommendationTableData {
  Recommendation toDomain() => Recommendation(
        date: date,
        trainingType: mapRecommendationTypeToDomain(trainingType),
      );

  domain.RecommendationType mapRecommendationTypeToDomain(
      db.RecommendationType type) {
    switch (type) {
      case db.RecommendationType.easy:
        return domain.RecommendationType.easy;
      case db.RecommendationType.long:
        return domain.RecommendationType.long;
      case db.RecommendationType.intervals:
        return domain.RecommendationType.intervals;
      case db.RecommendationType.tempo:
        return domain.RecommendationType.tempo;
      case db.RecommendationType.hills:
        return domain.RecommendationType.hills;
    }
  }
}
