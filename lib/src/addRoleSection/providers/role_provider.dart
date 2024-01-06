import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/services/role_services.dart';

import '../../../helpers/getUserId.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/navigatorHelper.dart';
import '../../../utils/showsnackbar.dart';
import '../models/admin_user_model.dart';
import '../models/option_model.dart';

class RoleProvider extends ChangeNotifier {
  RoleServices roleServices = RoleServices();
  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Role? _selectedRole;

  Role? get selectedRole => _selectedRole;

  set selectedRole(Role? role) {
    _selectedRole = role;
    notifyListeners();
  }

  addMember(String email) async {
    try {
      makeLoadingTrue();
      return await roleServices
          .registerAdminUserAuth(
              email: email, password: roleServices.generateRandomPassword())
          .then((value) {
        roleServices.createAdminUserInFireStore(AdminUserModel(
            userId: getUserID(),
            emailAdress: email,
            dateCreated: Timestamp.fromDate(DateTime.now()),
            userType: "adminUsers",
            password: roleServices.randomPasswordVar.toString(),
            role: selectedRole!.name.toString()));
      }).then((value) {
        makeLoadingFalse();
        showSnackBarMessage(
            context: navstate.currentState!.context,
            content: "User Added Successfully");
      });
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: navstate.currentState!.context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: AppColors.whitecolor,
            title: const Text('ALert!'),
            content: Text(e.message.toString()),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Okay'),
                style: ButtonStyle(
                    // backgroundColor: AppColors.lightdarktextcolor
                    ),
                onPressed: () {
                  makeLoadingFalse();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}
