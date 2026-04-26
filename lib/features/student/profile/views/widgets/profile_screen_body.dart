import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/select_account/views/screens/select_account.dart';
import 'package:sakan/features/student/profile/view_models/cubit/profile_cubit.dart';
import 'package:sakan/features/student/profile/view_models/cubit/profile_state.dart';
import 'package:sakan/features/student/profile/views/widgets/imag_name_section.dart';
import 'package:sakan/features/student/profile/views/widgets/profile_menu_item.dart';
import 'package:sakan/features/student/profile/views/widgets/profile_quick_actions.dart';
import 'package:sakan/features/student/subscription/views/screens/subscription_screen.dart';
import 'package:sakan/features/profile/edit_profile/views/screens/edit_profile_screen.dart';
import 'package:sakan/features/settings/views/screens/settings_screen.dart';
import 'package:sakan/features/settings/views/screens/help_center_screen.dart';
import 'package:sakan/features/settings/views/screens/support_help_screen.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});
  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  void initState() {
    final currentState = context.read<ProfileCubit>().state;
    if (currentState is! ProfileSuccess) {
      context.read<ProfileCubit>().fetchProfile();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.height * 0.03),
                if (userRole == 'student')
                  const ProfileQuickActions()
                      .animate()
                      .fade(duration: 400.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                SizedBox(height: SizeConfig.height * 0.04),
                _buildMenuSection()
                    .animate()
                    .fade(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                SizedBox(height: SizeConfig.height * 0.12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.kPrimaryColor.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      padding: EdgeInsets.only(
        top: SizeConfig.height * 0.08,
        bottom: SizeConfig.height * 0.02,
      ),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return const Center(child: Text('Failed to load profile'));
          } else if (state is ProfileSuccess) {
            return ImagNameSection(
              name: state.profile.fullName,
              email: emailController.text,
              imageUrl: state.profile.imageUrl!,
              onEditPressed: () => _navigateToEditProfile(context),
            )
                .animate()
                .fade(duration: 600.ms)
                .scale(begin: const Offset(0.9, 0.9));
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    ).then((_) {
      // Refresh profile when coming back
      if (mounted) {
        context.read<ProfileCubit>().fetchProfile();
      }
    });
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        if (userRole == 'student')
          ProfileMenuItem(
            text: "Premium Subscription",
            icon: Icons.star_rounded,
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionScreen(),
                ),
              );
            },
          ),
        ProfileMenuItem(
          text: "Edit Profile",
          icon: Icons.person_outline_rounded,
          onPress: () => _navigateToEditProfile(context),
        ),
        ProfileMenuItem(
          text: "Settings",
          icon: Icons.settings_outlined,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        ProfileMenuItem(
          text: "Support & Help",
          icon: Icons.support_agent_rounded,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupportHelpScreen()),
            );
          },
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        ProfileMenuItem(
          text: "Logout",
          textColor: AppColors.kErrorColor,
          icon: Icons.logout_rounded,
          onPress: () => _handleLogout(),
        ),
      ],
    );
  }

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SelectAccount()),
      (route) => false,
    );
  }
}
