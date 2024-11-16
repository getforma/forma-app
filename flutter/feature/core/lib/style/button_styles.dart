import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_styles.dart';

class ButtonStyles {
  static final wideOrange = TextButton.styleFrom(
    backgroundColor: AppColors.accentOrange,
    padding: const EdgeInsets.symmetric(horizontal: 46),
    alignment: Alignment.center,
    minimumSize: const Size(100, 53),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
  );

  static final fullWidthOrange = TextButton.styleFrom(
    backgroundColor: AppColors.accentOrange,
    alignment: Alignment.center,
    minimumSize: const Size(100, 53),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
  );

  static final fullWidthPrimary = TextButton.styleFrom(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: AppColors.pureWhite,
    alignment: Alignment.center,
    minimumSize: const Size(100, 52),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  );

  static final fullWidthWhite = TextButton.styleFrom(
    backgroundColor: AppColors.pureWhite,
    foregroundColor: AppColors.appBlack,
    alignment: Alignment.center,
    minimumSize: const Size(100, 52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: const BorderSide(color: AppColors.border),
    ),
  );
}

extension TextButtonScaling on ButtonStyle {
  ButtonStyle get sp {
    EdgeInsetsGeometry? padding =
        this.padding?.resolve(WidgetState.values.toSet());
    Size? minimumSize = this.minimumSize?.resolve(WidgetState.values.toSet());
    Size? maximumSize = this.maximumSize?.resolve(WidgetState.values.toSet());
    Size? fixedSize = this.fixedSize?.resolve(WidgetState.values.toSet());
    TextStyle? textStyle = this.textStyle?.resolve(WidgetState.values.toSet());

    return copyWith(
      padding: padding == null
          ? null
          : WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                  horizontal: padding.horizontal.w,
                  vertical: padding.vertical.h),
            ),
      minimumSize: minimumSize == null
          ? null
          : WidgetStatePropertyAll(
              Size(minimumSize.width.w, minimumSize.height.h)),
      maximumSize: maximumSize == null
          ? null
          : WidgetStatePropertyAll(
              Size(maximumSize.width.w, maximumSize.height.h)),
      fixedSize: fixedSize == null
          ? null
          : WidgetStatePropertyAll(Size(fixedSize.width.w, fixedSize.height.h)),
      textStyle:
          textStyle == null ? null : WidgetStatePropertyAll(textStyle.sp),
    );
  }
}
