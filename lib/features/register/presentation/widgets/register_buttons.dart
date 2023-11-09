import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../cubit/register_cubit.dart';

// ignore: must_be_immutable
class RegisterButtons extends StatelessWidget {
  RegisterButtons({Key? key, required this.formKey, required this.isUser})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        RegisterCubit registerCubit = context.read<RegisterCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    String phone = registerCubit.phoneController.text;
                    String whatsapp = registerCubit.whatsappController.text;

                    if (registerCubit.registerBtn == 'update' ||
                        registerCubit.registerBtn == 'save') {
                      if (phone.length < 10 || phone.length > 11) {
                        snackBar(
                          translateText(AppStrings.correctPhoneText, context),
                          context,
                          color: AppColors.error,
                        );
                      } else if (whatsapp.length < 10 || whatsapp.length > 11) {
                        snackBar(
                          translateText(
                              AppStrings.correctWhatsappText, context),
                          context,
                          color: AppColors.error,
                        );
                      } else {
                        registerCubit.updateProfileData();
                      }
                    } else {
                      if (formKey.currentState!.validate()) {
                        if (registerCubit.passwordController.text.length < 6) {
                          snackBar(
                            translateText(
                              AppStrings.passwordLengthValidationMessage,
                              context,
                            ),
                            context,
                            color: AppColors.error,
                          );
                        } else if (registerCubit.passwordController.text !=
                            registerCubit.confirmPasswordController.text) {
                          snackBar(
                            translateText(
                              AppStrings.passwordValidationMessage,
                              context,
                            ),
                            context,
                            color: AppColors.error,
                          );
                        }
                        // else if (registerCubit.image == null) {
                        //   snackBar(
                        //       translateText(
                        //           AppStrings.selectImageValidator, context),
                        //       context,
                        //       color: AppColors.error);
                        // }
                        else if (phone.length < 10 || phone.length > 11) {
                          snackBar(
                            translateText(AppStrings.correctPhoneText, context),
                            context,
                            color: AppColors.error,
                          );
                        } else if (whatsapp.length < 10 ||
                            whatsapp.length > 11) {
                          snackBar(
                            translateText(
                                AppStrings.correctWhatsappText, context),
                            context,
                            color: AppColors.error,
                          );
                        } else {
                          registerCubit.postRegisterData();
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      maximumSize: Size.infinite,
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(155, 56),
                      backgroundColor: AppColors.primary),
                  child: Text(
                    registerCubit.registerBtn == "update"
                        ? translateText(AppStrings.updateBtnText, context)
                        : registerCubit.registerBtn == "save"
                            ? translateText(AppStrings.saveText, context)
                            : translateText(AppStrings.startBtn, context),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      maximumSize: Size.infinite,
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(155, 56),
                      backgroundColor: AppColors.buttonBackground),
                  child: Text(
                    translateText(AppStrings.backBtn, context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
