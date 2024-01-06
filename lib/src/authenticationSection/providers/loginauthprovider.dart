import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/navigatorHelper.dart';
import '../../../utils/showsnackbar.dart';
import '../../dashboardSection/screens/dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../services/authServices.dart';

class LoginAuthProvider extends ChangeNotifier {
  /// all variables
  bool showicon = false;
  bool showconfirmobsecure = false;

  bool isLoading = false;
  File? profileImage;
  var profileImageurlVar;

  ///patient questionalte screen variables
  double? bmivar;

  List<dynamic> wantToAcheiveList = [];

  List<dynamic> dailyactivitylevelList = [];

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  ///service accesing from othe classes
  AuthServices authServices = AuthServices();

  // UserServices userServices = UserServices();
  // StorageServices storageServices = StorageServices();

  ///create account screen controllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// personal information screen controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController bussinessContactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipPostalCodeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController coutryController = TextEditingController();

  /// banking information controllers
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController transitNumberController = TextEditingController();
  TextEditingController finincalInstutuionnumber = TextEditingController();

  /// professional information controllers

  TextEditingController professionalIDNumberController =
      TextEditingController();
  TextEditingController QualficationsController = TextEditingController();
  TextEditingController yearsOfExperienceController = TextEditingController();
  TextEditingController areaOfFocusController = TextEditingController();
  TextEditingController professionalApproachController =
      TextEditingController();
  TextEditingController languageSpokenController = TextEditingController();

  /// login screen controllers
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();

  ///  forgot email Controller
  TextEditingController forgotemailController = TextEditingController();

  ///pateint questionate screen controllers
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController waistCircumferrenceController = TextEditingController();
  TextEditingController HipCircumferrenceController = TextEditingController();

  loginUser() async {
    dp(msg: "email", arg: emailController.text);
    dp(msg: "password", arg: passwordController.text);
    makeLoadingTrue();
    try {
      ///This will allow user to authenticate in firebase
      return await authServices
          .loginUser(
              email: emailController.text.trim(),
              password: passwordController.text)
          .then((firebaseUser) async {
        await authServices
            .fetchUserRecord(firebaseUser.uid.toString())
            .first
            .then((userData) async {
          makeLoadingFalse();
          // print(userData.toJson('docID'));
          dp(
              msg: "admin user data during login",
              arg: userData.toJson("docID"));
          // Provider.of<UserProvider>(navstate.currentState!.context,
          //         listen: false)
          //     .saveUserDetails(userData);
          //  await UserLoginStateHandler.saveUserLoggedInSharedPreference(true);
          // await checkEmailVerified();
          await HiveLocalStorage.write(
              boxName: HiveConstants.currentRouteBox,
              key: HiveConstants.currentRouteKey,
              value: LoginScreen.routeName);

          await HiveLocalStorage.write(
              boxName: HiveConstants.userRoleBox,
              key: HiveConstants.userRoleKey,
              value: userData.role.toString());

          showSnackBarMessage(
              backgroundcolor: AppColors.appcolor,
              contentColor: AppColors.whitecolor,
              context: navstate.currentState!.context,
              content: "Login Successfully");
          toRemoveAll(
              context: navstate.currentState!.context,
              widget: const DashboardScreen());
        });
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

  /// forgot password get password reset link on email
  getResetPasswordLink() async {
    try {
      makeLoadingTrue();
      final list = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(forgotemailController.text);
      if (list.isNotEmpty) {
        authServices
            .resetPassword(email: forgotemailController.text)
            .whenComplete(() async {
          makeLoadingFalse();
          await showSnackBarMessage(
              context: navstate.currentState!.context,
              content:
                  "Password reset link send to your  entered email! make sure also to check spam folder");
        });
      } else {
        showSnackBarMessage(
            backgroundcolor: AppColors.redcolor,
            contentColor: AppColors.whitecolor,
            context: navstate.currentState!.context,
            content: "Email provided is not a user");
      }
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: e.toString());
    }
  }

  // ///update Profile data
  // updateProfile(String userID, String userName) async {
  //   try {
  //     if (profileImage != null) {
  //       makeLoadingTrue();
  //       var profileimageurl = await storageServices.uploadFile(profileImage!);
  //       profileImageurlVar = profileimageurl;
  //       notifyListeners();
  //
  //       userServices.updateUserDetailswithImage(UserModel(
  //         userId: userID,
  //         userName: userName,
  //         profilePicture: profileImageurlVar,
  //       ));
  //       await showSnackBarMessage(
  //           backgroundcolor: AppColors.blackcolor,
  //           contentColor: AppColors.whitecolor,
  //           context: navstate.currentState!.context,
  //           content: "Profile Updated Sucessfully with image");
  //       makeLoadingFalse();
  //       Navigator.maybePop(navstate.currentState!.context);
  //     } else {
  //       makeLoadingTrue();
  //       userServices.updateUserDetailsWithoutImage(
  //           UserModel(userId: userID, userName: userName));
  //       makeLoadingFalse();
  //       await showSnackBarMessage(
  //           backgroundcolor: AppColors.blackcolor,
  //           contentColor: AppColors.whitecolor,
  //           context: navstate.currentState!.context,
  //           content: "Profile Updated Sucessfully");
  //       Navigator.maybePop(navstate.currentState!.context);
  //     }
  //   } on FirebaseException catch (e) {
  //     makeLoadingFalse();
  //
  //     showSnackBarMessage(
  //         backgroundcolor: AppColors.redcolor,
  //         contentColor: AppColors.whitecolor,
  //         context: navstate.currentState!.context,
  //         content: e.toString());
  //   }
  // }

  /// logout user from app and delete local hive values
  logoutFromApp(context) async {
    await HiveLocalStorage.deleteHiveValue(
        boxName: HiveConstants.currentRouteBox,
        key: HiveConstants.currentRouteKey);
    await HiveLocalStorage.deleteHiveValue(
        boxName: HiveConstants.userRoleBox, key: HiveConstants.userRoleKey);
    await authServices.logoutUser();
    // GoogleSignIn().signOut();
    // FacebookAuth.instance.logOut();

    toRemoveAll(context: context, widget: const LoginScreen());
    //pushNewScreen(context, withNavBar: false, screen: SignInScreen());

    await showSnackBarMessage(
        backgroundcolor: AppColors.redcolor,
        contentColor: AppColors.whitecolor,
        context: navstate.currentState!.context,
        content: "Logout Successfully");
  }

// /// pick profile image
//
// pickProfileImage(context, ImageSource imageSource) async {
//   var xFile = await CommonMethods.getImage(imageSource);
//   if (xFile != null) {
//     profileImage = File(xFile.path);
//     notifyListeners();
//   } else {
//     showSnackBarMessage(
//         context: navstate.currentState!.context,
//         content: "Picture not picked");
//   }
// }
}
