import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forma_app/generated/l10n.dart';
import 'package:forma_app/styles/app_colors.dart';
import 'package:forma_app/styles/text_styles.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) => Stack(
        children: [
          _background(context),
          _topSection(context),
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

  Widget _topSection(BuildContext context) => SizedBox(
        height: 0.5.sh,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).app_name,
                  style: TextStyles.h1BoldLight.sp,
                ),
              ],
            ),
          ),
        ),
      );
}
