import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/appcolors.dart';
import '../utils/themes.dart';

class TextFieldWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? hintText;

  const TextFieldWidget(
      {Key? key,
      this.onChanged,
      this.controller,
      this.hintText = "Search Here..."})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 600,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: SvgPicture.asset("assets/images/Search.svg"),
            ),
            contentPadding: EdgeInsets.only(left: 45, top: 20),
            hintStyle: fontW5S12(context)!.copyWith(
                fontSize: 14,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
