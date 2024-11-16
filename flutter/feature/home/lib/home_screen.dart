import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/app_shadows.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:core_feature/widget/loader_widget.dart';
import 'package:core_feature/widget/partial_circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:home_feature/bloc/home_cubit.dart';
import 'package:home_feature/bloc/home_status.dart';
import 'package:home_feature/model/recommended_training.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<HomeCubit>()
        ..startDeviceDiscovery()
        ..loadRecommendedTrainings(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          final snackBarText = state.status.text(context);
          if (snackBarText != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(snackBarText)),
            );
            context.read<HomeCubit>().resetStatus();
          }
        },
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              _body(context, state),
              if (state.status == HomeStatus.loading)
                const Positioned.fill(child: LoaderWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, HomeState state) => Container(
        color: AppColors.background,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          left: false,
          right: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                39.verticalSpace,
                _scoreCircle(context, state),
                15.verticalSpace,
                Text(
                  S.of(context).home_score_title,
                  style: TextStyles.darkBold20.sp,
                ),
                32.verticalSpace,
                _recommendationWidget(context, state),
                32.verticalSpace,
                _insightsWidget(context, state),
                48.verticalSpace,
                _buttonsWidget(context),
              ],
            ),
          ),
        ),
      );

  Widget _scoreCircle(BuildContext context, HomeState state) {
    return SizedBox(
      width: 124.r,
      height: 124.r,
      child: CustomPaint(
        painter: PartialCirclePainter(
          color: AppColors.primaryBlue,
          colorInactive: AppColors.primaryBlue.withOpacity(0.1),
          degree: 0.89 * 360,
          width: 10.r,
        ),
        child: Center(
          child: Text(
            '89',
            style: _Typography.scoreNumber.sp,
          ),
        ),
      ),
    );
  }

  Widget _recommendationWidget(BuildContext context, HomeState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border, width: 1.r),
        boxShadow: AppShadows.primary,
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).home_training_recommendation_title,
            style: TextStyles.darkBold16.sp,
          ),
          22.verticalSpace,
          Row(
            children: [
              ...state.recommendedTrainings
                  .expand((e) => [
                        _recommendationItem(context, e),
                        5.horizontalSpace,
                      ])
                  .toList(growable: false),
              const Expanded(child: SizedBox()),
              SvgPicture.asset(
                "asset/icon/chevron_right.svg",
                package: 'core_feature',
                width: 24.r,
                height: 24.r,
              ),
            ],
          ),
          5.verticalSpace,
        ],
      ),
    );
  }

  Widget _recommendationItem(
      BuildContext context, RecommendedTraining training) {
    return SizedBox(
      width: 52.w,
      height: 76.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(training.day, style: TextStyles.darkBold12.sp),
          const Expanded(child: SizedBox()),
          SvgPicture.asset(
            training.type.icon,
            package: 'home_feature',
            width: 24.r,
            height: 24.r,
            colorFilter: const ColorFilter.mode(
              AppColors.appBlack,
              BlendMode.srcIn,
            ),
          ),
          4.verticalSpace,
          Text(
            training.type.text(context),
            style: TextStyles.darkRegular12.sp,
          ),
        ],
      ),
    );
  }

  Widget _insightsWidget(BuildContext context, HomeState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S.of(context).home_insights_title,
            style: TextStyles.darkBold20.sp,
          ),
          16.verticalSpace,
          _insightsItem("You are heel striking",
              "Next time focus on striking with your forefoot", true),
          16.verticalSpace,
          _insightsItem(
              "Lean forward",
              "Leaning forward will help you with forefoot striking and will improve your running economics",
              false),
          16.verticalSpace,
          _upgradeToProWidget(context),
        ],
      );

  Widget _insightsItem(String title, String description, bool isOdd) {
    return Container(
      height: 84.h,
      decoration: BoxDecoration(
        color: isOdd ? AppColors.appBlack : AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: isOdd
            ? null
            : Border.all(
                color: AppColors.border,
                width: 1.r,
              ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: isOdd
                ? TextStyles.lightSemiBold16.sp
                : TextStyles.darkSemiBold16.sp,
          ),
          4.verticalSpace,
          Text(
            description,
            style: isOdd
                ? TextStyles.lightMedium10.sp
                : TextStyles.darkMedium10.sp,
          ),
        ],
      ),
    );
  }

  Widget _upgradeToProWidget(BuildContext context) => Container(
        height: 84.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [
              AppColors.pureWhite,
              Colors.grey.shade500,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).home_insights_upgrade_pro_title,
              style: TextStyles.darkSemiBold16.sp,
            ),
            4.verticalSpace,
            Text(
              S.of(context).home_insights_upgrade_pro_description,
              style: TextStyles.darkMedium10.sp,
            ),
          ],
        ),
      );

  Widget _buttonsWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().startSession();
            },
            style: ButtonStyles.fullWidthPrimary.sp,
            child: Text(
              S.of(context).home_start_session.toUpperCase(),
              style: TextStyles.lightBold16.sp,
            ),
          ),
          16.verticalSpace,
          TextButton(
            onPressed: () {},
            style: ButtonStyles.fullWidthWhite.sp,
            child: Text(
              S.of(context).home_button_feeling,
              style: TextStyles.darkBold16.sp,
            ),
          ),
        ],
      );
}

class _Typography {
  static final TextStyle scoreNumber = TextStyles.dark.copyWith(
    fontSize: 44,
    fontWeight: FontWeight.w600,
  );
}
