import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/views.dart';
import '../../../details/presentation/screens/details.dart';
import '../../domain/entities/main_item_domain_model.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({Key? key, required this.mainItem}) : super(key: key);
  final MainItem mainItem;

  @override
  Widget build(BuildContext context) {
    String type = '';
    if (mainItem.type == '1') {
      type = translateText(AppStrings.apartmentText, context);
    } else if (mainItem.type == '2') {
      type = translateText(AppStrings.villaText, context);
    } else if (mainItem.type == '3') {
      type = translateText(AppStrings.industrialLandText, context);
    } else if (mainItem.type == '4') {
      type = translateText(AppStrings.commercialPlotText, context);
    } else if (mainItem.type == '5') {
      type = translateText(AppStrings.shopText, context);
    } else if (mainItem.type == '6') {
      type = translateText(AppStrings.officeText, context);
    } else {
      type = mainItem.type!;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailsScreen(mainItemModel: mainItem);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: AppColors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  mainItem.images!.isNotEmpty
                      ? ManageNetworkImage(
                          imageUrl: mainItem.images!.first.attachment!,
                          width: double.infinity,
                        )
                      : Image.asset(ImageAssets.watanLogo),
                  Positioned(
                    top: 8,
                    right: 4,
                    child: Container(
                      width: 52,
                      height: 33,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(18))),
                      child: Center(
                        child: Text(
                          mainItem.status == "null"
                              ? "nooo"
                              : mainItem.status == "sale"
                                  ? AppLocalizations.of(context)!
                                      .translate(AppStrings.statusSaleText)!
                                  : AppLocalizations.of(context)!
                                      .translate(AppStrings.statusRentText)!,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.isEnLocale
                              ? mainItem.titleEn ?? "No Title"
                              : (AppLocalizations.of(context)!.isArLocale
                                  ? mainItem.titleAr ?? "لا عنوان"
                                  : mainItem.titleKu ?? "هیچ ناونیشانێک نییە"),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        //ToDo Categories Language
                        Text(
                          type,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(
                              IsLanguage.isEnLanguage(context)
                                  ? mainItem.locationNameEn!
                                  : (IsLanguage.isArLanguage(context)
                                      ? mainItem.locationNameAr!
                                      : mainItem.locationNameKu!),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.areaIcon),
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Text(
                                  AppLocalizations.of(context)!.isEnLocale
                                      ? mainItem.size ?? "0"
                                      : replaceToArabicNumber(
                                          mainItem.size.toString()),
                                  style: const TextStyle(fontSize: 12)),
                            ),
                            SvgPicture.asset(ImageAssets.roomsIcon),
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Text(
                                "${mainItem.bedroom == 0 ? translateText(AppStrings.studioText, context) : IsLanguage.isEnLanguage(context) ? mainItem.bedroom ?? "0" : replaceToArabicNumber(mainItem.bedroom.toString())}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            SvgPicture.asset(ImageAssets.bathIcon),
                            Text(
                              "  ${AppLocalizations.of(context)!.isEnLocale ? mainItem.bathRoom ?? "0" : replaceToArabicNumber(mainItem.bathRoom.toString())}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${AppLocalizations.of(context)!.isEnLocale ? mainItem.price ?? "0" : replaceToArabicNumber(
                                        mainItem.price.toString(),
                                      )}',
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.black),
                              ),
                              TextSpan(
                                  text:
                                      "  ${AppLocalizations.of(context)!.isEnLocale ? mainItem.currency! : "دولار"}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: AppColors.black)),
                            ],
                          ),
                        ),
                        ViewsWidget(views: mainItem.views.toString()),
                        //ToDo User Icon
                        mainItem.userModel!.image == null
                            ? CircleAvatar(
                                backgroundImage:
                                    AssetImage(ImageAssets.companyLogo),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(mainItem.userModel!.image!),
                              )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
