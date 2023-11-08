import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/widgets/three_icon_details.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';

class SimpleDetails extends StatelessWidget {
  const SimpleDetails({Key? key, this.mainItemModel}) : super(key: key);

  final MainItem? mainItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${AppLocalizations.of(context)!.isEnLocale ? mainItemModel!.price ?? "0" : replaceToArabicNumber(mainItemModel!.price.toString())}',
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                      TextSpan(
                        text:
                            "  ${AppLocalizations.of(context)!.isEnLocale ? mainItemModel!.currency! : "دولار"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                ThreeIconsDetailsWidget(
                  area: mainItemModel!.size.toString(),
                  bathrooms: mainItemModel!.bathRoom.toString(),
                  bedrooms: mainItemModel!.bedroom.toString(),
                ),
              ],
            ),
          ),
          Text(
            mainItemModel!.status == "null"
                ? "nooo"
                : mainItemModel!.status == "sale"
                    ? AppLocalizations.of(context)!
                        .translate(AppStrings.statusSaleText)!
                    : AppLocalizations.of(context)!
                        .translate(AppStrings.statusRentText)!,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
