import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sakan/features/owner/apartments/views/screens/owner_apartment_model.dart';

//////////////////////////////////////////////////////////////
/////         TextEditingController variables          ///////
//////////////////////////////////////////////////////////////
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController fullNameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final PageController controllerOnBoarding = PageController();

//////////////////////////////////////////////////////////////
//////////////         FocusNode            //////////////////
//////////////////////////////////////////////////////////////
final FocusNode emailFocus = FocusNode();
final FocusNode passFocus = FocusNode();
final FocusNode fullNameFocus = FocusNode();
final FocusNode phoneFocus = FocusNode();
final FocusNode userNameControllerFocus = FocusNode();

//////////////////////////////////////////////////////////////
//////////////         validator            //////////////////
//////////////////////////////////////////////////////////////
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  // Regex للتحقق من صيغة الإيميل
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null;
}

///////////////////////////////////////////////////////////////
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  return null;
}

/////////////////////////////////////////////////////////////
String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone number';
  }
  // رقم الهاتف يجب أن يكون من 10 أرقام
  if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
    return 'Please enter a valid 11-digit phone number';
  }
  return null;
}

///////////////////////////////////////////////////////////////
String? validated(String? value) {
  if (value == null || value.isEmpty || value.length < 3) {
    return 'Please fill the field';
  }
  return null;
}

//////////////////////////////////////////////////////////////
/////             select Owner or Student              ///////
//////////////////////////////////////////////////////////////
String userRole = '';
String? selectedCollegeId; // ← جديد
List<Map<String, dynamic>> colleges = []; // ← جديد: لتخزين الكليات
File? selectedProfileImage; // الصورة المختارة محليًا
String? profileImageUrl;
void onSignUpSuccess(BuildContext context) {
  if (userRole == 'owner') {
    log('Owner selected');
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainBottomNavDonor()),
    // );
  } else {
    log('Student selected');

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainBottomNavRecipient()),
    // );
  }
}

List<Widget> screens = [OwnerApartmentsScreen()];
