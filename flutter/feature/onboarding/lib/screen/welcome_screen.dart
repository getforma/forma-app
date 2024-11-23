import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onboarding_feature/bloc/onboarding_cubit.dart';
import 'package:onboarding_feature/router/onboarding_router.gr.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, OnboardingState state) => Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SafeArea(
          left: false,
          right: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Container()),
              Text(
                S.of(context).onboarding_title,
                style: _Typography.title.sp,
              ),
              16.verticalSpace,
              Text(
                S.of(context).onboarding_description,
                style: _Typography.description.sp,
              ),
              16.verticalSpace,
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(const LoginRoute());
                },
                style: ButtonStyles.fullWidthWhite.sp,
                child: Text(
                  S.of(context).onboarding_get_started,
                  style: TextStyles.darkBold16.sp,
                ),
              ),
              16.verticalSpace,
            ],
          ),
        ),
      );
}

class _Typography {
  static final title = TextStyles.lightExtraBold48.copyWith(height: 1.2);
  static final description =
      TextStyles.lightRegular16.copyWith(height: 21 / 16, letterSpacing: 0);
}
