import 'dart:async';

import 'package:elwatn/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/register_cubit.dart';
import '../widgets/header_title.dart';

// ignore: must_be_immutable
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";

  @override
  void initState() {
    super.initState();
    // if(context.read<RegisterCubit>().phone.isNotEmpty){
    context.read<RegisterCubit>().startTimer();
    // }
  }

  @override
  void dispose() {
    errorController!.close();
    // textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    errorController = StreamController<ErrorAnimationType>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.resetPasswordText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          // String time = context.read<RegisterCubit>().time;
          // if (state is CheckCodeInvalidCode) {
          //   Future.delayed(const Duration(seconds: 1), () {
          //     snackBar('Invalid Code Please Enter Correct Code', context,
          //         color: AppColors.error);
          //   });
          // }
          if (state is CheckCodeLoading) {
            return const ShowLoadingIndicator();
          }
          if (state is CheckCodeSuccessfully) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(
                context,
                Routes.newPasswordRoute,
              );
            });
            return const ShowLoadingIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    HeaderTitleWidget(
                      title:
                          translateText(AppStrings.resetPasswordTitle, context),
                      des: translateText(AppStrings.resetPasswordDesc, context),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            hintCharacter: '0',
                            pastedTextStyle: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                            appContext: context,
                            length: 6,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 5) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              inactiveColor: AppColors.gray,
                              activeColor: AppColors.gray,
                              shape: PinCodeFieldShape.underline,
                              selectedColor: AppColors.primary,
                            ),
                            cursorColor: AppColors.primary,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            errorAnimationController: errorController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? translateText(
                                AppStrings.resetPasswordValidatorMessage,
                                context)
                            : "",
                        style: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: translateText(AppStrings.doneBtn, context),
                      color: AppColors.primary,
                      paddingHorizontal: 60,
                      onClick: () {
                        formKey.currentState!.validate();
                        if (currentText.length != 6) {
                          errorController!.add(
                            ErrorAnimationType.shake,
                          ); // Triggering error shake animation
                          setState(() => hasError = true);
                        } else {
                          setState(
                            () {
                              hasError = false;
                              context
                                  .read<RegisterCubit>()
                                  .verifySmsCode(currentText, context);
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 22),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        String time =
                            context.read<RegisterCubit>().seconds.toString();
                        if(time=='60'){
                          time='';
                        }
                        return InkWell(
                          onTap:
                               () {
                            context.read<RegisterCubit>().startTimer();
                            context
                                      .read<RegisterCubit>()
                                      .sendSmsCode(context);
                                }
                          ,
                          child: Text(
                            time.isNotEmpty
                                ? time
                                : translateText(AppStrings.resendText, context),
                            style: TextStyle(
                              color: time.isNotEmpty
                                  ? AppColors.black
                                  : AppColors.primary,
                              fontSize: time.isNotEmpty ? 16.0 : 13.0,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  ImageAssets.resetPasswordImage,
                  height: 180,
                  width: 210,
                  fit: BoxFit.fill,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
