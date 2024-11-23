import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input_v2/intl_phone_number_input.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 32.w, right: 32.w),
              child: Text(
                S.of(context).login_title,
                style: TextStyles.darkBold32.copyWith(fontSize: 30).sp,
              ),
            ),
            64.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: InternationalPhoneNumberInput(
                onInputChanged: (value) {},
              ),
            ),
            64.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyles.fullWidthBlack.sp,
                child: Text(
                  S.of(context).login_submit_button,
                  style: TextStyles.lightBold16.sp,
                ),
              ),
            ),
            40.verticalSpace,
            _alternativeLoginText(context),
            32.verticalSpace,
            _alternativeLoginButtons(context),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _alternativeLoginText(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              height: 1.h,
              color: AppColors.appGrey,
            )),
            Text(
              S.of(context).login_alternative_login,
              style: TextStyles.darkRegular16
                  .copyWith(color: AppColors.appGrey)
                  .sp,
            ),
            Expanded(
                child: Container(
              height: 1.h,
              color: AppColors.appGrey,
            )),
          ],
        ),
      );

  Widget _alternativeLoginButtons(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 72.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "asset/icon/google.svg",
              package: "onboarding_feature",
              width: 32.r,
              height: 32.r,
            ),
            SvgPicture.asset(
              "asset/icon/apple.svg",
              package: "onboarding_feature",
              width: 32.r,
              height: 32.r,
            ),
            SvgPicture.asset(
              "asset/icon/facebook.svg",
              package: "onboarding_feature",
              width: 32.r,
              height: 32.r,
            ),
          ],
        ),
      );
}
