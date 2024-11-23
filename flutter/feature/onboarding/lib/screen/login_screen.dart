import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input_v2/intl_phone_number_input.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Container()),
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 32.w, right: 32.w),
              child: Text(
                S.of(context).login_title,
                style: TextStyles.lightBold32.copyWith(fontSize: 30).sp,
              ),
            ),
            86.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                ),
                child: InternationalPhoneNumberInput(
                  textStyle: TextStyles.darkRegular16.sp,
                  selectorTextStyle: TextStyles.darkRegular16.sp,
                  autoValidateMode: AutovalidateMode.always,
                  inputDecoration: const InputDecoration(
                    filled: false,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  searchBoxDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    hintStyle: TextStyles.darkRegular16
                        .copyWith(color: AppColors.appGrey)
                        .sp,
                    labelStyle: TextStyles.darkRegular16.sp,
                    hintText: S.of(context).login_search_hint,
                  ),
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    showFlags: false,
                    trailingSpace: false,
                    useBottomSheetSafeArea: true,
                  ),
                  onInputChanged: (value) {},
                ),
              ),
            ),
            86.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyles.fullWidthWhite.sp,
                child: Text(
                  S.of(context).login_submit_button,
                  style: TextStyles.darkBold16.sp,
                ),
              ),
            ),
            40.verticalSpace,
            _alternativeLoginText(context),
            32.verticalSpace,
            _alternativeLoginButtons(context),
            32.verticalSpace,
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
              color: AppColors.appGreyLight,
            )),
            16.horizontalSpace,
            Text(
              S.of(context).login_alternative_login,
              style: TextStyles.darkRegular16
                  .copyWith(color: AppColors.appGreyLight)
                  .sp,
            ),
            16.horizontalSpace,
            Expanded(
                child: Container(
              height: 1.h,
              color: AppColors.appGreyLight,
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
