import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class CustomQuickAlert {
  static void showSuccess(BuildContext context,
      {required String message, VoidCallback? onConfirm}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Success',
      desc: message,
      btnOkOnPress: onConfirm ?? () {},
      btnOkColor: AppColors.kSuccessColor,
    ).show();
  }

  static void showError(BuildContext context, {required String message}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
      btnOkColor: AppColors.kErrorColor,
    ).show();
  }

  static void showConfirmation(
    BuildContext context, {
    required String message,
    required VoidCallback onConfirm,
    String confirmBtnText = 'Confirm',
    String cancelBtnText = 'Cancel',
    VoidCallback? onCancel,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Confirm',
      desc: message,
      btnCancelText: cancelBtnText,
      btnOkText: confirmBtnText,
      btnCancelOnPress: onCancel ?? () {},
      btnOkOnPress: onConfirm,
      btnOkColor: AppColors.kWarningColor,
    ).show();
  }

  static void showLoading(BuildContext context,
      {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.kPrimaryColor),
            const SizedBox(width: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
