import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppShadows {
  static final List<BoxShadow> primary = [
    BoxShadow(
      color: const Color.fromARGB(20, 10, 13, 18),
      blurRadius: 16.r,
      offset: Offset(0, 12.r),
      spreadRadius: -4.r,
    ),
    BoxShadow(
      color: const Color.fromARGB(7, 10, 13, 18),
      blurRadius: 6.r,
      offset: Offset(0, 4.r),
      spreadRadius: -2.r,
    ),
  ];
}
