import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sakan/app/my_app.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

void showCustomDialog({
  required String title,
  required String description,
  required DialogType dialogType,
  Function()? btnCancelOnPress,
  Function()? btnOkOnPress,
  Color? btnCancelColor,
  Color? btnOkColor,
}) {
  AwesomeDialog(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    context: navigatorKey.currentState!.context,
    dialogType: dialogType,
    animType: AnimType.bottomSlide,
    title: title,
    desc: description,
    btnCancelOnPress: btnCancelOnPress,
    btnCancelColor: btnCancelColor ?? Colors.red,
    btnOkOnPress: btnOkOnPress ?? () {},
    btnOkColor: btnOkColor ?? AppColors.kSuccessColor,
    headerAnimationLoop: true,
    customHeader: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kPrimaryColor.withOpacity(0.1),
      ),
      child: getDialogIcon(dialogType),
    ),
  ).show();
}

// IconData _getDialogIcon(DialogType type) {
//   switch (type) {
//     case DialogType.success:
//       return Icons.check_circle;
//     case DialogType.error:
//       return Icons.error;
//     case DialogType.warning:
//       return Icons.warning;
//     case DialogType.info:
//       return Icons.info;
//     default:
//       return Icons.help;
//   }
// }

Icon getDialogIcon(DialogType type) {
  IconData iconData;
  Color iconColor;

  switch (type) {
    case DialogType.success:
      iconData = Icons.check_circle;
      iconColor = Colors.green;
      break;
    case DialogType.error:
      iconData = Icons.error;
      iconColor = Colors.red;
      break;
    case DialogType.warning:
      iconData = Icons.warning;
      iconColor = Colors.orange;
      break;
    case DialogType.info:
      iconData = Icons.info;
      iconColor = Colors.blue;
      break;
    default:
      iconData = Icons.help;
      iconColor = Colors.grey;
  }

  return Icon(
    iconData,
    color: iconColor,
    size: 75, // يمكنك التحكم بالحجم هنا
  );
}
