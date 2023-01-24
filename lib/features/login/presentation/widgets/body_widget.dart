import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/login_cubit.dart';
import '../screens/social_media_web_view.dart';

// ignore: must_be_immutable
class LoginBodyWidget extends StatelessWidget {
  LoginBodyWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // emailController.text='ahmad75yehia@gmail.com';
    // passwordController.text='000000';
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.longestSide,
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Image.asset(
                          ImageAssets.watanLogo,
                          height: 150,
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text(
                            translateText(AppStrings.emailHint, context),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return translateText(
                              AppStrings.emailValidatorMessage,
                              context,
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          label: Text(
                            translateText(AppStrings.passwordHint, context),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return translateText(
                                AppStrings.passwordValidatorMessage, context);
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 60),
                    CustomButton(
                      text: translateText(AppStrings.loginText, context),
                      color: AppColors.primary,
                      paddingHorizontal: 25,
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().postLoginData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.welcomeRegisterRoute);
                            },
                            child: Text(
                              translateText(AppStrings.registerText, context),
                              style: TextStyle(color: AppColors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.forgetPasswordRoute);
                            },
                            child: Text(
                              translateText(
                                  AppStrings.forgetPasswordText, context),
                              style: TextStyle(color: AppColors.black),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            thickness: 1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Text(
                        translateText(AppStrings.orText, context),
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            thickness: 1,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SocialMediaWebView(
                                  url:
                                      'https://watan.motaweron.com/api/auth/social/login/google',
                                );
                              },
                            ),
                          );
                        },
                        child: Image.asset(
                          ImageAssets.socialGoogleImage,
                          width: 54,
                          height: 54,
                        ),
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SocialMediaWebView(
                                  url:
                                      'https://watan.motaweron.com/api/auth/social/login/facebook',
                                );
                              },
                            ),
                          );
                        },
                        child: Image.asset(
                          ImageAssets.socialFacebookImage,
                          width: 54,
                          height: 54,
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      ImageAssets.cityImage,
                      fit: BoxFit.fitWidth,
                      height: 55,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
