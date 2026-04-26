import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/helper/show_custom_dialog.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/continue_with.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/fields_sign_in.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/have_account.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/logo.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/remember_me.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/title_auth.dart';
import 'package:sakan/features/auth/sign_up/view_models/cubit/auth_cubit.dart';
import 'package:sakan/features/auth/sign_up/view_models/cubit/auth_state.dart';
import 'package:sakan/features/auth/sign_up/views/screens/sign_up_screen.dart';
import 'package:sakan/features/custom_bottom_navBar/screens/main_screen.dart';
import 'package:sakan/features/owner/apartments/views/screens/owner_apartment_model.dart';

class SignInScreenBody extends StatefulWidget {
  const SignInScreenBody({super.key});

  @override
  State<SignInScreenBody> createState() => _SignInScreenBodyState();
}

class _SignInScreenBodyState extends State<SignInScreenBody> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // هذا يمنع الشاشة من إعادة تحجيم نفسها عند ظهور الكيبورد
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            if (userRole == 'student') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnerApartmentsScreen(),
                ),
              );
            }
          } else if (state is AuthError) {
            if (state.message == 'wrong-role') {
              showCustomDialog(
                title: 'Failure',
                description:
                    'This account is registered as a different role. Please use the correct login page.',
                dialogType: DialogType.error,
                btnOkColor: Colors.red,
              );
            } else {
              showCustomDialog(
                title: 'Failure',
                description:
                    'There is an error in this account or the account does not exist',
                dialogType: DialogType.error,
                btnOkColor: Colors.red,
              );
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
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
                      Logo(),
                      SizedBox(height: 5),
                      TitleAuth(
                        title: 'Welcome!',
                        subTitle: 'Sign in to continue',
                      ),
                      SizedBox(height: 15),
                      FieldsSignin(formKey: _formKey),
                      RememberMe(),
                      SizedBox(height: 20),
                      CustomButton(
                        text: 'Sign In',
                        color: AppColors.kPrimaryColor,
                        isLoading:
                            state
                                is AuthLoading, // تأكد أنك أضفت isLoading للـ CustomButton
                        onTap: () {
                          // 1. تحقق من الحقول
                          if (_formKey.currentState!.validate()) {
                            // 2. استدعاء الدالة من الـ Cubit
                            context.read<AuthCubit>().loginUser(
                              email: emailController.text.trim(),
                              password: passController.text.trim(),
                              role: userRole,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      ContinueWith(),
                      SizedBox(height: 65),
                      HaveAccount(
                        text: "Don't have account?",
                        textButton: ' Sign up',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                      ),
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
