import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/call_method.dart';
import '../../../../core/utils/whatsapp_launch_method.dart';
import '../../../home_page/data/models/main_item_data_model.dart';
import '../cubit/profile_cubit.dart';
import '../screens/agency_profile.dart';

class AgencyItem extends StatelessWidget {
  const AgencyItem({Key? key, required this.agentModel}) : super(key: key);
  final AgentModel agentModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgencyProfileScreen(agentModel: agentModel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: agentModel.image!,
                  width: 101,
                  height: 101,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: AppColors.primary2,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundColor: AppColors.primary2,
                    backgroundImage: imageProvider,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            agentModel.name!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                              onTap: () {
                                context
                                    .read<ProfileCubit>()
                                    .deleteAgent(agentModel.id!, context);
                              },
                              child: SvgPicture.asset(
                                  ImageAssets.deleteAccountIcon)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ElevatedButton.icon(
                                icon: SvgPicture.asset(ImageAssets.callIcon),
                                onPressed: () {
                                  phoneCallMethod(agentModel.phone!);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    backgroundColor:
                                        AppColors.callButtonBackground,
                                    side: BorderSide.none),
                                label: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: SizedBox(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 5,
                              child: ElevatedButton.icon(
                                icon:
                                    SvgPicture.asset(ImageAssets.whatsappIcon),
                                onPressed: () {
                                  launchWhatsApp(
                                    agentModel.phoneCode! +
                                        agentModel.whatsapp!,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    backgroundColor:
                                        AppColors.whatsappButtonBackground,
                                    side: BorderSide.none),
                                label: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: SizedBox(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
