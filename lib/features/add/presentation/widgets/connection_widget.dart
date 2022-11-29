import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../add_project/presentation/cubit/add_project_cubit.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key, this.kind = 'null'}) : super(key: key);

  final String kind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileAllDetailsWidget(
            image: ImageAssets.callIcon,
            text: translateText(AppStrings.contactDetailsText, context),
            isAddScreen: true,
            iconColor: AppColors.primary,),
        CustomTextField(
          imageColor:  AppColors.primary,
          controller: kind == 'addProject'
              ? context.read<AddProjectCubit>().nameController
              : context.read<AddAdsCubit>().nameController,
          image: ImageAssets.idNameGoldIcon,
          title: translateText(AppStrings.nameHint, context),
          textInputType: TextInputType.text,
          validatorMessage:
              translateText(AppStrings.nameValidatorMessage, context),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          imageColor:  AppColors.primary,
          controller: kind == 'addProject'
              ? context.read<AddProjectCubit>().phoneController
              : context.read<AddAdsCubit>().phoneController,
          image: ImageAssets.mobileGoldIcon,
          title: translateText(AppStrings.phoneHint, context),
          textInputType: TextInputType.number,
          validatorMessage:
              translateText(AppStrings.phoneValidatorMessage, context),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          imageColor:  AppColors.primary,
          controller: kind == 'addProject'
              ? context.read<AddProjectCubit>().whatsappController
              : context.read<AddAdsCubit>().whatsappController,
          image: ImageAssets.whatsappGoldIcon,
          title: translateText(AppStrings.whatsappHint, context),
          textInputType: TextInputType.number,
          validatorMessage:
              translateText(AppStrings.whatsappValidatorMessage, context),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
