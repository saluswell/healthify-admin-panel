import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';

class StatsCardWidget extends StatelessWidget {
  final String headText;
  final String count;
  final String increase;
  final Color imageColor;

  const StatsCardWidget(
      {Key? key,
      required this.headText,
      required this.count,
      required this.increase,
      required this.imageColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 270,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                headText,
                style: fontW3S12(context)!.copyWith(
                    fontSize: 13,
                    color: AppColors.blackColor.withOpacity(0.8),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                count,
                style: fontW3S12(context)!.copyWith(
                    fontSize: 27,
                    color: AppColors.blackColor.withOpacity(0.9),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                increase,
                style: fontW3S12(context)!.copyWith(
                    fontSize: 12,
                    color: AppColors.blueColor.withOpacity(0.9),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: SvgPicture.asset(
                  "assets/images/linegraph.svg",
                  height: 40,
                  color: imageColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
