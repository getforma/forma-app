import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_feature/bloc/onboarding_cubit.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I.get<OnboardingCubit>()..loadOnboardingCompleted(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.onboardingCompleted) {
            AutoRouter.of(context).replaceAll([const HomeRoute()]);
          }
        },
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(child: _background(context)),
              Positioned.fill(child: _body(context, state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _background(BuildContext context) => Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/background.png',
              package: 'onboarding_feature',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 174.h,
            bottom: -66.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.appBlack.withOpacity(0),
                    AppColors.appBlack,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _body(BuildContext context, OnboardingState state) => Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SafeArea(
          left: false,
          right: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              41.verticalSpace,
              SvgPicture.asset(
                'asset/logo_black.svg',
                package: 'onboarding_feature',
                height: 52.h,
                fit: BoxFit.fitHeight,
              ),
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
                  AutoRouter.of(context).push(const HomeRoute());
                },
                style: ButtonStyles.fullWidthWhite.sp,
                child: Text(
                  S.of(context).onboarding_get_started,
                  style: TextStyles.darkBold16.sp,
                ),
              ),
              21.verticalSpace,
              InkWell(
                onTap: () {
                  AutoRouter.of(context).replaceAll([const HomeRoute()]);
                },
                child: Text(
                  S.of(context).onboarding_log_in,
                  style: TextStyles.lightSemiBold14
                      .copyWith(color: const Color(0xFF4181FE))
                      .sp,
                  textAlign: TextAlign.center,
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
