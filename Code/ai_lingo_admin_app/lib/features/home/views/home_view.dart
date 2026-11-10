import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/custom_text.dart';
import '../viewmodels/home_cubit.dart';
import '../viewmodels/home_state.dart';

/// Home screen View — UI only.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeViewBody(),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(state.title),
                  const SizedBox(height: AppDimensions.spaceMd),
                  CustomText(state.subtitle),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
