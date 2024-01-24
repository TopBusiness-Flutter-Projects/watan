import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({Key? key, this.mainItemModel}) : super(key: key);
  final MainItem? mainItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translateText(AppStrings.amenitiesText, context),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  ...List.generate(
                    mainItemModel!.services!.length,
                    (index) => mainItemModel!.services![index].service!.id !=
                            null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 106,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppColors.gray)),
                                  child: Center(
                                    child: ManageNetworkImage(
                                      imageUrl: mainItemModel!.services![index]
                                                  .service!.icon ==
                                              null
                                          ? "https://cdn-icons-png.flaticon.com/512/8546/8546452.png"
                                          : mainItemModel!
                                              .services![index].service!.icon!,
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  IsLanguage.isEnLanguage(context)
                                      ? mainItemModel!
                                          .services![index].service!.nameEn!
                                      : (IsLanguage.isArLanguage(context)
                                          ? mainItemModel!
                                              .services![index].service!.nameAr!
                                          : mainItemModel!.services![index]
                                              .service!.nameKo!),
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          )
                        : const SizedBox(width: 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
