import 'package:elwatn/config/locale/app_localizations.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/features/details/presentation/widgets/list_tile_all_details.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';

class AllDetails extends StatelessWidget {
  const AllDetails({Key? key, this.mainItemModel}) : super(key: key);
  final MainItem? mainItemModel;

  @override
  Widget build(BuildContext context) {
    String type = '';
    if (mainItemModel!.type == '1') {
      type = translateText(AppStrings.apartmentText, context);
    } else if (mainItemModel!.type == '2') {
      type = translateText(AppStrings.villaText, context);
    } else if (mainItemModel!.type == '3') {
      type = translateText(AppStrings.industrialLandText, context);
    } else if (mainItemModel!.type == '4') {
      type = translateText(AppStrings.commercialPlotText, context);
    } else if (mainItemModel!.type == '5') {
      type = translateText(AppStrings.shopText, context);
    } else if (mainItemModel!.type == '6') {
      type = translateText(AppStrings.officeText, context);
    } else {
      type = mainItemModel!.type!;
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
                "${IsLanguage.isEnLanguage(context) ? mainItemModel!.createdAt.toString().substring(0,10) : replaceToArabicDate(mainItemModel!.createdAt.toString().substring(0,10))}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.propertyIcon,
            text: "${translateText(AppStrings.propertyIdText, context)}"
                "  :  # "
                "${IsLanguage.isEnLanguage(context) ? mainItemModel!.id ?? "0" : replaceToArabicNumber(mainItemModel!.id.toString())}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.typeIcon,
            text:
                "${translateText(AppStrings.typeText, context)}"
                        "  :  " +
                    type,
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.purposeIcon,
            text: "${translateText(AppStrings.purposeText, context)}"
                "  :  "
                "${mainItemModel!.status == "null" ? "nooo" : mainItemModel!.status == "sale" ? translateText(AppStrings.statusSaleText, context) : translateText(AppStrings.statusRentText, context)}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.cardIcon,
            text: "${translateText(AppStrings.priceText, context)}"
                "  :  "
                "${IsLanguage.isEnLanguage(context) ? mainItemModel!.price ?? "0" : replaceToArabicNumber(mainItemModel!.price.toString())}"
                " "
                "${IsLanguage.isEnLanguage(context) ? mainItemModel!.currency! : "دولار"}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.furnitureIcon,
            text: "${translateText(AppStrings.furnitureText, context)}"
                    "  :  " +
                '${mainItemModel!.furniture == '0' ? translateText(AppStrings.noDataMessage, context) : translateText(AppStrings.yesText, context)}',
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.areaIcon,
            text: "${translateText(AppStrings.areaText, context)}"
                "  :  "
                "${IsLanguage.isEnLanguage(context) ? mainItemModel!.size ?? "0" : replaceToArabicNumber(mainItemModel!.size.toString())}"
                "${IsLanguage.isEnLanguage(context) ? " M" : " م"}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.roomsIcon,
            text: "${translateText(AppStrings.bedroomText, context)}"
                "  :  "
                "${mainItemModel!.bedroom == 0 ? translateText(AppStrings.studioText, context) : IsLanguage.isEnLanguage(context) ? mainItemModel!.bedroom ?? "0" : replaceToArabicNumber(mainItemModel!.bedroom.toString())}",
          ),
          ListTileAllDetailsWidget(
            image: ImageAssets.bathIcon,
            text: "${translateText(AppStrings.bathroomText, context)}"
                "  :  "
                "${IsLanguage.isEnLanguage(context) ? mainItemModel!.bathRoom ?? "0" : replaceToArabicNumber(mainItemModel!.bathRoom.toString())}",
          ),
        ],
      ),
    );
  }
}
