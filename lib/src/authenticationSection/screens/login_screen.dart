import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/src/authenticationSection/providers/loginauthprovider.dart';

import '../../../commonWidgets/auth_textfield_widget.dart';
import '../../../commonWidgets/button_widget.dart';
import '../../../utils/appcolors.dart';
import '../../../utils/themes.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAuthProvider>(builder: (context, authProvider, __) {
      return LoadingOverlay(
        isLoading: authProvider.isLoading,
        opacity: 0.2,
        progressIndicator: const SpinKitPouringHourGlass(
          size: 30,
          color: AppColors.appcolor,
        ),
        child: Scaffold(
          backgroundColor: AppColors.whitecolor,
          body: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 430,
                  width: 340,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(28)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    elevation: 4,
                    color: AppColors.whitecolor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 36),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Login',
                                      style: fontW5S12(context)!.copyWith(
                                          fontSize: 42,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.blackcolor)),
                                ],
                              ),
                              textScaleFactor: 0.6,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 36),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Please enter credentials to login',
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.lightdarktextcolor)),
                              ],
                            ),
                            textScaleFactor: 0.7,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AuthTextFieldWidget(
                                    showSuffixIcon: false,
                                    controller: authProvider.emailController,
                                    textFieldHeight: 55,
                                    maxlines: 1,
                                    toppadding: 18,
                                    maxLengt: 50,
                                    hintText: "Email Address",
                                    validator: (String? value) {
                                      if (value?.trim().isEmpty ?? true) {
                                        return "Email is requried";
                                      }

                                      String email = value ?? '';

                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(email);

                                      if (!emailValid) {
                                        return 'please use valid email address';
                                      }
                                      return null;
                                    },
                                    textInputType: TextInputType.emailAddress),
                                const SizedBox(
                                  height: 10,
                                ),
                                AuthTextFieldWidget(
                                    showSuffixIcon: true,
                                    controller: authProvider.passwordController,
                                    textFieldHeight: 55,
                                    obsecureText:
                                        authProvider.showconfirmobsecure,
                                    maxLengt: 50,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Password";
                                      }
                                    },
                                    maxlines: 1,
                                    onsuffixIconTap: () {
                                      setState(() {
                                        if (authProvider.showconfirmobsecure ==
                                            true) {
                                          authProvider.showconfirmobsecure =
                                              false;
                                        } else {
                                          authProvider.showconfirmobsecure =
                                              true;
                                        }
                                      });
                                    },
                                    suffixIcon: Icon(
                                        authProvider.showconfirmobsecure == true
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                    toppadding: 22,
                                    hintText: "Password",
                                    textInputType: TextInputType.emailAddress),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                // toNext(
                                //     context: context,
                                //     widget: ForgotPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password?",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.appcolor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CommonButtonWidget(
                              horizontalPadding: 8,
                              backgroundcolor: AppColors.appcolor,
                              text: "Login",
                              textfont: 16,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authProvider.loginUser();
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     "Don’t have account?",
                          //     style: fontW5S12(context)!.copyWith(
                          //         fontSize: 16,
                          //         color: AppColors.blackcolor,
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: InkWell(
                          //     onTap: () {
                          //       // toNext(
                          //       //     context: context,
                          //       //     widget:
                          //       //         const CreateAccountScreen());
                          //     },
                          //     child: Text(
                          //       "Create Account",
                          //       style: fontW5S12(context)!.copyWith(
                          //           fontSize: 16,
                          //           decoration: TextDecoration.underline,
                          //           color: AppColors.appcolor,
                          //           fontWeight: FontWeight.w400),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      );
    });
  }
}
