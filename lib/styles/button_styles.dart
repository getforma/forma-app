import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forma_app/styles/app_colors.dart';
import 'package:forma_app/styles/text_styles.dart';

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
}

extension TextButtonScaling on ButtonStyle {
  ButtonStyle get sp {
    EdgeInsetsGeometry? padding =
        this.padding?.resolve(MaterialState.values.toSet());
    Size? minimumSize = this.minimumSize?.resolve(MaterialState.values.toSet());
    Size? maximumSize = this.maximumSize?.resolve(MaterialState.values.toSet());
    Size? fixedSize = this.fixedSize?.resolve(MaterialState.values.toSet());
    TextStyle? textStyle =
        this.textStyle?.resolve(MaterialState.values.toSet());

    return copyWith(
      padding: padding == null
          ? null
          : MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                  horizontal: padding.horizontal.w,
                  vertical: padding.vertical.h),
            ),
      minimumSize: minimumSize == null
          ? null
          : MaterialStatePropertyAll(
              Size(minimumSize.width.w, minimumSize.height.h)),
      maximumSize: maximumSize == null
          ? null
          : MaterialStatePropertyAll(
              Size(maximumSize.width.w, maximumSize.height.h)),
      fixedSize: fixedSize == null
          ? null
          : MaterialStatePropertyAll(
              Size(fixedSize.width.w, fixedSize.height.h)),
      textStyle:
          textStyle == null ? null : MaterialStatePropertyAll(textStyle.sp),
    );
  }
}
