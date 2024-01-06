import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/usersSection/Models/userModel.dart';
import 'package:saluwell_admin_panel/src/usersSection/services/userServices.dart';
import 'package:saluwell_admin_panel/src/usersSection/widgets/users_card_widget.dart';

import '../../../commonWidgets/textfield_widget.dart';
import '../../../commonWidgets/user_profile_header_widget.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserServices userServices = UserServices();

  List<UserModel> searchedContact = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<UserModel> contactListDB = [];

  void _searchUsers(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.userName.toString().toLowerCase() +
          " " +
          i.userName.toString().toLowerCase() +
          i.userName.toString();

      var defaultCase = i.userName.toString() +
          " " +
          i.userName.toString() +
          i.userName.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedContact.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  Expanded(
                      flex: 5,
                      child: TextFieldWidget(
                        onChanged: (val) {
                          _searchUsers(val);
                          setState(() {});
                        },
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(flex: 2, child: UserProfileHeaderWidget())
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Users",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 26,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     FirebaseFirestore.instance
                  //         .collection("testCollection")
                  //         .add({
                  //       "name": "sohaib",
                  //     });
                  //   },
                  //   child: Container(
                  //     height: 42,
                  //     width: 110,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(11),
                  //         color: AppColors.blueColor),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Add User",
                  //           style: fontW5S12(context)!.copyWith(
                  //               fontSize: 12,
                  //               color: AppColors.whiteColor,
                  //               fontWeight: FontWeight.w700),
                  //         ),
                  //         const SizedBox(
                  //           width: 3,
                  //         ),
                  //         Icon(
                  //           Icons.add,
                  //           size: 18,
                  //           color: AppColors.whiteColor,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // StreamProvider.value(
            //     value: userServices.streamAllUsers(),
            //     initialData: [UserModel()],
            //     builder: (context, child) {
            //       contactListDB = context.watch<List<UserModel>>();
            //       List<UserModel> usersList = context.watch<List<UserModel>>();
            //       return usersList.isEmpty
            //           ? Center(
            //               child: Padding(
            //               padding: const EdgeInsets.only(top: 220),
            //               child: Text("No Users found!",
            //                   style: TextStyle(
            //                       // fontFamily: 'Gilroy',
            //                       color: AppColors.blackColor,
            //                       // decoration: TextDecoration.underline,
            //                       fontWeight: FontWeight.w700,
            //                       fontFamily: 'Axiforma',
            //                       fontSize: 13)),
            //             ))
            //           : usersList[0].userId == null
            //               ? const Center(
            //                   child: Padding(
            //                     padding: EdgeInsets.only(top: 100),
            //                     child: CircularProgressIndicator(
            //                       // size: 30,
            //                       color: AppColors.appcolor,
            //                     ),
            //                   ),
            //                 )
            //               : Expanded(
            //                   child: ListView.builder(
            //                       itemCount: usersList.length,
            //                       padding: const EdgeInsets.only(),
            //                       physics: const ScrollPhysics(),
            //                       // The total number of items in the list
            //                       // physics: const NeverScrollableScrollPhysics(),
            //                       itemBuilder: (context, index) {
            //                         // A callback function that returns a widget for each item at the given index
            //                         return Padding(
            //                           padding: EdgeInsets.only(bottom: 10),
            //                           child: UsersCardWidget(
            //                             userModel: usersList[index],
            //                           ),
            //                         );
            //                       }));
            //     })

            StreamProvider.value(
                value: userServices.streamAllUsers(),
                initialData: [UserModel()],
                builder: (context, child) {
                  contactListDB = context.watch<List<UserModel>>();
                  List<UserModel> list = context.watch<List<UserModel>>();
                  return list.isEmpty
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text("No Users Found!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ))
                      : list[0].userId == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: SpinKitPulse(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : list.isEmpty
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: Text("No Users Found"),
                                ))
                              : searchedContact.isEmpty
                                  ? isSearched == true
                                      ? Center(
                                          child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100),
                                          child: Text("NO Users Found"),
                                        ))
                                      : Container(
                                          // height: 550,
                                          // width: MediaQuery.of(context).size.width,

                                          child: Expanded(
                                          child: ListView.builder(
                                              itemCount: contactListDB.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(),
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: UsersCardWidget(
                                                    userModel: list[i],
                                                  ),
                                                );
                                              }),
                                        ))
                                  : Container(
                                      child: Expanded(
                                      child: ListView.builder(
                                          itemCount: searchedContact.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(),
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: UsersCardWidget(
                                                userModel: searchedContact[i],
                                              ),
                                            );
                                          }),
                                    ));
                })
          ],
        ));
  }
}
