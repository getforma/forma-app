import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';

enum QuestionnaireScreenType {
  onboarding,
  postRun,
  checkup;

  String title(BuildContext context) {
    final translations = S.of(context);
    return switch (this) {
      QuestionnaireScreenType.onboarding =>
        translations.questionnaire_title_onboarding,
      QuestionnaireScreenType.postRun =>
        translations.questionnaire_title_post_run,
      QuestionnaireScreenType.checkup =>
        translations.questionnaire_title_checkup,
    };
  }

  QuestionnaireType toDomain() {
    return switch (this) {
      QuestionnaireScreenType.onboarding => QuestionnaireType.onboarding,
      QuestionnaireScreenType.postRun => QuestionnaireType.post_run,
      QuestionnaireScreenType.checkup => QuestionnaireType.checkup,
    };
  }
}
