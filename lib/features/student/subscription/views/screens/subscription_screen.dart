import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/subscription/view_models/cubit/subscription_cubit.dart';
import 'package:sakan/features/student/subscription/views/widgets/subscription_screen_body.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit(),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: const SubscriptionScreenBody(),
      ),
    );
  }
}
