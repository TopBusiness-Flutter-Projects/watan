import 'package:elwatn/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../add_project/presentation/cubit/add_project_cubit.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';
import '../cubit/add_ads_cubit.dart';

class PropertyDetailsWidget extends StatelessWidget {
  const PropertyDetailsWidget({Key? key, this.kind = 'null'}) : super(key: key);
  final String kind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileAllDetailsWidget(
          image: ImageAssets.areaIcon,
          text: translateText(AppStrings.propertyDetailsText,context),
          iconColor: AppColors.primary,
          isAddScreen: true,
        ),
        const SizedBox(height: 6),
        CustomTextField(
          image: "null",
          title: translateText(AppStrings.titleHint,context),
          controller: kind == 'addProject'
              ? context.read<AddProjectCubit>().titleController
              : context.read<AddAdsCubit>().titleController,
          textInputType: TextInputType.text,
          validatorMessage: translateText(AppStrings.titleValidator,context),
        ),
        CustomTextField(
          image: "null",
          title: translateText(AppStrings.descHint,context),
          textInputType: TextInputType.text,
          minLine: 5,
          controller: kind == 'addProject'
              ? context.read<AddProjectCubit>().descController
              : context.read<AddAdsCubit>().descController,
          validatorMessage: translateText(AppStrings.descValidator,context),
        ),
      ],
    );
  }
}
