import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forma_app/generated/l10n.dart';
import 'package:forma_app/styles/app_colors.dart';
import 'package:forma_app/styles/button_styles.dart';
import 'package:forma_app/styles/text_styles.dart';
import 'package:forma_app/widget/app_divider.dart';

const _kFormPercentages = [60, 55, 62, 71];

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        leading: const Icon(
          Icons.menu,
          color: AppColors.pureWhite,
        ),
        actions: [
          const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.pureWhite,
          ),
          16.horizontalSpace,
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) => Stack(
        children: [
          _background(context),
          _content(context),
        ],
      );

  Widget _background(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 0.5.sh,
            color: AppColors.primaryBlue,
          ),
          Container(
            height: 0.5.sh,
            color: AppColors.primaryBlack,
          ),
        ],
      );

  Widget _content(BuildContext context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).app_name,
                style: TextStyles.h1BoldLight.sp,
              ),
              0.2.sh.verticalSpace,
              _lastActivities(context),
              16.verticalSpace,
              _tryPremium(context),
            ],
          ),
        ),
      );

  Widget _lastActivities(BuildContext context) => Card(
        elevation: 8,
        color: AppColors.pureWhite,
        surfaceTintColor: AppColors.pureWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32).w,
              child: Text(
                S.of(context).home_scores,
                style: TextStyles.h2BoldDark.sp,
              ),
            ),
            4.verticalSpace,
            _subHeading(context),
            16.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32).w,
              child: Row(
                  children: _kFormPercentages
                      .expandIndexed((index, percentage) => [
                            if (index != 0) 16.horizontalSpace,
                            _percentageItem(
                              context,
                              percentage,
                              index == 0 ||
                                  _kFormPercentages[index - 1] < percentage,
                            ),
                          ])
                      .toList(growable: false)),
            ),
            24.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32).w,
              child: Text(
                S.of(context).home_card_action_description,
                style: TextStyles.homeCardActionDescription.sp,
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).w,
              child: TextButton(
                style: ButtonStyles.fullWidthOrange,
                onPressed: () {},
                child: Text(
                  S.of(context).home_start,
                  style: TextStyles.h3BoldLight.sp,
                ),
              ),
            ),
            16.verticalSpace,
          ],
        ),
      );

  Widget _subHeading(BuildContext context) => Row(
        children: [
          const SizedBox(width: 28, child: AppDivider()),
          4.horizontalSpace,
          Text(
            S.of(context).home_last_days,
            style: TextStyles.homeCardSubheading.sp,
          ),
          4.horizontalSpace,
          const Expanded(child: AppDivider()),
        ],
      );

  Widget _percentageItem(
          BuildContext context, int percentage, bool isTrendingUp) =>
      Container(
        width: 48.w,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.pureBlack10),
          color: AppColors.pureWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4).h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                percentage.toString(),
                style: TextStyles.h4BoldDark.sp,
              ),
              Icon(
                isTrendingUp ? Icons.trending_up : Icons.trending_down,
                size: 16.r,
                color: isTrendingUp ? AppColors.green : AppColors.red,
              ),
            ],
          ),
        ),
      );

  Widget _tryPremium(BuildContext context) => Card(
        elevation: 8,
        color: AppColors.blueGrey100,
        surfaceTintColor: AppColors.blueGrey100,
        child: SizedBox(
          height: 128.h,
          child: Stack(
            children: [
              Positioned(
                right: 20,
                top: -10,
                bottom: -20,
                child: Image.asset("assets/bg_home_premium_2.png"),
              ),
              Container(
                width: 1.sw,
                padding: const EdgeInsets.symmetric(horizontal: 32).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,
                    Text(
                      S.of(context).home_try,
                      style: TextStyles.homePremiumSupheader.sp,
                    ),
                    2.verticalSpace,
                    Text(
                      S.of(context).home_premium,
                      style: TextStyles.h3BoldDark.sp,
                    ),
                    const Spacer(),
                    Container(
                      width: 128.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).home_7_days_free,
                          style: TextStyles.h6BoldLight.sp,
                        ),
                      ),
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
