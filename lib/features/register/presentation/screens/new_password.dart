import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/snackbar_method.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../cubit/register_cubit.dart';

class NewPassword extends StatelessWidget {
  NewPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.newPasswordText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          if (state is ResetPasswordInvalidCode) {
            Future.delayed(const Duration(seconds: 1), () {
              snackBar('Invalid Code Please Enter Correct Code', context,
                  color: AppColors.error);
            });
          }
          if (state is ResetPasswordLoading) {
            return const ShowLoadingIndicator();
          }
          if (state is ResetPasswordSuccessfully) {
            print("succccccccccccc");
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(
                context,
                Routes.loginScreenRoute,
              );
            });
            return const ShowLoadingIndicator();
          }
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                          child: Image.asset(
                        ImageAssets.newPasswordImage,
                        width: 210,
                        height: 150,
                      )),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(translateText(AppStrings.newPasswordTitle, context)),
                  const SizedBox(height: 32),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    image: ImageAssets.lockGoldIcon,
                    title: translateText(AppStrings.passwordHint, context),
                    validatorMessage: translateText(
                        AppStrings.passwordValidationMessage, context),
                    isPassword: true,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: confirmPasswordController,
                    image: ImageAssets.lockGoldIcon,
                    title:
                        translateText(AppStrings.confirmPasswordHint, context),
                    isPassword: true,
                    validatorMessage: translateText(
                        AppStrings.confirmPasswordValidatorMessage, context),
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 48),
                  CustomButton(
                    paddingHorizontal: 65,
                    text: translateText(AppStrings.confirmBtn, context),
                    color: AppColors.primary,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          snackBar(
                              translateText(
                                AppStrings.passwordValidationMessage,
                                context,
                              ),
                              context,
                              color: AppColors.error);
                        } else {
                          print('========00000=======');
                          print(
                            context.read<RegisterCubit>().phoneNumber,
                          );
                          context
                              .read<RegisterCubit>()
                              .resetPassword(passwordController.text);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
