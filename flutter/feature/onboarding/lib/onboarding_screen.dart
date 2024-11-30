import 'package:auto_route/auto_route.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_feature/bloc/onboarding_cubit.dart';
import 'package:onboarding_feature/bloc/onboarding_stage.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => GetIt.I.get<OnboardingCubit>()..initialLoad(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<OnboardingCubit, OnboardingState>(
              listenWhen: (previous, current) =>
                  previous.stage != current.stage,
              listener: (context, state) {
                if (state.stage == OnboardingStage.enterSmsCode) {
                  AutoRouter.of(context).push(const VerificationCodeRoute());
                }
              },
            ),
            BlocListener<OnboardingCubit, OnboardingState>(
              listener: (context, state) {
                if (state.status == OnboardingStatus.logInSuccess ||
                    (state.onboardingCompleted && state.isUserSignedIn)) {
                  AutoRouter.of(context).replaceAll([const HomeRoute()]);
                }

                final errorText = state.error?.text(context);
                if (errorText != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorText)),
                  );
                  context.read<OnboardingCubit>().resetError();
                }
              },
            ),
          ],
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) => Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(child: _background(context)),
                const Positioned.fill(child: AutoRouter()),
                if (state.status == OnboardingStatus.loading)
                  const Positioned.fill(child: LoaderWidget()),
              ],
            ),
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
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SafeArea(
              left: false,
              right: false,
              child: Padding(
                padding: EdgeInsets.only(top: 41.w),
                child: SvgPicture.asset(
                  'asset/logo_black.svg',
                  package: 'onboarding_feature',
                  height: 52.h,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ],
      );
}
