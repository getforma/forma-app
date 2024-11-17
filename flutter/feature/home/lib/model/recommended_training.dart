import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'recommended_training.freezed.dart';

@freezed
class RecommendedTraining with _$RecommendedTraining {
  const RecommendedTraining._();

  const factory RecommendedTraining({
    required DateTime date,
    required RecommendedTrainingType type,
  }) = _RecommendedTraining;

  String get day => DateFormat('EEE').format(date);
}

enum RecommendedTrainingType {
  easy,
  long,
  intervals,
  rest;

  String text(BuildContext context) {
    switch (this) {
      case RecommendedTrainingType.easy:
        return S.of(context).home_training_recommendation_easy;
      case RecommendedTrainingType.long:
        return S.of(context).home_training_recommendation_long;
      case RecommendedTrainingType.intervals:
        return S.of(context).home_training_recommendation_intervals;
      case RecommendedTrainingType.rest:
        return S.of(context).home_training_recommendation_rest;
    }
  }

  String get icon {
    switch (this) {
      case RecommendedTrainingType.easy:
        return 'asset/icon/easy.svg';
      case RecommendedTrainingType.long:
        return 'asset/icon/long.svg';
      case RecommendedTrainingType.intervals:
        return 'asset/icon/intervals.svg';
      case RecommendedTrainingType.rest:
        return 'asset/icon/rest.svg';
    }
  }
}
