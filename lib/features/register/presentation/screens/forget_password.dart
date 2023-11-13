import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/register_cubit.dart';
import '../widgets/header_title.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.forgetPasswordText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          if (state is CheckCodeInvalidCode) {
            snackBar(
              translateText(AppStrings.invalidPhoneMessage, context),
              context,
              color: AppColors.error,
            );
          }
          if (state is CheckCodeSuccessfully) {
            snackBar("message", context);
          }
          if (state is SendCodeLoading || state is CheckCodeLoading) {
            return const ShowLoadingIndicator();
          }
          if (state is OnSmsCodeSent) {
            Future.delayed(const Duration(seconds: 1), () {
              // Navigator.pushReplacementNamed(
              //   context,
              //   Routes.resetPasswordRoute,
              // );
            });
            return const ShowLoadingIndicator();
          }
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      HeaderTitleWidget(
                        title: translateText(
                            AppStrings.forgetPasswordTitle, context),
                        des: translateText(
                            AppStrings.forgetPasswordDesc, context),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        imageColor: AppColors.primary,
                        controller:
                            context.read<RegisterCubit>().phoneController,
                        image: ImageAssets.mobileGoldIcon,
                        title: translateText(AppStrings.phoneHint, context),
                        validatorMessage: translateText(
                          AppStrings.phoneValidatorMessage,
                          context,
                        ),
                        textInputType: TextInputType.phone,
                        isNum: true,
                      ),
                      const SizedBox(height: 60),
                      CustomButton(
                        text: translateText(AppStrings.sendBtn, context),
                        color: AppColors.primary,
                        paddingHorizontal: 60,
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            if (context
                                        .read<RegisterCubit>()
                                        .phoneController
                                        .text
                                        .length <
                                    10 ||
                                context
                                        .read<RegisterCubit>()
                                        .phoneController
                                        .text
                                        .length >
                                    11) {
                              print(context
                                  .read<RegisterCubit>()
                                  .phoneController
                                  .text
                                  .length);
                              snackBar(
                                translateText(
                                    AppStrings.correctPhoneText, context),
                                context,
                                color: AppColors.error,
                              );
                            } else {
                              context.read<RegisterCubit>().phoneNumber =
                                  context
                                              .read<RegisterCubit>()
                                              .phoneController
                                              .text
                                              .length ==
                                          11
                                      ? AppStrings.phoneCode +
                                          context
                                              .read<RegisterCubit>()
                                              .phoneController
                                              .text
                                              .substring(1)
                                      : AppStrings.phoneCode +
                                          context
                                              .read<RegisterCubit>()
                                              .phoneController
                                              .text;
                              context.read<RegisterCubit>().checkCode(
                                    context
                                                .read<RegisterCubit>()
                                                .phoneController
                                                .text
                                                .length ==
                                            11
                                        ? AppStrings.phoneCode +
                                            context
                                                .read<RegisterCubit>()
                                                .phoneController
                                                .text
                                                .substring(1)
                                        : AppStrings.phoneCode +
                                            context
                                                .read<RegisterCubit>()
                                                .phoneController
                                                .text,
                                    context,
                                  );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    ImageAssets.forgetPasswordImage,
                    height: 180,
                    width: MediaQuery.of(context).size.width / 2 + 80,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
