import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/core/widgets/long_text.dart';
import 'package:elwatn/core/widgets/network_image.dart';
import 'package:elwatn/core/widgets/social_media_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../details/presentation/widgets/communcation.dart';
import '../../../details/presentation/widgets/icon_shape.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';
import '../../../home_page/data/models/main_item_data_model.dart';
import '../cubit/profile_cubit.dart';

class AgencyProfileScreen extends StatelessWidget {
  const AgencyProfileScreen({Key? key, required this.agentModel})
      : super(key: key);
  final AgentModel agentModel;

  @override
  Widget build(BuildContext context) {
    TextEditingController facebookController = TextEditingController();
    TextEditingController instaController = TextEditingController();
    TextEditingController twitterController = TextEditingController();
    TextEditingController snapController = TextEditingController();
    facebookController.text = agentModel.facebook ?? "";
    instaController.text = agentModel.instagram ?? "";
    twitterController.text = agentModel.twitter ?? "";
    snapController.text = agentModel.snapchat ?? "";

    String changeLanguage(String lan) {
      if (lan == 'en') {
        return translateText(AppStrings.englishLanguage, context);
      } else if (lan == 'ar') {
        return translateText(AppStrings.arabicLanguage, context);
      } else if (lan == 'ku') {
        return translateText(AppStrings.kurdishLanguage, context);
      } else {
        return '';
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ManageNetworkImage(
                    imageUrl: agentModel.image!,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 0,
                  ),
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: IconShapeWidget(
                                text: "null",
                                icon: Icons.arrow_back_sharp,
                                onClick: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                        ),
                        Expanded(
                          child: IconShapeWidget(
                            text: "null",
                            icon: Icons.edit,
                            onClick: () {
                              context.read<ProfileCubit>().agentBtnText =
                                  "update";
                              context
                                  .read<ProfileCubit>()
                                  .putDataToEdit(agentModel);
                              Navigator.pushNamed(
                                context,
                                Routes.newAndEditAgencyScreenRoute,
                              );
                            },
                          ),
                        ),
                        Expanded(
                            child: IconShapeWidget(
                                text: "null",
                                icon: Icons.share,
                                onClick: () {})),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTileAllDetailsWidget(
                image: ImageAssets.propertyIcon,
                text: agentModel.name ?? '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                        child: SvgPicture.asset(
                      ImageAssets.speakIcon,
                      width: 20,
                      height: 20,
                      color: AppColors.black,
                    )),
                    Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          ...List.generate(
                            agentModel.languages!.length,
                            (index) => Text(
                              " ${changeLanguage(agentModel.languages![index])} ${index == agentModel.languages!.length - 1 ? "" : " , "}",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Divider(thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    Align(
                      alignment: IsLanguage.isEnLanguage(context)
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child:
                          Text(translateText(AppStrings.aboutUsText, context)),
                    ),
                    const SizedBox(height: 12),
                    LongText(text: agentModel.about ?? "no about"),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Divider(thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    Align(
                      alignment: IsLanguage.isEnLanguage(context)
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Text(
                        translateText(
                          AppStrings.socialMediaTitle,
                          context,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SocialMediaWidget(
                      facebookController: facebookController,
                      instaController: instaController,
                      snapController: snapController,
                      twitterController: twitterController,
                      isEnable: false,
                      topRight: IsLanguage.isEnLanguage(context) ? 10 : 0,
                      topLeft: IsLanguage.isEnLanguage(context) ? 0 : 10,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Divider(thickness: 2),
              ),
              CommunicationWidget(
                whatsapp: agentModel.phoneCode! + agentModel.whatsapp!,
                phone: agentModel.phone!,
                type: 'agent',
                userId: 0,
                postId: 0,
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
