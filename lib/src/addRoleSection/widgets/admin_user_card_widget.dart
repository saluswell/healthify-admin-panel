import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saluwell_admin_panel/src/usersSection/services/userServices.dart';

import '../../../commonWidgets/cacheNetworkImageWidget.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';
import '../models/admin_user_model.dart';

class AdminUsersCardWidget extends StatefulWidget {
  final AdminUserModel userModel;

  const AdminUsersCardWidget({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<AdminUsersCardWidget> createState() => _AdminUsersCardWidgetState();
}

class _AdminUsersCardWidgetState extends State<AdminUsersCardWidget> {
  UserServices userServices = UserServices();

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
                          imgUrl: widget.userModel.profilePicture.toString(),
                          radius: 7),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.userModel.emailAdress.toString(),
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 12,
                                  color: AppColors.blackColor.withOpacity(0.6),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                    text:
                                        widget.userModel.emailAdress.toString(),
                                  ));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Text copied to clipboard')),
                                  );
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: AppColors.blackColor.withOpacity(0.5),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 60,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //  if()
                            Text(
                              widget.userModel.role.toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: widget.userModel.role == "Owner"
                                      ? AppColors.redcolor
                                      : AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Role",
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
                                onTap: () {},
                                child: SvgPicture.asset(
                                    "assets/images/delete.svg")),
                            // SizedBox(
                            //   width: width * 0.03,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: InkWell(
                            //     onTap: () {},
                            //     child: SvgPicture.asset(
                            //       "assets/images/true.svg",
                            //       height: 35,
                            //       width: 35,
                            //     ),
                            //   ),
                            // ),
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
