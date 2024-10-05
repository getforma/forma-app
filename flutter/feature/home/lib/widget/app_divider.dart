import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  final double horizontalPadding;
  final Color color;

  const AppDivider({
    super.key,
    this.horizontalPadding = 0,
    this.color = AppColors.pureBlack10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        height: 3.h,
        color: color,
      ),
    );
  }
}
