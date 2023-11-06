import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/features/profile/presentation/widgets/list_tile_profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/utils/translate_text_method.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../../my_ads/presentation/screens/my_ads.dart';
import '../../../packages/presentation/screens/package_screen.dart';
import '../../../register/presentation/cubit/register_cubit.dart';
import '../../../register/presentation/screens/register_screen.dart';
import '../cubit/profile_cubit.dart';

class BodyProfileWidget extends StatelessWidget {
  const BodyProfileWidget({Key? key, required this.loginDataModel})
      : super(key: key);
  final LoginDataModel loginDataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTileProfileItem(
                text: translateText(AppStrings.myAddsText, context),
                image: ImageAssets.adsGoldIcon,
                onClick: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyAdsScreen(
                      loginModel: loginDataModel,
                      kindOfClass: 'myAds',
                    ),
                  ),
                ),
              ),
              loginDataModel.data!.user!.userType != 3
                  ? ListTileProfileItem(
                      text:
                          translateText(AppStrings.soledPropertyText, context),
                      image: ImageAssets.soledGoldIcon,
                      onClick: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyAdsScreen(
                            loginModel: loginDataModel,
                            kindOfClass: 'mySolid',
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              loginDataModel.data!.user!.userType != 1
                  ? ListTileProfileItem(
                      text: translateText(AppStrings.agencyText, context),
                      image: ImageAssets.agencyGoldIcon,
                      onClick: () {
                        Navigator.pushNamed(context, Routes.agencyScreenRoute);
                      },
                    )
                  : const SizedBox(height: 0),
              loginDataModel.data!.user!.userType != 1
                  ? ListTileProfileItem(
                      text: translateText(AppStrings.packagesText, context),
                      image: ImageAssets.packagesIcon,
                      onClick: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PackageScreen(
                            loginDataModel: loginDataModel,
                          );
                        }));
                      },
                    )
                  : const SizedBox(height: 0),
              ListTileProfileItem(
                text: translateText(AppStrings.editProfileText, context),
                image: ImageAssets.editorIcon,
                onClick: () {
                  context.read<RegisterCubit>().registerBtn = "update";
                  context.read<RegisterCubit>().putDataToEdit(loginDataModel);
                  print(loginDataModel.data!.user!.userType);
                  if (loginDataModel.data!.user!.userType == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen(
                            title: translateText(
                                AppStrings.updateProfileTitle, context),
                            isUser: true,
                          );
                        },
                      ),
                    );
                  } else {
                    print("else");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen(
                            title: translateText(
                                AppStrings.updateProfileTitle, context),
                            isUser: false,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              ListTileProfileItem(
                text: translateText(AppStrings.deleteAccountText, context),
                image: ImageAssets.deleteAccountIcon,
                onClick: () {
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title:
                        "\n${translateText(AppStrings.deleteAccountText, context)}",
                    desc:
                        "\n\n${translateText(AppStrings.waringDeleteAccountMessage, context)}\n\n",
                    buttons: [
                      DialogButton(
                        onPressed: () => Navigator.pop(context),
                        color: AppColors.buttonBackground,
                        child: Text(
                          translateText(AppStrings.cancelBtn, context),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      DialogButton(
                          onPressed: () {
                            context.read<ProfileCubit>().deleteUserAccount(
                                loginDataModel.data!.accessToken!, context);
                          },
                          color: AppColors.error,
                          child: Text(
                              translateText(AppStrings.confirmBtn, context),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)))
                    ],
                  ).show();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
