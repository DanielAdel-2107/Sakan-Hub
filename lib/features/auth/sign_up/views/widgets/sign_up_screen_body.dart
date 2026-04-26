import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/helper/show_custom_dialog.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/auth/sign_in/views/screens/sign_in_screen.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/have_account.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/title_auth.dart';
import 'package:sakan/features/auth/sign_up/view_models/cubit/auth_cubit.dart';
import 'package:sakan/features/auth/sign_up/view_models/cubit/auth_state.dart';
import 'package:sakan/features/auth/sign_up/views/widgets/conditions.dart';
import 'package:sakan/features/auth/sign_up/views/widgets/fields_sign_up.dart';

class SignUpScreenBody extends StatefulWidget {
  const SignUpScreenBody({super.key});

  @override
  State<SignUpScreenBody> createState() => _SignUpScreenBodyState();
}

// ... imports نفسها

class _SignUpScreenBodyState extends State<SignUpScreenBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.clear();
    emailController.clear();
    passController.clear();
    phoneController.clear();

    fullNameFocus.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    phoneFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (prev, curr) => prev != curr,
        listener: (context, state) {
          if (state is AuthSuccess) {
            showCustomDialog(
              title: 'Success',
              description: 'Account created successfully!',
              dialogType: DialogType.success,
            );

            context.read<AuthCubit>().resetState();

            Future.delayed(const Duration(seconds: 1), () {
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
              );
            });
          } else if (state is AuthError) {
            showCustomDialog(
              title: 'Error',
              description: state.message ?? 'An error occurred during registration. Please try again.',
              dialogType: DialogType.error,
              btnOkColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                width: double.infinity,
                color: AppColors.kBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.04,
                    vertical: SizeConfig.width * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleAuth(
                        title: 'Sign up!',
                        subTitle: 'Create a new account',
                      ),
                      const SizedBox(height: 15),
                      FieldsSignUp(formKey: _formKey),
                      CustomButton(
                        text: 'Sign Up',
                        color: AppColors.kPrimaryColor,
                        isLoading: state is AuthLoading,
                        onTap: state is AuthLoading
                            ? null
                            : () {
                                if (!_formKey.currentState!.validate()) return;

                                if (selectedProfileImage == null) {
                                  showCustomDialog(
                                    title: 'Required',
                                    description: 'Please select a profile picture',
                                    dialogType: DialogType.warning,
                                  );
                                  return;
                                }

                                if (userRole == 'student' && selectedCollegeId == null) {
                                  showCustomDialog(
                                    title: 'Required',
                                    description: 'Please select your college/university',
                                    dialogType: DialogType.warning,
                                  );
                                  return;
                                }

                                context.read<AuthCubit>().register(
                                      email: emailController.text.trim(),
                                      password: passController.text.trim(),
                                      name: fullNameController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      role: userRole,
                                      profileImage: selectedProfileImage,
                                      collegeId: userRole == 'student' ? selectedCollegeId : null,
                                    );
                              },
                      ),
                      const SizedBox(height: 15),
                      const Conditions(),
                      const SizedBox(height: 30),
                      HaveAccount(
                        text: "Already have an account?",
                        textButton: ' Sign in',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SignInScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}