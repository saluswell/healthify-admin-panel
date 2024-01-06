import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/models/admin_user_model.dart';

import '../../../utils/firebaseUtils.dart';
import '../../../utils/showsnackbar.dart';
import '../../usersSection/Models/userModel.dart';
import '../../usersSection/Models/userModelDietitian.dart';
import '../../usersSection/services/userServices.dart';

class AuthServices {
  ///Register User
  Future registerUser({required String email, required String password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  ///Login User
  Future<User> loginUser(
      {required String email, required String password}) async {
    UserCredential userCred = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCred.user!;
  }

  ///Reset Password
  Future resetPassword({required String email}) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  /// check if user is approved or not from admin
  Stream<UserModel> checkIfUserAllowed(String docID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(docID)
        .snapshots()
        .map((event) {
      return UserModel.fromJson(event.data()!);
    });
  }

  //
  ///fetch current user
  Future<UserModel?> fetchCurrentUser({userId}) async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .doc(userId ?? UserServices.userId)
          .get();

      if (userData.exists) {
        UserModel userModel =
            await UserModel.fromJson(userData.data() as Map<String, dynamic>);
        dp(msg: "fetch current user data", arg: userModel.toJson("docID"));
        return userModel;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      dp(msg: "Error in get user", arg: e);
      rethrow;
    }
  }

  ///fetch current diettian user
  Future<UserModelDietitian?> fetchCurrentDietitianUser({userId}) async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .doc(userId ?? UserServices.userId)
          .get();

      if (userData.exists) {
        return UserModelDietitian.fromJson(
            userData.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      dp(msg: "Error in get user", arg: e);
      rethrow;
    }
  }

  ///Fetch User Record
  Stream<AdminUserModel> fetchUserRecord(String userID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.adminUsers)
        .doc(userID)
        .snapshots()
        .map((userData) => AdminUserModel.fromJson(userData.data()!));
  }

  /// logout user
  logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      dp(msg: "Error in sign out", arg: e.toString());
      rethrow;
    }
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
