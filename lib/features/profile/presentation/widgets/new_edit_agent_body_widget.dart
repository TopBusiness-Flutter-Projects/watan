import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/profile_photo.dart';
import '../../../../core/widgets/social_media_icons.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/choose_language.dart';

class NewEditAgentBodyWidget extends StatelessWidget {
  NewEditAgentBodyWidget({Key? key, required this.status}) : super(key: key);
  final String status;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (status == "error") {
      Future.delayed(const Duration(seconds: 1), () {
        _formKey.currentState!.validate();
      });
    }
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ProfilePhotoWidget(kind: "agent"),
              ],
            ),
            const SizedBox(height: 12),
            CustomTextField(
              isAgent: true,
              imageColor: AppColors.primary,
              controller: context.read<ProfileCubit>().nameController,
              image: ImageAssets.idNameGoldIcon,
              title: translateText(AppStrings.nameHint, context),
              validatorMessage: context.read<ProfileCubit>().statusCode != 422
                  ? translateText(
                      AppStrings.nameValidatorMessage,
                      context,
                    )
                  : "",
              textInputType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.speakIcon,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    translateText(AppStrings.languageTitle, context),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                children: [
                  const Spacer(),
                  ChooseLanguageWidget(
                    title: translateText(AppStrings.englishLanguage, context),
                    image: ImageAssets.englishLanguageImage,
                  ),
                  const Spacer(),
                  ChooseLanguageWidget(
                    title: translateText(AppStrings.arabicLanguage, context),
                    image: ImageAssets.iraqLanguageImage,
                  ),
                  const Spacer(),
                  ChooseLanguageWidget(
                    title: translateText(AppStrings.kurdishLanguage, context),
                    image: ImageAssets.kurdishLanguageImage,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CustomTextField(
              isAgent: true,
              imageColor: AppColors.primary,
              controller: context.read<ProfileCubit>().emailController,
              image: ImageAssets.emailRegisterIcon,
              title: translateText(AppStrings.emailHint, context),
              validatorMessage: context.read<ProfileCubit>().statusCode != 422
                  ? translateText(
                      AppStrings.emailValidatorMessage,
                      context,
                    )
                  : context.read<ProfileCubit>().emailValidator,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              isAgent: true,
              imageColor: AppColors.primary,
              controller: context.read<ProfileCubit>().phoneController,
              image: ImageAssets.mobileGoldIcon,
              title: translateText(AppStrings.phoneHint, context),
              validatorMessage: context.read<ProfileCubit>().statusCode != 422
                  ? translateText(
                      AppStrings.phoneValidatorMessage,
                      context,
                    )
                  : context.read<ProfileCubit>().phoneValidator,
              textInputType: TextInputType.phone,
              isNum: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              isAgent: true,
              imageColor: AppColors.primary,
              controller: context.read<ProfileCubit>().whatsappController,
              image: ImageAssets.whatsappGoldIcon,
              validatorMessage: context.read<ProfileCubit>().statusCode != 422
                  ? translateText(
                      AppStrings.whatsappValidatorMessage,
                      context,
                    )
                  : "",
              title: translateText(AppStrings.whatsappHint, context),
              textInputType: TextInputType.phone,
              isNum: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              isAgent: true,
              imageColor: AppColors.primary,
              controller: context.read<ProfileCubit>().aboutController,
              image: ImageAssets.aboutIcon,
              validatorMessage: context.read<ProfileCubit>().statusCode != 422
                  ? translateText(
                      AppStrings.aboutValidatorMessage,
                      context,
                    )
                  : "",
              title: translateText(AppStrings.aboutUsText, context),
              textInputType: TextInputType.text,
              minLine: 6,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              isAgent: true,
              imageColor: AppColors.primary,
              controller: context.read<ProfileCubit>().passwordController,
              image: ImageAssets.lockGoldIcon,
              title: translateText(AppStrings.passwordHint, context),
              validatorMessage: context.read<ProfileCubit>().statusCode != 422
                  ? translateText(
                      AppStrings.passwordValidatorMessage,
                      context,
                    )
                  : "",
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 12),
            SocialMediaWidget(
              facebookController:
                  context.read<ProfileCubit>().facebookController,
              instaController: context.read<ProfileCubit>().instaController,
              snapController: context.read<ProfileCubit>().snapController,
              twitterController: context.read<ProfileCubit>().twitterController,
              isEnable: true,
              topRight: IsLanguage.isEnLanguage(context) ? 10 : 0,
              topLeft: IsLanguage.isEnLanguage(context) ? 0 : 10,
            ),
            const SizedBox(height: 48),
            CustomButton(
              paddingHorizontal: 65,
              text: context.read<ProfileCubit>().agentBtnText != "update"
                  ? translateText(AppStrings.createBtnText, context)
                  : translateText(AppStrings.updateBtnText, context),
              color: AppColors.primary,
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  if (context.read<ProfileCubit>().image == null &&
                      context.read<ProfileCubit>().agentBtnText == '') {
                    print("noupdate");
                    snackBar(
                      translateText(AppStrings.choosePhotoMessage, context),
                      context,
                      color: AppColors.error,
                    );
                  } else if (context.read<ProfileCubit>().imageLink == '' &&
                      context.read<ProfileCubit>().agentBtnText == 'update') {
                    print("update");
                    snackBar(
                      translateText(AppStrings.choosePhotoMessage, context),
                      context,
                      color: AppColors.error,
                    );
                  } else if (context.read<ProfileCubit>().languages.isEmpty) {
                    snackBar("please Choose Language", context,
                        color: AppColors.error);
                  }
                  if (context.read<ProfileCubit>().phoneController.text.length <
                          10 ||
                      context.read<ProfileCubit>().phoneController.text.length >
                          11) {
                    snackBar(
                        translateText(AppStrings.correctPhoneText, context),
                        context,
                        color: AppColors.error);
                  } else if (context
                              .read<ProfileCubit>()
                              .whatsappController
                              .text
                              .length <
                          10 ||
                      context
                              .read<ProfileCubit>()
                              .whatsappController
                              .text
                              .length >
                          11) {
                    snackBar(
                        translateText(AppStrings.correctWhatsappText, context),
                        context,
                        color: AppColors.error);
                  } else {
                    if (context.read<ProfileCubit>().agentBtnText == "update") {
                      context
                          .read<ProfileCubit>()
                          .editAgent(context.read<ProfileCubit>().agentModel);
                    } else {
                      context.read<ProfileCubit>().postNewAgent();
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
