import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:saluwell_admin_panel/utils/showsnackbar.dart';

import '../../../utils/firebaseUtils.dart';
import '../models/admin_user_model.dart';
import 'google_signin_service.dart';

class RoleServices {
  ///Register Admin User
  Future registerAdminUserAuth(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  ///Create admin User in firestorm
  Future createAdminUserInFireStore(AdminUserModel adminUserModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.adminUsers)
        .doc(adminUserModel.userId);
    return await docRef.set(adminUserModel.toJson(docRef.id));
  }

  Future signInWithEmailLink({required String email}) async {
    return await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: "sohaibjameel3@gmail.com",
        actionCodeSettings: ActionCodeSettings(
            url: "https://meet.google.com/", handleCodeInApp: true));
  }

  var randomPasswordVar;

  String generateRandomPassword() {
    final String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final Random rnd = Random(DateTime.now().millisecondsSinceEpoch);

    String password = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    randomPasswordVar = password;
    dp(msg: "random password var", arg: randomPasswordVar.toString());

    return password;
  }

  /// stream All Admin Users
  Stream<List<AdminUserModel>> streamAllAdminUsers() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.adminUsers)
        // .where("UserType", isEqualTo: "Patient")
        // .where("patientID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        //  .orderBy("combineDateTime", descending: false)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => AdminUserModel.fromJson(singleDoc.data()))
            .toList());
  }

  // Future<void> deleteUserByUid(String uid) async {
  //   try {
  //     await FirebaseAuth.instance.user(uid).delete();
  //     print('User with UID $uid deleted successfully.');
  //   } catch (e) {
  //     print('Error deleting user with UID $uid: $e');
  //   }

  Future<void> sendEmailWithCredentials(
      String userEmail, String password) async {
    final user = await GoogleAuthService.signIn();

    if (user == null) return;
    final email = user.email;
    final auth = await user.authentication;
    final token = auth.accessToken;
    dp(msg: "authenticated email", arg: email.toString());

    //final smtpServer = gmail('sohaibjameel3@gmail.com', '3710456@SohaibJameel');
    final smtpServer = gmailSaslXoauth2(email, token!);
    final message = Message()
      ..from = Address(email, 'Muhammad Sohaib Jameel')
      ..recipients.add(userEmail)
      ..subject = 'Login Credentials'
      ..text =
          'Your login credentials:\n\nEmail: $userEmail\nPassword: $password';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('Error sending email: $e');
    }
  }
}
