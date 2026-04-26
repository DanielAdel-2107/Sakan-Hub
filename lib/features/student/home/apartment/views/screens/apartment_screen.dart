import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/profile/view_models/cubit/profile_cubit.dart';
import 'package:sakan/features/student/profile/view_models/cubit/profile_state.dart';
import 'package:sakan/features/student/home/apartment/views/widgets/apartment_screen_body.dart';

class ApartmentScreen extends StatelessWidget {
  const ApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        } else if (state is ProfileSuccess) {
          return HomeScreenBody(profileModel: state.profile);
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}