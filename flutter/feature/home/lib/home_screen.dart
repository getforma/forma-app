import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/app_shadows.dart';
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
            ],
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
        border: Border.all(color: AppColors.border),
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
}

class _Typography {
  static final TextStyle scoreNumber = TextStyles.dark.copyWith(
    fontSize: 44,
    fontWeight: FontWeight.w600,
  );
}
