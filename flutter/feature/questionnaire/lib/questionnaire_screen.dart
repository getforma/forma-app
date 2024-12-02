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
import 'package:forma_app/route/questionnaire_screen_type.dart';
import 'package:get_it/get_it.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';
import 'package:questionnaire_feature/bloc/questionnaire_cubit.dart';

@RoutePage()
class QuestionnaireScreen extends StatefulWidget {
  final QuestionnaireScreenType type;

  const QuestionnaireScreen({super.key, required this.type});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) =>
            GetIt.I.get<QuestionnaireCubit>()..loadQuestionnaire(),
        child: BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
          listener: (context, state) {
            final snackBarText = state.error?.text(context);
            if (snackBarText != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(snackBarText)),
              );
              context.read<QuestionnaireCubit>().resetError();
            }
          },
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
              widget.type.title(context),
              style: TextStyles.darkBold28.sp,
            ),
          ),
          48.verticalSpace,
          Expanded(
            child: _questionnaire(context, state),
          ),
          _pagerIndicator(context, state),
          24.verticalSpace,
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
      children: state.questionnaire?.questions
              .expandIndexed((index, question) => [
                    if (index != 0) 8.horizontalSpace,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: index == _currentPage
                            ? AppColors.appBlack
                            : AppColors.pureWhite,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade500,
                          width: 0.5.r,
                        ),
                      ),
                    ),
                  ])
              .toList(growable: false) ??
          [],
    );
  }

  Widget _questionnaire(BuildContext context, QuestionnaireState state) {
    return PageView.builder(
      controller: _controller,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemCount: state.questionnaire?.questions.length ?? 0,
      itemBuilder: (context, index) {
        final question = state.questionnaire?.questions[index];
        if (question == null) {
          return const SizedBox();
        }

        final selectedAnswers = state.answers[question.id];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(question.label, style: TextStyles.darkMedium18.sp),
              16.verticalSpace,
              const Expanded(child: SizedBox()),
              ...question.options.expandIndexed((index, option) => [
                    if (index != 0) 16.verticalSpace,
                    _option(
                      option,
                      selectedAnswers?.contains(option.id) == true,
                      (answerId) {
                        context.read<QuestionnaireCubit>().onAnswerClicked(
                              question.id,
                              answerId,
                            );
                      },
                    ),
                  ]),
              16.verticalSpace,
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
    );
  }

  Widget _option(
    QuestionnaireOption option,
    bool isSelected,
    Function(String answerId) onAnswerChosen,
  ) =>
      InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: () => onAnswerChosen(option.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 50.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: isSelected ? AppColors.appBlack : AppColors.border,
              width: 1.r,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(option.label, style: TextStyles.darkRegular16.sp),
        ),
      );
}
