import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/appcolors.dart';
import '../utils/themes.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  const UserProfileHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SvgPicture.asset("assets/images/notificationicon.svg"),
        // const SizedBox(
        //   width: 20,
        // ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            "assets/images/randomdoc.png",
            height: 55,
            width: 55,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Admin",
              style: fontW5S12(context)!.copyWith(
                  fontSize: 15,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: fontW3S12(context)!.copyWith(
                  fontSize: 12,
                  color: AppColors.blackColor.withOpacity(0.3),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        SvgPicture.asset("assets/images/arrowdown.svg"),
      ],
    );
  }
}
