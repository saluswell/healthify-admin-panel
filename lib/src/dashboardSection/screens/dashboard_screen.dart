import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/screens/add_role_screen.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/services/role_services.dart';
import 'package:saluwell_admin_panel/src/appointmnetsSection/screens/care_providers_request.dart';
import 'package:saluwell_admin_panel/src/articlesSection/screens/articles.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/services/authServices.dart';
import 'package:saluwell_admin_panel/src/dashboardSection/providers/menu_provider.dart';
import 'package:saluwell_admin_panel/src/homeSection/screens/home_screen.dart';
import 'package:saluwell_admin_panel/src/paymentsSection/screens/payments.dart';
import 'package:saluwell_admin_panel/src/reviewsSection/screens/reviews.dart';
import 'package:saluwell_admin_panel/src/usersSection/screens/users_screen.dart';
import 'package:saluwell_admin_panel/utils/appcolors.dart';

import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../mealPlansSection/screens/meal_plan_listing_screen.dart';
import '../../recipesSection/screens/reccipes_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  RoleServices roleServices = RoleServices();
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    geUserRole();
    authServices.fetchCurrentUser(
        userId: FirebaseAuth.instance.currentUser!.uid.toString());

    context.read<MenuProvider>().tabController = TabController(
        length: 9,
        vsync: this); // Replace 3 with the number of tabs/screens you want.
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
  void dispose() {
    context.read<MenuProvider>().tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(builder: (context, menuProvider, __) {
      return Scaffold(
        backgroundColor: AppColors.greyColor,
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 80,
                child: Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: menuProvider.menuList.length,
                          // The total number of items in the list
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // A callback function that returns a widget for each item at the given index
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: InkWell(
                                onTap: () {
                                  menuProvider.setIndex(index);
                                  menuProvider.switchTab(index);
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: menuProvider.selectedIndex == index
                                        ? AppColors.appcolor.withOpacity(0.6)
                                        : AppColors.whiteColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(23.0),
                                    child: SvgPicture.asset(
                                      menuProvider.menuList[index].icon
                                          .toString(),

                                      // theme:
                                      //     SvgTheme(currentColor: Colors.yellow),
                                      color: menuProvider.selectedIndex == index
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor
                                              .withOpacity(0.2),
                                      //   color: Colors.black.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 12,
                child: Container(
                  child: TabBarView(
                    controller: menuProvider.tabController,
                    //  physics: NeverScrollableScrollPhysics(),
                    dragStartBehavior: DragStartBehavior.down,
                    children: const [
                      HomeScreen(),
                      UsersScreen(),
                      CareProvidersRequestScreen(),
                      ReviewsScreen(),
                      PaymentsScreen(),
                      ArticlesScreen(),
                      AddRoleScreen(),
                      RecipesListScreen(),
                      MealPlansListingScreen()

                      // Your first screen widget for the first tab
                      // FirstScreen(),
                      // // Your second screen widget for the second tab
                      // SecondScreen(),
                      // // Your third screen widget for the third tab
                      // ThirdScreen(),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
