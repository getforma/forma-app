import 'package:auto_route/auto_route.dart';
import 'package:core_feature/widget/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:questionnaire_feature/bloc/questionnaire_cubit.dart';
import 'package:questionnaire_feature/router/questionnaire_type.dart';

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
              if (state.status == QuestionnaireStatus.loading)
                const Positioned.fill(child: LoaderWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
