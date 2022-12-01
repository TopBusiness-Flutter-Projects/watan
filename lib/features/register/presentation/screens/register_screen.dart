import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/core/widgets/custom_textfield.dart';
import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/profile_photo.dart';
import '../../../login/presentation/cubit/login_cubit.dart';
import '../cubit/register_cubit.dart';
import '../widgets/location_and_social_widget.dart';
import '../widgets/register_buttons.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key, required this.title, required this.isUser});

  final String title;
  final bool isUser;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit registerCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (context.read<LoginCubit>().isNewUser) {
      context.read<RegisterCubit>().registerBtn = 'save';
      context
          .read<RegisterCubit>()
          .putDataToEdit(context.read<LoginCubit>().userLoginModel!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    registerCubit.image = null;
    registerCubit.imageLink = '';
    registerCubit.registerBtn = '';
    registerCubit.nameController.clear();
    registerCubit.emailController.clear();
    registerCubit.passwordController.clear();
    registerCubit.phoneController.clear();
    registerCubit.whatsappController.clear();
    registerCubit.token = '';
    registerCubit.userType = 0;
    registerCubit.choose1 = false;
    registerCubit.choose2 = false;
    registerCubit.facebookController.clear();
    registerCubit.instaController.clear();
    registerCubit.twitterController.clear();
    registerCubit.snapController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          '${widget.title}',
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (BuildContext context, state) {
          registerCubit = context.read<RegisterCubit>();
          if (state is RegisterFailure) {
            Future.delayed(const Duration(seconds: 1), () {
              snackBar(translateText(AppStrings.someErrorMessage, context), context,color: AppColors.error);
            });
          }
          if (state is UpdateProfileLoading||state is RegisterLoading) {
            return const ShowLoadingIndicator();
          }
          if (state is UpdateStoreDataSuccessfully||state is RegisterLoaded) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, Routes.initialRoute);
            });
            return const ShowLoadingIndicator();
          }
          if(state is RegisterValidator){
            if(state.code==409){
              Future.delayed(Duration(milliseconds: 300),(){
                snackBar(translateText(AppStrings.phoneValidatorMessage, context), context,color: AppColors.error);
              });
            }else{
              Future.delayed(Duration(milliseconds: 300),(){
                snackBar(translateText(AppStrings.emailValidatorMessage, context), context,color: AppColors.error);
              });
            }
          }
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ProfilePhotoWidget(kind: "user"),
                      ],
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      imageColor: AppColors.primary,
                      controller: context.read<RegisterCubit>().nameController,
                      image: ImageAssets.idNameGoldIcon,
                      title: translateText(AppStrings.nameHint, context),
                      validatorMessage: translateText(
                        AppStrings.nameValidatorMessage,
                        context,
                      ),
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      imageColor: AppColors.primary,
                      controller: context.read<RegisterCubit>().phoneController,
                      image: ImageAssets.mobileGoldIcon,
                      title: translateText(AppStrings.phoneHint, context),
                      validatorMessage: translateText(
                        AppStrings.phoneValidatorMessage,
                        context,
                      ),
                      textInputType: TextInputType.phone,
                      isNum: true,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      imageColor: AppColors.primary,
                      controller:
                          context.read<RegisterCubit>().whatsappController,
                      image: ImageAssets.whatsappGoldIcon,
                      title: translateText(AppStrings.whatsappHint, context),
                      validatorMessage: translateText(
                        AppStrings.whatsappValidatorMessage,
                        context,
                      ),
                      isNum: true,
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      imageColor: AppColors.primary,
                      controller: context.read<RegisterCubit>().emailController,
                      image: ImageAssets.emailRegisterIcon,
                      title: translateText(AppStrings.emailHint, context),
                      validatorMessage: translateText(
                        AppStrings.emailValidatorMessage,
                        context,
                      ),
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      imageColor: AppColors.primary,
                      controller:
                          context.read<RegisterCubit>().passwordController,
                      image: ImageAssets.lockGoldIcon,
                      title: translateText(AppStrings.passwordHint, context),
                      validatorMessage: translateText(
                        AppStrings.passwordValidatorMessage,
                        context,
                      ),
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      imageColor: AppColors.primary,
                      controller: context
                          .read<RegisterCubit>()
                          .confirmPasswordController,
                      image: ImageAssets.lockGoldIcon,
                      title: translateText(
                          AppStrings.confirmPasswordHint, context),
                      validatorMessage: translateText(
                        AppStrings.confirmPasswordValidatorMessage,
                        context,
                      ),
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                    ),
                    widget.isUser
                        ? const SizedBox(height: 0)
                        : const LocationAndSocialWidget(),
                    const SizedBox(height: 25),
                    RegisterButtons(formKey: formKey,isUser: widget.isUser),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
