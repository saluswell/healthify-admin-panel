import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:saluwell_admin_panel/utils/showsnackbar.dart';

class GoogleAuthService {
//  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name, imageUrl, userEmail, uid;
  static final googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async {
    if (await googleSignIn.isSignedIn()) {
      return googleSignIn.currentUser;
    } else {
      return await googleSignIn.signOut();
    }
  }

  Future<User?> signInWithGoogle(
      {required String receiverEmail, required String password}) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;
    AuthCredential? authCredentialVar;
    FirebaseAuth auth = FirebaseAuth.instance;
    // The `GoogleAuthProvider` can only be
    // used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);

      user = userCredential.user;
      authCredentialVar = userCredential.credential;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
      dp(msg: "uid", arg: uid);
      dp(msg: "name", arg: name);
      dp(msg: "user email", arg: userEmail);
      dp(msg: "image url", arg: user.photoURL);
      dp(msg: "access token", arg: authCredentialVar!.accessToken.toString());

      final smtpServer = gmailSaslXoauth2(
          user.email.toString(), authCredentialVar.accessToken.toString());
      final message = Message()
        ..from = Address(user.email.toString(), 'Muhammad Sohaib Jameel')
        ..recipients.add(receiverEmail)
        ..subject = 'Login Credentials'
        ..text =
            'Your login credentials:\n\nEmail: $receiverEmail\nPassword: $password';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ${sendReport.toString()}');
      } catch (e) {
        print("error sending email");
        print('Error sending email: $e');
      }

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool('auth', true);
      // print("name: $name");
      // print("userEmail: $userEmail");
      // print("imageUrl: $imageUrl");
    }
    return user;
  }

  Future<void> handleSignIn() async {
    await Firebase.initializeApp();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        print('Signed in as ${userCredential.user!.displayName}');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> googleSignOut() async {
    try {
      googleSignIn.signOut();
      dp(msg: "sign-out", arg: "successfully");
    } on Exception catch (e) {
      dp(msg: "catch", arg: e.toString());
      // TODO
    }
  }
}
