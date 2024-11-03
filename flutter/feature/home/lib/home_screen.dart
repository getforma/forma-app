import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:core_feature/widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:home_feature/bloc/home_cubit.dart';
import 'package:home_feature/bloc/home_status.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:forma_app/route/app_router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<HomeCubit>()..startDeviceDiscovery(),
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
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const Icon(
              Icons.menu,
              color: AppColors.pureWhite,
            ),
            actions: [
              Icon(
                state.isSensorConnected
                    ? Icons.bluetooth_connected
                    : Icons.bluetooth_disabled,
                color: AppColors.pureWhite,
              ),
              16.horizontalSpace,
            ],
          ),
          body: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, HomeState state) => Stack(
        children: [
          _background(context),
          _content(context, state),
          if (state.status == HomeStatus.loading)
            const Positioned.fill(child: LoaderWidget()),
        ],
      );

  Widget _background(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 0.82.sh,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.primaryBlueDark],
                transform: GradientRotation(math.pi / 8),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.primaryBlack,
            ),
          ),
        ],
      );

  Widget _content(BuildContext context, HomeState state) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._form(context, state),
              64.verticalSpace,
              ..._measurementAnalysis(context, state),
              Expanded(child: Container()),
              _startSessionButton(context, state),
              32.verticalSpace,
            ],
          ),
        ),
      );

  List<Widget> _form(BuildContext context, HomeState state) => [
        TextField(
          style: TextStyles.h3Light.sp,
          decoration: InputDecoration(
            focusColor: AppColors.accentOrange,
            label: Text(
              "Name",
              style: TextStyles.h4Light.sp,
            ),
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            context.read<HomeCubit>().updateUserName(value);
          },
        ),
        32.verticalSpace,
        DropdownMenu<SensorPosition>(
            initialSelection: SensorPosition.pelvisRight,
            label: Text(
              'Sensor position',
              style: TextStyles.h4Light.sp,
            ),
            textStyle: TextStyles.h4Light.sp,
            dropdownMenuEntries: SensorPosition.values
                .map((position) => DropdownMenuEntry(
                      value: position,
                      label: position.name,
                    ))
                .toList(growable: false),
            onSelected: (value) {
              context.read<HomeCubit>().updateSensorPosition(value);
            }),
      ];

  List<Widget> _measurementAnalysis(BuildContext context, HomeState state) {
    final analysis = state.measurementAnalysis;
    final translations = S.of(context);

    return [
      Text(translations.home_last_measurement, style: TextStyles.h3Light.sp),
      32.verticalSpace,
      _measurementAnalysisItem(translations.home_cadence, analysis?.cadence),
      8.verticalSpace,
      _measurementAnalysisItem(translations.home_distance, analysis?.distance),
      8.verticalSpace,
      _measurementAnalysisItem(
          translations.home_ground_contact_time, analysis?.groundContactTime),
      8.verticalSpace,
      _measurementAnalysisItem(translations.home_pace, analysis?.pace),
      8.verticalSpace,
      _measurementAnalysisItem(translations.home_speed, analysis?.speed),
      8.verticalSpace,
      _measurementAnalysisItem(
          translations.home_stride_length, analysis?.strideLength),
      8.verticalSpace,
      _measurementAnalysisItem(translations.home_vertical_oscillation,
          analysis?.verticalOscillation),
    ];
  }

  Widget _measurementAnalysisItem(String label, double? value) =>
      Text("$label:\t$value", style: TextStyles.h5Light.sp);

  Widget _startSessionButton(BuildContext context, HomeState state) => Center(
        child: SizedBox(
          width: 0.7.sw,
          child: TextButton(
              onPressed: () {
                AutoRouter.of(context).push(const TrackingRoute());
                // if (state.isSessionRecordingActive) {
                //   context.read<HomeCubit>().stopSession();
                //   return;
                // }
                // context.read<HomeCubit>().startSession();
              },
              style: ButtonStyles.fullWidthOrange.sp,
              child: Text(state.isSessionRecordingActive
                  ? S.of(context).home_stop_session
                  : S.of(context).home_start_session)),
        ),
      );
}
