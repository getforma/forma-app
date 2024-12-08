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
      case RecommendationType.rest:
        return S.of(context).home_training_recommendation_rest;
      case RecommendationType.strength:
        return S.of(context).home_training_recommendation_strength;
      case RecommendationType.cross:
        return S.of(context).home_training_recommendation_cross;
      case RecommendationType.moderate:
        return S.of(context).home_training_recommendation_moderate;
      case RecommendationType.fartlek:
        return S.of(context).home_training_recommendation_fartlek;
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
      case RecommendationType.rest:
        return 'asset/icon/rest.svg';
      case RecommendationType.strength:
        return 'asset/icon/strength.svg';
      case RecommendationType.cross:
        return 'asset/icon/cross.svg';
      case RecommendationType.moderate:
        return 'asset/icon/moderate.svg';
      case RecommendationType.fartlek:
        return 'asset/icon/fartlek.svg';
    }
  }
}
