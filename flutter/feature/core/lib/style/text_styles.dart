import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class TextStyles {
  static const baseTextStyle = TextStyle(
    fontFamily: 'DM Sans',
    package: 'feature_core',
    height: 1,
  );

  static final light = baseTextStyle.copyWith(color: AppColors.pureWhite);

  static final dark = baseTextStyle.copyWith(color: AppColors.appBlack);

  static final boldLight = light.copyWith(fontWeight: FontWeight.bold);
  static final boldDark = dark.copyWith(fontWeight: FontWeight.bold);

  static final h1Light = light.copyWith(fontSize: 48);
  static final h2Light = light.copyWith(fontSize: 24);
  static final h3Light = light.copyWith(fontSize: 20);
  static final h4Light = light.copyWith(fontSize: 16);
  static final h5Light = light.copyWith(fontSize: 14);
  static final h6Light = light.copyWith(fontSize: 12);

  static final h1Dark = dark.copyWith(fontSize: 48);
  static final h2Dark = dark.copyWith(fontSize: 24);
  static final h3Dark = dark.copyWith(fontSize: 20);
  static final h4Dark = dark.copyWith(fontSize: 16);
  static final h5Dark = dark.copyWith(fontSize: 14);
  static final h6Dark = dark.copyWith(fontSize: 12);

  static final h1BoldLight = boldLight.copyWith(fontSize: 48);
  static final h2BoldLight = boldLight.copyWith(fontSize: 24);
  static final h3BoldLight = boldLight.copyWith(fontSize: 20);
  static final h4BoldLight = boldLight.copyWith(fontSize: 16);
  static final h5BoldLight = boldLight.copyWith(fontSize: 14);
  static final h6BoldLight = boldLight.copyWith(fontSize: 12);

  static final h1BoldDark = boldDark.copyWith(fontSize: 48);
  static final h2BoldDark = boldDark.copyWith(fontSize: 24);
  static final h3BoldDark = boldDark.copyWith(fontSize: 20);
  static final h4BoldDark = boldDark.copyWith(fontSize: 16);
  static final h5BoldDark = boldDark.copyWith(fontSize: 14);
  static final h6BoldDark = boldDark.copyWith(fontSize: 12);

  static final darkBold12 = boldDark.copyWith(fontSize: 12);
  static final darkBold16 = boldDark.copyWith(fontSize: 16);
  static final darkBold20 = boldDark.copyWith(fontSize: 20);

  static final darkRegular12 = dark.copyWith(fontSize: 12);
}

extension TextStyleScaling on TextStyle {
  TextStyle get sp => copyWith(
        fontSize: fontSize?.sp,
        height: height?.h,
        letterSpacing: letterSpacing?.w,
      );
}
