import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_feature/bloc/onboarding_cubit.dart';
import 'package:onboarding_feature/widget/pin_code_input_widget.dart';

@RoutePage()
class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
            left: false,
            right: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.only(left: 32.w, right: 64.w),
                  child: Text(
                    S.of(context).login_verification_code_title,
                    style: TextStyles.lightBold32.sp,
                  ),
                ),
                PinCodeInputWidget(
                  focusNode: FocusNode(),
                  onFill: (value) {
                    if (value.length == 6) {
                      context.read<OnboardingCubit>().verifySmsCode(value);
                    }
                  },
                  isInvalid: false,
                ),
                128.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
