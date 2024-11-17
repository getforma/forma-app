import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding_feature/bloc/onboarding_cubit.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<OnboardingCubit>(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              _background(context),
              _body(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _background(BuildContext context) => Expanded(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'asset/onboarding_background.png',
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
        ),
      );

  Widget _body(BuildContext context, OnboardingState state) => Container(
        color: AppColors.background,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          left: false,
          right: false,
          child: Container(),
        ),
      );
}
