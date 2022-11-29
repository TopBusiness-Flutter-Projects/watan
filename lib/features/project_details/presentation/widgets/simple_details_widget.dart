import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';

class ProjectSimpleDetailsWidget extends StatelessWidget {
  const ProjectSimpleDetailsWidget(
      {Key? key, required this.mainProjectItemModel})
      : super(key: key);
  final MainProjectItem mainProjectItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "${translateText(AppStrings.startingFromText, context)} : ",
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                      TextSpan(
                        text: IsLanguage.isEnLanguage(context)
                            ? mainProjectItemModel.createdAt
                                .toString()
                                .substring(0, 10)
                            : replaceToArabicDate(
                                mainProjectItemModel.createdAt.toString()),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.minPrice ?? "0" : replaceToArabicNumber(mainProjectItemModel.minPrice.toString())}'
                            ' - '
                            '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.maxPrice ?? "0" : replaceToArabicNumber(mainProjectItemModel.maxPrice.toString())}',
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                      TextSpan(
                        text:
                            " ${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.currency : mainProjectItemModel.currency == "USD" ? "دولار" : "دينار"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.minPriceOfMeter??0 : replaceToArabicNumber(mainProjectItemModel.minPriceOfMeter.toString())} ${translateText(AppStrings.mText, context)}²'
                            ' - '
                            '${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel.maxPriceOfMeter??0  : replaceToArabicNumber(mainProjectItemModel.maxPriceOfMeter.toString())} ${translateText(AppStrings.mText, context)}²',
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
