import 'package:flutter/material.dart';

import '../utils/appcolors.dart';
import '../utils/navigatorHelper.dart';

class CommonDialog {
  static roleAlertDialog(String message) {
    return showDialog<void>(
      context: navstate.currentState!.context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.whitecolor,
          title: const Text('Alert!'),
          content: Text(message.toString()),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {
                //  makeLoadingFalse();
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
