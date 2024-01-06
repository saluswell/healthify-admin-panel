import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saluwell_admin_panel/utils/navigatorHelper.dart';

import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';
import '../../dashboardSection/screens/dashboard_screen.dart';
import '../services/authServices.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthServices authServices = AuthServices();

  void initState() {
    checkLogin();
    super.initState();
  }

  Future<void> checkLogin() async {
    // User? user = authServices.getCurrentUser();

    // UserModel userModel =
    //     (await userService.fetchUserRecord(user!.uid)) as UserModel;

    // dp(msg: "User", arg: user.toString());
    //
    String currentRoute = await HiveLocalStorage.readHiveValue<String>(
          boxName: HiveConstants.currentRouteBox,
          key: HiveConstants.currentRouteKey,
        ) ??
        '';

    //  dp(msg: "Current route", arg: currentRoute);
    Timer(const Duration(seconds: 2), () async {
      if (currentRoute == LoginScreen.routeName) {
        toRemoveAll(context: context, widget: const DashboardScreen());
      } else {
        toRemoveAll(context: context, widget: const LoginScreen());
      }
      // if (user != null) {
      //   UserServices.userId = user.uid;
      //   UserServices.tempUser = await authServices.fetchCurrentUser();
      //
      //   // dp(
      //   //     arg: UserServices.tempUser!.toJson(UserServices.userId.toString()),
      //   //     msg: "tempuserModelongooglesigning");
      //
      //   //Provider.of<UserProvider>(context, listen: false)
      //
      //   if (currentRoute == LoginScreen.routeName) {
      //     toRemoveAll(context: context, widget: DashboardScreen());
      //   } else {
      //     toRemoveAll(context: context, widget: LoginScreen());
      //   }
      // } else {
      //   // toRemoveAll(context: context, widget: OnBoardingScreenOne());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/applogoupdated.png",
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome Admin",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 24,
                      color: AppColors.appcolor,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
