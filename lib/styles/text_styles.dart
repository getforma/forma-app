import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forma_app/styles/app_colors.dart';

class TextStyles {
  static const _poppins = 'Poppins';
  static const _presentation = 'presentation';

  static const baseTextStyle =
      TextStyle(fontFamily: _poppins, package: _presentation);

  static final light = baseTextStyle.copyWith(color: AppColors.pureWhite);

  static final dark = baseTextStyle.copyWith(color: AppColors.pureBlack);

  static final boldLight = light.copyWith(fontWeight: FontWeight.bold);

  static final h1BoldLight = boldLight.copyWith(fontSize: 48);
}

extension TextStyleScaling on TextStyle {
  TextStyle get sp => copyWith(
        fontSize: fontSize?.sp,
        height: height?.h,
        letterSpacing: letterSpacing?.w,
      );
}
