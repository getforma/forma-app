import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onboarding_feature/bloc/onboarding_cubit.dart';

@RoutePage()
class EnterUserDetailsScreen extends StatefulWidget {
  const EnterUserDetailsScreen({super.key});

  @override
  State<EnterUserDetailsScreen> createState() => _EnterUserDetailsScreenState();
}

class _EnterUserDetailsScreenState extends State<EnterUserDetailsScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
            left: false,
            right: false,
            child: InkWell(
              enableFeedback: false,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 2, child: Container()),
                  32.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 32.w, right: 64.w),
                    child: Text(
                      S.of(context).login_enter_user_details_title,
                      style: TextStyles.lightBold32.sp,
                    ),
                  ),
                  86.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: S.of(context).login_enter_email,
                        fillColor: AppColors.pureWhite,
                        filled: false,
                        labelStyle: TextStyles.lightRegular16.sp,
                      ),
                      style: TextStyles.lightRegular16.sp,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: S.of(context).login_enter_name,
                        fillColor: AppColors.pureWhite,
                        filled: false,
                        labelStyle: TextStyles.lightRegular16.sp,
                      ),
                      style: TextStyles.lightRegular16.sp,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  86.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _nameController.text.isEmpty) {
                          return;
                        }
                        context.read<OnboardingCubit>().saveUserDetails(
                              _emailController.text,
                              _nameController.text,
                            );
                      },
                      style: ButtonStyles.fullWidthWhite.sp,
                      child: Text(
                        S.of(context).login_submit_button,
                        style: TextStyles.darkBold16.sp,
                      ),
                    ),
                  ),
                  32.verticalSpace,
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
