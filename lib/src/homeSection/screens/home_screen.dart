import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/commonWidgets/textfield_widget.dart';
import 'package:saluwell_admin_panel/commonWidgets/user_profile_header_widget.dart';
import 'package:saluwell_admin_panel/src/appointmnetsSection/models/appointmentModel.dart';
import 'package:saluwell_admin_panel/src/appointmnetsSection/services/appointmentServices.dart';
import 'package:saluwell_admin_panel/src/articlesSection/models/articleModel.dart';
import 'package:saluwell_admin_panel/src/articlesSection/services/articleServices.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/providers/loginauthprovider.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/services/authServices.dart';
import 'package:saluwell_admin_panel/src/homeSection/widgets/stats_card_widget.dart';
import 'package:saluwell_admin_panel/src/usersSection/services/userServices.dart';

import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';
import '../../appointmnetsSection/widgets/care_provider_card_widget.dart';
import '../../usersSection/Models/userModel.dart';

enum UserRole {
  Admin,
  Moderator,
  Viewer,
  Owner,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserServices userServices = UserServices();
  ArticleServices articleServices = ArticleServices();
  AppointmentServices appointmentServices = AppointmentServices();
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    geUserRole();
    authServices.fetchCurrentUser(
        userId: FirebaseAuth.instance.currentUser!.uid.toString());
    super.initState();
  }

  var userRoleVar;

  geUserRole() async {
    String userRole = await HiveLocalStorage.readHiveValue<String>(
          boxName: HiveConstants.userRoleBox,
          key: HiveConstants.userRoleKey,
        ) ??
        '';

    setState(() {
      userRoleVar = userRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyColor,
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 5, child: TextFieldWidget()),
                  const SizedBox(
                    width: 50,
                  ),
                  const Expanded(flex: 2, child: UserProfileHeaderWidget()),
                  Consumer<LoginAuthProvider>(
                      builder: (context, loginAuthProvider, __) {
                    return InkWell(
                      onTap: () {
                        loginAuthProvider.logoutFromApp(context);
                      },
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/images/logout.svg",
                                color: AppColors.redcolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, " + userRoleVar.toString(),
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 26,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                      child: StreamProvider.value(
                          value: userServices.streamAllUsers(),
                          initialData: [UserModel()],
                          builder: (context, child) {
                            List<UserModel> usersList =
                                context.watch<List<UserModel>>();

                            return StatsCardWidget(
                              headText: 'Total Users',
                              count: usersList.length.toString(),
                              increase: '+5%',
                              imageColor: AppColors.blueColor,
                            );
                          })),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: StreamProvider.value(
                          value: userServices.streamAllDietitians(),
                          initialData: [UserModel()],
                          builder: (context, child) {
                            List<UserModel> usersList =
                                context.watch<List<UserModel>>();

                            return StatsCardWidget(
                              headText: 'Total Dietitians',
                              count: usersList.length.toString(),
                              increase: '+35%',
                              imageColor: Colors.pinkAccent,
                            );
                          })),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: StreamProvider.value(
                          value: articleServices.streamArticles(),
                          initialData: [ArticleModel()],
                          builder: (context, child) {
                            List<ArticleModel> usersList =
                                context.watch<List<ArticleModel>>();

                            return StatsCardWidget(
                              headText: 'Total Articles',
                              count: usersList.length.toString(),
                              increase: '+15%',
                              imageColor: Colors.orange,
                            );
                          })),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: StreamProvider.value(
                          value: appointmentServices.streamAllAppointments(),
                          initialData: [AppointmentModel()],
                          builder: (context, child) {
                            List<AppointmentModel> usersList =
                                context.watch<List<AppointmentModel>>();

                            return StatsCardWidget(
                              headText: 'Total Appointments',
                              count: usersList.length.toString(),
                              increase: '+15%',
                              imageColor: Colors.green,
                            );
                          }))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming Appointments",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamProvider.value(
                value: appointmentServices.streamUpcomingAppointments(),
                initialData: [AppointmentModel()],
                builder: (context, child) {
                  List<AppointmentModel> appointmentList =
                      context.watch<List<AppointmentModel>>();
                  return appointmentList.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 220),
                          child: Text("No Upcoming Appointments found!",
                              style: TextStyle(
                                  // fontFamily: 'Gilroy',
                                  color: AppColors.blackcolor,
                                  // decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Axiforma',
                                  fontSize: 13)),
                        ))
                      : appointmentList[0].appointmentId == null
                          ? const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: CircularProgressIndicator(
                                //  size: 30,
                                color: AppColors.appcolor,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: appointmentList.length,
                                  padding: EdgeInsets.only(),
                                  physics: ScrollPhysics(),
                                  // The total number of items in the list
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    // A callback function that returns a widget for each item at the given index
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CareProviderCardWidget(
                                        appointmentModel:
                                            appointmentList[index],
                                      ),
                                    );
                                  }));
                })
          ],
        ));
  }
}
