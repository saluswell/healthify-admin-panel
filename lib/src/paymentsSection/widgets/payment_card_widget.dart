import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saluwell_admin_panel/src/paymentsSection/models/paymentModel.dart';
import 'package:saluwell_admin_panel/src/paymentsSection/services/payment_servicess.dart';

import '../../../commonWidgets/cacheNetworkImageWidget.dart';
import '../../../commonWidgets/show_dialog.dart';
import '../../../helpers/hive_constants.dart';
import '../../../helpers/hive_local_storage.dart';
import '../../../helpers/time_ago.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/showsnackbar.dart';
import '../../../utils/themes.dart';
import '../../homeSection/screens/home_screen.dart';

class PaymentsCardWidget extends StatefulWidget {
  final PaymentModel paymentModel;

  const PaymentsCardWidget({Key? key, required this.paymentModel})
      : super(key: key);

  @override
  State<PaymentsCardWidget> createState() => _PaymentsCardWidgetState();
}

class _PaymentsCardWidgetState extends State<PaymentsCardWidget> {
  PaymenstServices paymenstServices = PaymenstServices();

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
                          imgUrl: widget.paymentModel.senderpic.toString(),
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
                          widget.paymentModel.senderName.toString(),
                          // "Marcelino Kindred",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Paid By",
                          style: fontW3S12(context)!.copyWith(
                              fontSize: 10,
                              color: Colors.red.withOpacity(0.7),
                              fontWeight: FontWeight.w600),
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
                          imgUrl: widget.paymentModel.recieverPic.toString(),
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
                          widget.paymentModel.reciverName.toString(),
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Paid To",
                          style: fontW3S12(context)!.copyWith(
                              fontSize: 10,
                              color: Colors.green.withOpacity(0.7),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "\$${widget.paymentModel.totalAmount}",
                              // "\$455.99",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blueColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Transaction Amount",
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
                              getTimeAgo(widget.paymentModel.paymentDateTime!
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
                              "Transaction Date",
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
                              formatTime(widget.paymentModel.paymentDateTime!
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
                              "Transaction Time",
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
                                    paymenstServices.deletePayment(widget
                                        .paymentModel.paymentId
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
