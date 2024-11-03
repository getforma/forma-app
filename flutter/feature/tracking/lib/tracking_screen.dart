import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:tracking_feature/bloc/tracking_cubit.dart';
import 'package:tracking_feature/widget/partial_circle_painter.dart';

@RoutePage()
class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<TrackingCubit>(),
      child: BlocConsumer<TrackingCubit, TrackingState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TrackingState state) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            48.verticalSpace,
            _scoreCircle(context, state),
            14.verticalSpace,
            Text(
              S.of(context).tracking_score,
              style: _Typography.scoreTitle.sp,
            ),
            42.verticalSpace,
            _metricsGrid(context, state),
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
          degree: 0.89 * 360,
          width: 10.r,
        ),
        child: Center(
          child: Text(
            '89',
            style: _Typography.score,
          ),
        ),
      ),
    );
  }

  Widget _metricsGrid(BuildContext context, TrackingState state) {
    return Flexible(
      child: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 25.h,
            crossAxisSpacing: 21.w,
            childAspectRatio: 170.w / 110.h,
            children: const [
              Placeholder(),
              Placeholder(),
              Placeholder(),
              Placeholder(),
            ],
          ),
        ),
      ),
    );
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
}