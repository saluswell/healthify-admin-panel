import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saluwell_admin_panel/commonWidgets/show_dialog.dart';
import 'package:saluwell_admin_panel/helpers/time_ago.dart';
import 'package:saluwell_admin_panel/src/appointmnetsSection/models/appointmentModel.dart';
import 'package:saluwell_admin_panel/src/appointmnetsSection/services/appointmentServices.dart';
import 'package:saluwell_admin_panel/src/homeSection/screens/home_screen.dart';
import 'package:saluwell_admin_panel/utils/showsnackbar.dart';

import '../../../commonWidgets/cacheNetworkImageWidget.dart';
import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';

class CareProviderCardWidget extends StatefulWidget {
  final AppointmentModel appointmentModel;

  const CareProviderCardWidget({Key? key, required this.appointmentModel})
      : super(key: key);

  @override
  State<CareProviderCardWidget> createState() => _CareProviderCardWidgetState();
}

class _CareProviderCardWidgetState extends State<CareProviderCardWidget> {
  AppointmentServices appointmentServices = AppointmentServices();

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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CacheNetworkImageWidget(
                          height: 55,
                          width: 55,
                          imgUrl: widget.appointmentModel.dietitianProfilePic
                              .toString(),
                          radius: 7),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.appointmentModel.dietitianName.toString(),
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Dietitian",
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CacheNetworkImageWidget(
                          height: 55,
                          width: 55,
                          imgUrl: widget.appointmentModel.patientProfilePic
                              .toString(),
                          radius: 7),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.appointmentModel.patientName.toString(),
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Patient",
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.appointmentModel.appointmentStatus ==
                                      "progress"
                                  ? "In Progress"
                                  : "Completed",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: widget.appointmentModel
                                              .appointmentStatus ==
                                          "progress"
                                      ? AppColors.blackColor.withOpacity(0.8)
                                      : AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Status",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$${widget.appointmentModel.appointmentFees}",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blueColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Appointment Fees",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTimeAgo(widget
                                  .appointmentModel.appointmentDateTime!
                                  .toDate()),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Appointment Date",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formatTime(widget
                                  .appointmentModel.appointmentDateTime!
                                  .toDate()),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blueColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Time",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.07,
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
                                  appointmentServices.completeAppointment(
                                      widget.appointmentModel,
                                      widget.appointmentModel.appointmentId
                                          .toString(),
                                      "progress");
                                } else if (userRoleVar.toString() ==
                                        UserRole.Moderator.name ||
                                    userRoleVar.toString() ==
                                        UserRole.Viewer.name) {
                                  CommonDialog.roleAlertDialog(
                                      "You are ${userRoleVar.toString()} and not allowed to perform this action!");
                                }
                              },
                              child: SvgPicture.asset(
                                "assets/images/close.svg",
                                height: 35,
                                width: 35,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
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
                                  appointmentServices.completeAppointment(
                                      widget.appointmentModel,
                                      widget.appointmentModel.appointmentId
                                          .toString(),
                                      "completed");
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
                            SizedBox(
                              width: width * 0.02,
                            ),
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
                                    appointmentServices.deleteAppointment(widget
                                        .appointmentModel.appointmentId
                                        .toString());
                                  } else if (userRoleVar.toString() ==
                                          UserRole.Moderator.name ||
                                      userRoleVar.toString() ==
                                          UserRole.Viewer.name) {
                                    CommonDialog.roleAlertDialog(
                                        "You are ${userRoleVar.toString()} and not allowed to perform this action!");
                                  }
                                },
                                child: SvgPicture.asset(
                                    "assets/images/delete.svg")),
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
