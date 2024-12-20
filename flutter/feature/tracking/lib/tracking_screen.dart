import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:core_feature/widget/loader_widget.dart';
import 'package:core_feature/widget/partial_circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:forma_app/route/questionnaire_screen_type.dart';
import 'package:get_it/get_it.dart';
import 'package:tracking_feature/bloc/tracking_cubit.dart';
import 'package:tracking_feature/bloc/tracking_screen_status.dart';
import 'package:tracking_feature/model/measurement_card_item.dart';

const _animationDuration = Duration(milliseconds: 200);

@RoutePage()
class TrackingScreen extends StatefulWidget {
  final String sessionId;

  const TrackingScreen({super.key, required this.sessionId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final PageController _pageController = PageController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<TrackingCubit>(param1: widget.sessionId),
      child: BlocConsumer<TrackingCubit, TrackingState>(
        listener: (context, state) async {
          if (state.status == TrackingScreenStatus.stopped) {
            await AutoRouter.of(context).push(
              QuestionnaireRoute(
                type: QuestionnaireScreenType.postRun,
                runningSessionId: widget.sessionId,
              ),
            );
            context.router.maybePop(state.measurementAnalysis);
          }
        },
        builder: (context, state) => Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              _body(context, state),
              Positioned(
                top: 0,
                right: 24.w,
                child: SafeArea(
                  child: Icon(
                    state.isSensorConnected
                        ? Icons.bluetooth_connected
                        : Icons.bluetooth_disabled,
                    color: state.isSensorConnected
                        ? AppColors.appBlack
                        : AppColors.appBlack.withOpacity(0.6),
                  ),
                ),
              ),
              if (state.status == TrackingScreenStatus.loading)
                const Positioned.fill(child: LoaderWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TrackingState state) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            32.verticalSpace,
            _scoreCircle(context, state),
            14.verticalSpace,
            Text(
              S.of(context).tracking_score,
              style: _Typography.scoreTitle.sp,
            ),
            42.verticalSpace,
            _metricsGrid(context, state),
            _metricPageIndicator(),
            16.verticalSpace,
            Container(
              padding: EdgeInsets.only(left: 16.w),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).tracking_tips,
                style: TextStyles.h2BoldDark.sp,
              ),
            ),
            36.verticalSpace,
            Container(
              padding: EdgeInsets.only(left: 16.w),
              alignment: Alignment.centerLeft,
              child: Text(
                state.lastSplitAnalysis?.feedback ?? "",
                style: _Typography.tip.sp,
              ),
            ),
            42.verticalSpace,
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextButton(
                onPressed: () {
                  context.read<TrackingCubit>().stopSession();
                },
                style: ButtonStyles.fullWidthPrimary.sp,
                child: Text(
                  S.of(context).tracking_stop_session.toUpperCase(),
                  style: _Typography.stopSessionButton.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreCircle(BuildContext context, TrackingState state) {
    return SizedBox(
      width: 124.r,
      height: 124.r,
      child: CustomPaint(
        painter: PartialCirclePainter(
          color: AppColors.primaryBlue,
          colorInactive: AppColors.primaryBlue.withOpacity(0.1),
          degree: (state.measurementAnalysis?.score ?? 0) / 100 * 360,
          width: 10.r,
        ),
        child: Center(
          child: Text(
            '${state.measurementAnalysis?.score ?? 0}',
            style: _Typography.score,
          ),
        ),
      ),
    );
  }

  Widget _metricsGrid(BuildContext context, TrackingState state) {
    return SizedBox(
      height: 268.h,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 2,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 25.h,
            crossAxisSpacing: 21.w,
            childAspectRatio: 170.w / 110.h,
            children: MeasurementCardItem.values
                .sublist(index * 4, (index + 1) * 4)
                .map(
                  (cardItem) => _metricCard(
                    cardItem.title(context),
                    cardItem.value(context, state.measurementAnalysis),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }

  Widget _metricCard(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDF2),
        borderRadius: BorderRadius.circular(12).r,
        boxShadow: [
          BoxShadow(
            color: const Color(0x140A0D12),
            blurRadius: 16.r,
            offset: Offset(0, 12.h),
            spreadRadius: -4.r,
          ),
          BoxShadow(
            color: const Color(0x070A0D12),
            blurRadius: 6.r,
            offset: Offset(0, 4.h),
            spreadRadius: -2.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: _Typography.metricTitle.sp,
          ),
          SizedBox(height: 14.h),
          Text(
            value,
            style: _Typography.metricValue.sp,
          ),
        ],
      ),
    );
  }

  Widget _metricPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: _animationDuration,
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: _page == 0
                ? AppColors.primaryBlue
                : AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8).r,
          ),
        ),
        12.horizontalSpace,
        AnimatedContainer(
          duration: _animationDuration,
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: _page == 1
                ? AppColors.primaryBlue
                : AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8).r,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _Typography {
  static final TextStyle score = TextStyles.dark.copyWith(
    fontSize: 55,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle scoreTitle = TextStyles.dark.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle metricTitle = TextStyles.dark.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle metricValue = TextStyles.dark.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle tip = TextStyles.dark.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24.0 / 16.0,
  );

  static final TextStyle stopSessionButton = TextStyles.light.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
