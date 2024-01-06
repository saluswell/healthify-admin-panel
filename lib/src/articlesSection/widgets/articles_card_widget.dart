import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saluwell_admin_panel/src/articlesSection/models/articleModel.dart';
import 'package:saluwell_admin_panel/src/articlesSection/services/articleServices.dart';

import '../../../commonWidgets/show_dialog.dart';
import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../helpers/time_ago.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/showsnackbar.dart';
import '../../../utils/themes.dart';
import '../../homeSection/screens/home_screen.dart';

class ArticlesCardWidget extends StatefulWidget {
  final ArticleModel articleModel;

  const ArticlesCardWidget({Key? key, required this.articleModel})
      : super(key: key);

  @override
  State<ArticlesCardWidget> createState() => _ArticlesCardWidgetState();
}

class _ArticlesCardWidgetState extends State<ArticlesCardWidget> {
  ArticleServices articleServices = ArticleServices();

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
                      padding: const EdgeInsets.all(17.0),
                      child: SvgPicture.asset(
                        "assets/images/6menu.svg",
                        height: 55,
                        width: 55,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.articleModel.articleTitle.toString(),
                          //"Libero pretium in quis egestas lectus viverra.",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              letterSpacing: 0.2,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              "Category Type ",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.articleModel.categoryType.toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.w700),
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.articleModel.categoryType.toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Category",
                              style: fontW3S12(context)!.copyWith(
                                  fontSize: 10,
                                  color: AppColors.blackColor.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: width * 0.05,
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "18 Mb",
                        //       style: fontW5S12(context)!.copyWith(
                        //           fontSize: 14,
                        //           color: AppColors.blueColor.withOpacity(0.8),
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //     const SizedBox(
                        //       height: 3,
                        //     ),
                        //     Text(
                        //       "File Size",
                        //       style: fontW3S12(context)!.copyWith(
                        //           fontSize: 10,
                        //           color: AppColors.blackColor.withOpacity(0.3),
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.articleModel.isApprovedByAdmin == true
                                  ? "Approved"
                                  : "Pending",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color:
                                      widget.articleModel.isApprovedByAdmin ==
                                              true
                                          ? AppColors.appcolor.withOpacity(0.8)
                                          : AppColors.redcolor.withOpacity(0.8),
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
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getTimeAgo(
                                  widget.articleModel.dateCreated!.toDate()),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Upload Date",
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
                                  articleServices.approvedRejectArticle(
                                      widget.articleModel,
                                      widget.articleModel.articleId,
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
                                  articleServices.approvedRejectArticle(
                                      widget.articleModel,
                                      widget.articleModel.articleId,
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
                                    articleServices.deleteArticle(widget
                                        .articleModel.articleId
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
