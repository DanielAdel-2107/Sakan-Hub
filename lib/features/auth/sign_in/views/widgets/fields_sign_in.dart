import 'package:flutter/material.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/components/widgets_app/customTextFields.dart';

class FieldsSignin extends StatelessWidget {
  const FieldsSignin({super.key, required GlobalKey<FormState> formKey})
    : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            focusNode: emailFocus,
            validator: emailValidator,
            controller: emailController,
            hintText: 'Enter email',
            icon: Icons.email,
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            focusNode: passFocus,
            validator: passwordValidator,
            controller: passController,
            hintText: 'Enter password',
            icon: Icons.lock,
            isPassword: true,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
