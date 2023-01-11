import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/features/app_settings/domain/entities/app_setting_domain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../cubit/filter_cubit.dart';

class AreaRangeWidget extends StatelessWidget {
  const AreaRangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        SvgPicture.asset(ImageAssets.areaGoldIcon,width: 20,height: 20,),
        const SizedBox(width: 10),
         Text(translateText(AppStrings.areaRangeText,context),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
      ],),
      const SizedBox(height: 20),
      Row(children: [
        Expanded(
          child: TextFormField(
            controller: context.read<FilterCubit>().areaFromController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              hintText: translateText(AppStrings.fromText, context),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 25),
         Text(
          ' _ ',
          style: TextStyle(fontSize: 12),),
        const SizedBox(width: 25),
        Expanded(
          child: TextFormField(
            controller: context.read<FilterCubit>().areaToController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              hintText: translateText(AppStrings.toText, context),
            ),
          ),
        ),
      ],)

    ],);
  }
}
