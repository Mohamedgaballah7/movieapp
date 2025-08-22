import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class DialogUtils {
  static void showLoading({required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.yellowColor),
            SizedBox(width: 20),
            Text('Loading...', style: AppStyles.bold24Black),
          ],
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMassege({
    required BuildContext context,
    required String message,
    String? Title,
    String? PosActionName,
    Function? PosAction,
    String? NegActionName,
    Function? NegAction,
  }) {
    List<Widget> actions = [];
    if (PosActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            if (PosAction != null) {
              Navigator.pop(context);
              PosAction?.call();
            }
          },
          child: Text(PosActionName, style: AppStyles.bold16Black),
        ),
      );
    }
    if (NegActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            if (NegAction != null) {
              Navigator.pop(context);
              NegAction?.call();
            }
          },
          child: Text(NegActionName, style: AppStyles.bold16Black),
        ),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkYellowColor,
        title: Text(Title ?? "", style: AppStyles.bold16Black),
        content: Text(
          textAlign: TextAlign.center,
          message,
          style: AppStyles.bold16Black,
        ),
        actions: actions,
      ),
    );
  }
}
