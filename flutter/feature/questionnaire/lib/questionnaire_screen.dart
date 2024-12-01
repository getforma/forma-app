import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_colors.dart';
import 'package:core_feature/style/button_styles.dart';
import 'package:core_feature/style/text_styles.dart';
import 'package:core_feature/widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:questionnaire_feature/bloc/questionnaire_cubit.dart';
import 'package:forma_app/route/questionnaire_type.dart';

@RoutePage()
class QuestionnaireScreen extends StatelessWidget {
  final QuestionnaireType type;
  const QuestionnaireScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => GetIt.I.get<QuestionnaireCubit>(),
        child: BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
          builder: (context, state) => Stack(
            fit: StackFit.expand,
            children: [
              _body(context, state),
              if (state.status == QuestionnaireStatus.loading)
                const Positioned.fill(child: LoaderWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, QuestionnaireState state) {
    return SafeArea(
      left: false,
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          32.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              type.title(context),
              style: TextStyles.darkBold28.sp,
            ),
          ),
          48.verticalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: SizedBox(),
            ),
          ),
          32.verticalSpace,
          _pagerIndicator(context, state),
          32.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextButton(
              onPressed: () {},
              style: ButtonStyles.fullWidthBlack.sp,
              child: Text(
                S.of(context).questionnaire_next,
                style: TextStyles.lightBold16.sp,
              ),
            ),
          ),
          32.verticalSpace,
        ],
      ),
    );
  }

  Widget _pagerIndicator(BuildContext context, QuestionnaireState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [0, 1, 2, 3, 4]
          .expandIndexed((index, item) => [
                if (index != 0) 8.horizontalSpace,
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color:
                        index == 0 ? AppColors.appBlack : AppColors.pureWhite,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade500,
                      width: 0.5.r,
                    ),
                  ),
                ),
              ])
          .toList(growable: false),
    );
  }
}
