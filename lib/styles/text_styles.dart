import 'package:flutter/material.dart';
import 'package:forma_app/styles/app_colors.dart';

class TextStyles {
  static const _poppins = 'Poppins';
  static const _presentation = 'presentation';

  static const baseTextStyle =
      TextStyle(fontFamily: _poppins, package: _presentation);

  static final lightTextStyle =
      baseTextStyle.copyWith(color: AppColors.pureWhite);

  static final darkTextStyle =
      baseTextStyle.copyWith(color: AppColors.pureBlack);
}
