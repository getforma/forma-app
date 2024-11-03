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
    return SafeArea(
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

          // Metrics grid section
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Placeholder(), // Distance
                Placeholder(), // Avg Pace
                Placeholder(), // Vertical oscillation
                Placeholder(), // Cadence
              ],
            ),
          ),

          // Tips section
          const Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tips'),
                SizedBox(height: 8),
                Placeholder(), // Will be replaced with tips content
              ],
            ),
          ),

          // Stop button
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Placeholder(
                fallbackHeight: 48), // Will be replaced with stop button
          ),
        ],
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
}

class _Typography {
  static final TextStyle score = TextStyles.dark.copyWith(
    fontSize: 55,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle scoreTitle = TextStyles.dark.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
}
