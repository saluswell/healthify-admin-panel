import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/commonWidgets/button_widget.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/models/admin_user_model.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/providers/role_provider.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/services/google_signin_service.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/services/mail_chimp_service.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/services/role_services.dart';
import 'package:saluwell_admin_panel/src/addRoleSection/widgets/admin_user_card_widget.dart';
import 'package:saluwell_admin_panel/utils/navigatorHelper.dart';

import '../../../commonWidgets/textfield_widget.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/showsnackbar.dart';
import '../../../utils/themes.dart';
import '../models/option_model.dart';
import '../widgets/select_role_drop_down.dart';

class AddRoleScreen extends StatefulWidget {
  const AddRoleScreen({Key? key}) : super(key: key);

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  RoleServices roleServices = RoleServices();
  MailService mailService = MailService();
  GoogleAuthService googleAuthService = GoogleAuthService();
  TextEditingController emailController = TextEditingController();
  RoleProvider roleProvider =
      Provider.of<RoleProvider>(navstate.currentState!.context);

  List<Role> roles = [
    Role(1, 'Admin'),
    Role(2, 'Moderator'),
    Role(3, 'Viewer'),
  ];

  List<AdminUserModel> searchedContact = [];

  bool isSearchingAllow = false;
  bool isSearched = false;
  List<AdminUserModel> contactListDB = [];

  void _searchUsers(String val) async {
    print(contactListDB.length);
    searchedContact.clear();
    for (var i in contactListDB) {
      var lowerCaseString = i.emailAdress.toString().toLowerCase() +
          " " +
          i.emailAdress.toString().toLowerCase() +
          i.emailAdress.toString();

      var defaultCase = i.emailAdress.toString() +
          " " +
          i.emailAdress.toString() +
          i.emailAdress.toString();

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
  Widget build(BuildContext context) {
    return Consumer<RoleProvider>(builder: (context, roleProvider, __) {
      return LoadingOverlay(
        isLoading: roleProvider.isLoading,
        opacity: 0.1,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Users & Permissions",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 26,
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 5,
                        child: TextFieldWidget(
                          hintText: "Enter email",
                          controller: emailController,
                          onChanged: (val) {
                            // _searchArticles(val);
                            // setState(() {});
                          },
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 280),
                              child: Container(
                                child: AlertDialog(
                                  backgroundColor: AppColors.whitecolor,
                                  title: Text('Select a Role'),
                                  content: CustomRadioGroupButton(roles: roles),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 65,
                        width: 140,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                roleProvider.selectedRole == null
                                    ? "Select Role"
                                    : roleProvider.selectedRole!.name
                                        .toString(),
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CommonButtonWidget(
                      text: "Add User",
                      textfont: 14,
                      buttonwidth: 120,
                      onTap: () async {
                        // await MailService.sendWelcomeEmail(
                        //     "sohaibjameel666@gmail.com");

                        if (emailController.text.isEmpty) {
                          showSnackBarMessage(
                              context: context,
                              backgroundcolor: AppColors.redcolor,
                              contentColor: AppColors.whitecolor,
                              content: "Please Enter Email Address");
                        } else if (roleProvider.selectedRole == null) {
                          showSnackBarMessage(
                              context: context,
                              backgroundcolor: AppColors.redcolor,
                              contentColor: AppColors.whitecolor,
                              content: "Please Select Role Of User");
                        } else {
                          roleProvider.addMember(emailController.text);
                        }

                        // roleServices.sendEmailWithCredentials(
                        //     "sohaibjameel666@gmail.com", "12345678");
                      },
                      horizontalPadding: 0,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Members",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 20,
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFieldWidget(
                        hintText: "Search members...",
                        onChanged: (val) {
                          _searchUsers(val);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              StreamProvider.value(
                  value: roleServices.streamAllAdminUsers(),
                  initialData: [AdminUserModel()],
                  builder: (context, child) {
                    contactListDB = context.watch<List<AdminUserModel>>();
                    List<AdminUserModel> list =
                        context.watch<List<AdminUserModel>>();
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
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 5),
                                                    child: AdminUsersCardWidget(
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
                                                    bottom: 10),
                                                child: AdminUsersCardWidget(
                                                  userModel: searchedContact[i],
                                                ),
                                              );
                                            }),
                                      ));
                  })
            ],
          ),
        ),
      );
    });
  }
}
