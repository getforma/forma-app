import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/material.dart';

enum QuestionnaireType {
  onboarding,
  postRun,
  checkup;

  String title(BuildContext context) {
    final translations = S.of(context);
    return switch (this) {
      QuestionnaireType.onboarding =>
        translations.questionnaire_title_onboarding,
      QuestionnaireType.postRun => translations.questionnaire_title_post_run,
      QuestionnaireType.checkup => translations.questionnaire_title_checkup,
    };
  }
}
