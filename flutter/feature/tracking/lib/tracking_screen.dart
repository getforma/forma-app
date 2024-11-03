import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tracking_feature/bloc/tracking_cubit.dart';

@RoutePage()
class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<TrackingCubit>(),
      child: BlocConsumer<TrackingCubit, TrackingState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TrackingState state) =>
      const Expanded(child: Placeholder());
}
