import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final item in NavigationItem.values)
              _item(context, item, item == NavigationItem.home)
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, NavigationItem item, bool isSelected) =>
      SizedBox(
        width: 58.w,
        height: 50.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.icon,
              package: 'core_feature',
              width: 22.r,
              height: 24.r,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.primaryBlue : AppColors.appGrey,
                BlendMode.srcIn,
              ),
            ),
            4.verticalSpace,
            Text(
              item.title(context),
              style: TextStyles.neutralRegular10
                  .copyWith(
                    color:
                        isSelected ? AppColors.primaryBlue : AppColors.appGrey,
                  )
                  .sp,
            ),
          ],
        ),
      );
}

enum NavigationItem {
  home,
  plans,
  stats,
  profile;

  String title(BuildContext context) {
    final translations = S.of(context);
    switch (this) {
      case NavigationItem.home:
        return translations.bottom_navigation_item_home;
      case NavigationItem.plans:
        return translations.bottom_navigation_item_plans;
      case NavigationItem.stats:
        return translations.bottom_navigation_item_stats;
      case NavigationItem.profile:
        return translations.bottom_navigation_item_profile;
    }
  }

  String get icon =>
      'asset/icon/bottom_navigation_item_${name.toLowerCase()}.svg';
}
