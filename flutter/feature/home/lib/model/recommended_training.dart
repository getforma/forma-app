import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recommendation_component_domain/model/recommendation.dart';
import 'package:recommendation_component_domain/model/recommendation_type.dart';

extension RecommendedTrainingUI on Recommendation {
  String get day => DateFormat('EEE').format(date);
}

extension RecommendedTrainingTypeUI on RecommendationType {
  String text(BuildContext context) {
    switch (this) {
      case RecommendationType.easy:
        return S.of(context).home_training_recommendation_easy;
      case RecommendationType.long:
        return S.of(context).home_training_recommendation_long;
      case RecommendationType.intervals:
        return S.of(context).home_training_recommendation_intervals;
      case RecommendationType.tempo:
        return S.of(context).home_training_recommendation_tempo;
      case RecommendationType.hills:
        return S.of(context).home_training_recommendation_hills;
    }
  }

  String get icon {
    switch (this) {
      case RecommendationType.easy:
        return 'asset/icon/easy.svg';
      case RecommendationType.long:
        return 'asset/icon/long.svg';
      case RecommendationType.intervals:
        return 'asset/icon/intervals.svg';
      case RecommendationType.tempo:
        return 'asset/icon/tempo.svg';
      case RecommendationType.hills:
        return 'asset/icon/hills.svg';
    }
  }
}
