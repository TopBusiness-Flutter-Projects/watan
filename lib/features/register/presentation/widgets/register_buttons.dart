import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../cubit/register_cubit.dart';

// ignore: must_be_immutable
class RegisterButtons extends StatelessWidget {
  RegisterButtons({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;
  RegisterCubit? registerCubit;

  @override
  Widget build(BuildContext context) {
    registerCubit = context.read<RegisterCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {

                if (registerCubit!.registerBtn == 'update' ||
                    registerCubit!.registerBtn == 'save') {
                  registerCubit!.updateProfileData();
                } else {
                  if (formKey.currentState!.validate()) {
                    if (context.read<RegisterCubit>().passwordController.text !=
                        context
                            .read<RegisterCubit>()
                            .confirmPasswordController
                            .text) {
                      snackBar(
                          translateText(
                              AppStrings.passwordValidationMessage, context),
                          context,
                          color: AppColors.error);
                    } else if (context.read<RegisterCubit>().image == null) {
                      snackBar(translateText(AppStrings.selectImageValidator, context), context,
                          color: AppColors.error);
                    } else if (context.read<RegisterCubit>().longitude == 0 ||
                        context.read<RegisterCubit>().latitude == 0) {
                      snackBar(translateText(AppStrings.selectLocationText, context), context,
                          color: AppColors.error);
                    }else{
                      registerCubit!.postRegisterData();
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
                context.read<RegisterCubit>().registerBtn == "update"
                    ? translateText(AppStrings.updateBtnText, context)
                    : context.read<RegisterCubit>().registerBtn == "save"
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
  }
}
