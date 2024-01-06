import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/appcolors.dart';
import '../../../utils/firebaseUtils.dart';
import '../../../utils/navigatorHelper.dart';
import '../../../utils/showsnackbar.dart';
import '../Models/userModel.dart';
import '../Models/userModelDietitian.dart';

class UserServices {
  static String? userId;
  static UserModel? tempUser;
  static UserModelDietitian? tempUserDietitian;

  ///Create User
  Future createUser(UserModel userModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(userModel.userId);
    return await docRef.set(userModel.toJson(docRef.id));
  }

  ///Fetch User Record
  Stream<UserModel> fetchUserRecord(String userID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(userID)
        .snapshots()
        .map((userData) => UserModel.fromJson(userData.data()!));
  }

  /// stream All Users
  Stream<List<UserModel>> streamAllUsers() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        // .where("UserType", isEqualTo: "Patient")
        // .where("patientID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        //  .orderBy("combineDateTime", descending: false)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModel.fromJson(singleDoc.data()))
            .toList());
  }

  /// stream All Users
  Stream<List<UserModel>> streamAllDietitians() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .where("UserType", isEqualTo: "Dietitian")
        // .where("patientID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        //  .orderBy("combineDateTime", descending: false)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///delete user
  Future deleteUser(String userID) async {
    print(userID);
    try {
      return await FirebaseFirestore.instance
          .collection(FirebaseUtils.users)
          .doc(userId)
          .delete();
    } on FirebaseException catch (e) {
      print(e.toString());

      // TODO
    }
  }

  Future approveBlockUser(
      UserModel userModel, userID, bool isApprovedByAdmin) async {
    try {
      return await FirebaseFirestore.instance
          .collection(FirebaseUtils.users)

          //  .where("UserId",isEqualTo: userid)
          .doc(userID)
          .update({
        'isApprovedByAdmin': isApprovedByAdmin,
        //"articleDescription": articleModel.articleDescription,
      }).whenComplete(() {
        if (isApprovedByAdmin == true) {
          showSnackBarMessage(
              context: navstate.currentState!.context,
              backgroundcolor: AppColors.appcolor,
              contentColor: AppColors.whitecolor,
              content: "User Approved Successfully");
        } else {
          showSnackBarMessage(
              context: navstate.currentState!.context,
              backgroundcolor: AppColors.appcolor,
              contentColor: AppColors.whitecolor,
              content: "User Blocked Successfully");
        }
      });
    } on Exception catch (e) {
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: e.toString());
      // TODO
    }
  }

  /// update article data without image
  Future updateUserData(UserModel userModel, userID) async {
    print(userID);
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.users)

        //  .where("UserId",isEqualTo: userid)
        .doc(userID)
        .update({
      'userName': "test sohaib",
      //"userName": userModel.articleDescription,
    });
  }

// ///Update user record with Image
//
// Future updateUserDetailswithImage(UserModel userModel) async {
//   return await FirebaseFirestore.instance
//       .collection(FirebaseUtils.users)
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .set({
//     "userName": userModel.userName,
//     "profilePicture": userModel.profilePicture,
//   }, SetOptions(merge: true));
// }
//
// ///Update user record with Image
//
// Future updateUserDetailsWithoutImage(UserModel userModel) async {
//   return await FirebaseFirestore.instance
//       .collection(FirebaseUtils.users)
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .set({
//     "userName": userModel.userName,
//   }, SetOptions(merge: true));
// }
}
