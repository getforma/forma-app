import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: SizedBox(
              width: 64.r,
              height: 64.r,
              child: const CircularProgressIndicator(
                  color: AppColors.accentOrange))),
    );
  }
}
