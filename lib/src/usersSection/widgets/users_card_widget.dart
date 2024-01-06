import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saluwell_admin_panel/src/usersSection/Models/userModel.dart';
import 'package:saluwell_admin_panel/src/usersSection/services/userServices.dart';

import '../../../commonWidgets/cacheNetworkImageWidget.dart';
import '../../../commonWidgets/show_dialog.dart';
import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/showsnackbar.dart';
import '../../../utils/themes.dart';
import '../../homeSection/screens/home_screen.dart';

class UsersCardWidget extends StatefulWidget {
  final UserModel userModel;

  const UsersCardWidget({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UsersCardWidget> createState() => _UsersCardWidgetState();
}

class _UsersCardWidgetState extends State<UsersCardWidget> {
  UserServices userServices = UserServices();

  @override
  void initState() {
    geUserRole();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // widget.userModel.profilePicture == null
                    //     ? Container(
                    //         height: 45,
                    //         width: 45,
                    //         child: Center(
                    //           child: Icon(Icons.person),
                    //         ),
                    //       )
                    //     : Container(
                    //         height: 45,
                    //         width: 45,
                    //         decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //               image: NetworkImage(widget
                    //                   .userModel.profilePicture
                    //                   .toString())),
                    //         ),
                    //       ),
                    //  Image.network(widget.userModel.profilePicture.toString()),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CacheNetworkImageWidget(
                          height: 55,
                          width: 55,
                          imgUrl: widget.userModel.profilePicture.toString(),
                          radius: 7),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Image.asset(
                    //     "assets/images/randomdoc.png",
                    //     height: 55,
                    //     width: 55,
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.userModel.personalInformationModel!.firstName} ${widget.userModel.personalInformationModel!.lastName}",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.userModel.emailAdress.toString(),
                          style: fontW3S12(context)!.copyWith(
                              fontSize: 12,
                              color: AppColors.blackColor.withOpacity(0.3),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.userModel.personalInformationModel!
                                  .mobileNumber
                                  .toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Phone",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.userModel.personalInformationModel!.country
                                  .toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Country",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.userModel.userType.toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "User Type",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.userModel.isApprovedByAdmin == true
                                  ? "Approved"
                                  : "Blocked",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color:
                                      widget.userModel.isApprovedByAdmin == true
                                          ? AppColors.appcolor.withOpacity(0.8)
                                          : AppColors.redcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Is Approved",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  dp(
                                      msg: "role hive local",
                                      arg: userRoleVar.toString());
                                  dp(msg: "role enum", arg: UserRole.Viewer);
                                  if (userRoleVar.toString() ==
                                          UserRole.Owner.name ||
                                      userRoleVar.toString() ==
                                          UserRole.Admin.name) {
                                    userServices.approveBlockUser(
                                        widget.userModel,
                                        widget.userModel.userId.toString(),
                                        false);
                                  } else if (userRoleVar.toString() ==
                                          UserRole.Moderator.name ||
                                      userRoleVar.toString() ==
                                          UserRole.Viewer.name) {
                                    CommonDialog.roleAlertDialog(
                                        "You are ${userRoleVar.toString()} and not allowed to perform this action!");
                                  }
                                },
                                child: SvgPicture.asset(
                                    "assets/images/block.svg")),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  dp(
                                      msg: "role hive local",
                                      arg: userRoleVar.toString());
                                  dp(msg: "role enum", arg: UserRole.Viewer);
                                  if (userRoleVar.toString() ==
                                          UserRole.Owner.name ||
                                      userRoleVar.toString() ==
                                          UserRole.Admin.name) {
                                    userServices.approveBlockUser(
                                        widget.userModel,
                                        widget.userModel.userId.toString(),
                                        true);
                                  } else if (userRoleVar.toString() ==
                                          UserRole.Moderator.name ||
                                      userRoleVar.toString() ==
                                          UserRole.Viewer.name) {
                                    CommonDialog.roleAlertDialog(
                                        "You are ${userRoleVar.toString()} and not allowed to perform this action!");
                                  }
                                },
                                child: SvgPicture.asset(
                                  "assets/images/true.svg",
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: width * 0.03,
                            // ),
                            // InkWell(
                            //     onTap: () {
                            //       // userServices.updateUserData(widget.userModel,
                            //       //     widget.userModel.userId.toString());
                            //       userServices.deleteUser(
                            //           widget.userModel.userId.toString());
                            //     },
                            //     child: SvgPicture.asset(
                            //         "assets/images/delete.svg")),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
