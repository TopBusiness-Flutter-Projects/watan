import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/convert_numbers_method.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/icon_with_text_widget.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';

class FloorPlansWidget extends StatelessWidget {
  const FloorPlansWidget({Key? key, required this.unitDetail})
      : super(key: key);
  final UnitDetail unitDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconWithTextWidget(
          text: translateText(AppStrings.floorPlanText, context),
          icon: ImageAssets.packagesIcon,
          iconColor: AppColors.black,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithTextWidget(
                text: !IsLanguage.isEnLanguage(context)
                    ? replaceToArabicNumber(unitDetail.area!)
                    : unitDetail.area!,
                icon: ImageAssets.areaGoldIcon,
                iconColor: AppColors.black,
              ),
              IconWithTextWidget(
                text: !IsLanguage.isEnLanguage(context)
                    ? replaceToArabicNumber(unitDetail.bedrooms!)
                    : unitDetail.bedrooms!,
                icon: ImageAssets.roomsIcon,
                iconColor: AppColors.black,
              ),
              IconWithTextWidget(
                text: !IsLanguage.isEnLanguage(context)
                    ? replaceToArabicNumber(unitDetail.bathrooms!)
                    : unitDetail.bathrooms!,
                icon: ImageAssets.bathGoldIcon,
                iconColor: AppColors.black,
              ),
              IconWithTextWidget(
                text: !IsLanguage.isEnLanguage(context)
                    ? replaceToArabicNumber(unitDetail.price.toString())
                    : "${unitDetail.price}",
                icon: ImageAssets.priceIcon,
                iconColor: AppColors.black,
              ),
            ],
          ),
        )
      ],
    );
  }
}
