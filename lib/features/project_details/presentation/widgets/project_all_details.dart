import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';

class ProjectAllDetailsWidget extends StatelessWidget {
  const ProjectAllDetailsWidget({Key? key, required this.mainProjectItemModel})
      : super(key: key);
  final MainProjectItem mainProjectItemModel;

  @override
  Widget build(BuildContext context) {
    String type = '';
    String projectStatus = '';

    if (mainProjectItemModel.projectStatus == 'new') {
      projectStatus = translateText(AppStrings.newText, context);
    } else if (mainProjectItemModel.projectStatus == 'ongoing') {
      projectStatus = translateText(AppStrings.ongoingText, context);
    } else if (mainProjectItemModel.projectStatus == 'finished') {
      projectStatus = translateText(AppStrings.finishedText, context);
    } else {
      projectStatus = mainProjectItemModel.projectStatus!;
    }

    if (mainProjectItemModel.type == '1') {
      type = translateText(AppStrings.apartmentText, context);
    } else if (mainProjectItemModel.type == '2') {
      type = translateText(AppStrings.villaText, context);
    } else if (mainProjectItemModel.type == '3') {
      type = translateText(AppStrings.industrialLandText, context);
    } else if (mainProjectItemModel.type == '4') {
      type = translateText(AppStrings.commercialPlotText, context);
    } else if (mainProjectItemModel.type == '5') {
      type = translateText(AppStrings.shopText, context);
    } else if (mainProjectItemModel.type == '6') {
      type = translateText(AppStrings.officeText, context);
    } else {
      type = mainProjectItemModel.type!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(translateText(AppStrings.detailsText, context)),
          const SizedBox(height: 12),
          ListTileAllDetailsWidget(
            image: ImageAssets.dateIcon,
            text:
                "${AppLocalizations.of(context)!.translate(AppStrings.postedOnText)}"
                "  :  "
                "${IsLanguage.isEnLanguage(context) ? mainProjectItemModel.createdAt.toString().substring(0, 10) : replaceToArabicDate(mainProjectItemModel.createdAt.toString())}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.propertyIcon,
            text: "${translateText(AppStrings.propertyIdText, context)}"
                "  :  # "
                "${IsLanguage.isEnLanguage(context) ? mainProjectItemModel.id ?? "0" : replaceToArabicNumber(mainProjectItemModel.id.toString())}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.typeIcon,
            text: "${translateText(AppStrings.typeText, context)}"
                "  :  "
                "${type}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.purposeIcon,
            text: "${translateText(AppStrings.purposeText, context)}"
                "  :  "
                "${projectStatus}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.cardIcon,
            text: "${translateText(AppStrings.priceText, context)}"
                "  :  "
                '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.minPrice ?? "0" : replaceToArabicNumber(mainProjectItemModel.minPrice.toString())}'
                ' - '
                '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.maxPrice ?? "0" : replaceToArabicNumber(mainProjectItemModel.maxPrice.toString())}'
                " ${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.currency : mainProjectItemModel.currency == "USD" ? "دولار" : "دينار"}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.areaIcon,
            text: "${translateText(AppStrings.areaText, context)}"
                "  :  "
                '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.areaRange ?? 0 : replaceToArabicNumber(mainProjectItemModel.areaRange.toString())}   ${translateText(AppStrings.mText, context)}²',
          ),
        ],
      ),
    );
  }
}
