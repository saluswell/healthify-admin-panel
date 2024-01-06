import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/providers/loginauthprovider.dart';

import '../utils/appcolors.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget(
      {Key? key,
      required this.controller,
      required this.textFieldHeight,
      required this.maxlines,
      this.toppadding = 0,
      required this.hintText,
      this.validator,
      required this.textInputType,
      this.enabled,
      this.inputFormatters,
      this.onChanged,
      this.maxLengt,
      this.scrollController,
      this.showSuffixIcon = false,
      this.suffixIcon,
      this.obsecureText = false,
      this.onsuffixIconTap})
      : super(key: key);

  final TextEditingController controller;
  final double textFieldHeight;
  final int maxlines;
  final double toppadding;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final int? maxLengt;
  final ScrollController? scrollController;
  final bool showSuffixIcon;
  final Icon? suffixIcon;
  final bool obsecureText;
  final VoidCallback? onsuffixIconTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Consumer<LoginAuthProvider>(builder: (context, authProvider, __) {
        return Container(
          // height: textFieldHeight,
          // width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightwhitecolor,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextFormField(
            // enableInteractiveSelection: true,

            scrollController: scrollController,

            enableSuggestions: true,
            //   enableIMEPersonalizedLearning: true,
            autofocus: false,
            autocorrect: true,

            maxLength: maxLengt,

            enabled: enabled,
            style: const TextStyle(
                // textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: AppColors.blackcolor),
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:\.\d+)?$')),
            // ],
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxlines,
            validator: validator,
            obscureText: obsecureText,
            decoration: InputDecoration(
                isDense: true,
                counter: const SizedBox(),
                errorStyle: TextStyle(height: 0.1, fontSize: 11),
                hintStyle: const TextStyle(
                    // textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 14,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: AppColors.lightdarktextcolor),
                hintText: hintText,
                suffixIcon: showSuffixIcon == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: IconButton(
                          icon: suffixIcon!,
                          onPressed: onsuffixIconTap,
                          color: AppColors.lightdarktextcolor,
                        ),
                      )
                    : const Text(""),
                contentPadding:
                    EdgeInsets.only(left: 15, top: toppadding, right: 5),
                border: InputBorder.none),
          ),
        );
      }),
    );
  }
}
