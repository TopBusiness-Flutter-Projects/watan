import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/widgets/three_icon_details.dart';
import 'package:elwatn/core/widgets/views.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:elwatn/features/home_page/domain/entities/main_item_domain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../config/locale/app_localizations.dart';
import '../../features/add/presentation/screens/add_screen.dart';
import '../../features/details/presentation/screens/details.dart';
import '../../features/login/data/models/login_data_model.dart';
import '../../features/login/domain/entities/login_domain_model.dart';
import '../../features/my_ads/presentation/cubit/my_ads_cubit.dart';
import '../utils/app_strings.dart';
import '../utils/convert_numbers_method.dart';
import '../utils/is_language_methods.dart';
import 'network_image.dart';

class SecondMainItemWidget extends StatelessWidget {
  const SecondMainItemWidget(
      {Key? key,
      this.isFavorite = false,
      this.mainItemModel,
      this.isMyAdds = false})
      : super(key: key);

  final bool isFavorite;
  final bool isMyAdds;
  final MainItem? mainItemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(mainItemModel: mainItemModel);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: mainItemModel!.images!.isNotEmpty
                          ? ManageNetworkImage(
                              imageUrl:
                                  mainItemModel!.images!.first.attachment!,
                              width: 120,
                              height: 120,
                              borderRadius: 12,
                            )
                          : Image.asset(
                              ImageAssets.watanLogo,
                              width: 120,
                              height: 120,
                            ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 40,
                        height: 19,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            mainItemModel!.status == "null"
                                ? "nooo"
                                : mainItemModel!.status == "sale"
                                    ? AppLocalizations.of(context)!
                                        .translate(AppStrings.statusSaleText)!
                                    : AppLocalizations.of(context)!
                                        .translate(AppStrings.statusRentText)!,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.isEnLocale
                                    ? mainItemModel!.titleEn ?? "No Title"
                                    : (AppLocalizations.of(context)!.isArLocale
                                        ? mainItemModel!.titleAr ?? "لا عنوان"
                                        : mainItemModel!.titleKu ??
                                            "هیچ ناونیشانێک نییە"),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            //ToDo Favourite
                            isMyAdds
                                ? InkWell(
                                    onTap: () {
                                      context
                                          .read<MyAdsCubit>()
                                          .deleteMyProfileAds(
                                            mainItemModel!.id.toString(),
                                            'myAds',
                                          );
                                    },
                                    child: SvgPicture.asset(
                                      ImageAssets.deleteAccountIcon,
                                    ),
                                  )
                                : Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? AppColors.primary
                                        : AppColors.black,
                                  ),
                          ],
                        ),
                        //ToDo Categories Languages
                        Text(
                          mainItemModel!.type ?? "no title",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Text(
                              IsLanguage.isEnLanguage(context)
                                  ? mainItemModel!.locationNameEn!
                                  : (IsLanguage.isArLanguage(context)
                                      ? mainItemModel!.locationNameAr!
                                      : mainItemModel!.locationNameKu!),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        ThreeIconsDetailsWidget(
                          area: mainItemModel!.size.toString(),
                          bathrooms: mainItemModel!.bathRoom.toString(),
                          bedrooms: mainItemModel!.bedroom.toString(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${AppLocalizations.of(context)!.isEnLocale ? mainItemModel!.price ?? "0" : replaceToArabicNumber(mainItemModel!.price.toString())}',
                                    style: TextStyle(
                                        fontSize: 16, color: AppColors.black),
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
                            ViewsWidget(views: mainItemModel!.views.toString()),
                            //ToDo Company Icon
                            Image.asset(
                              ImageAssets.companyLogo,
                              width: 36,
                              height: 28,
                            ),
                          ],
                        ),
                        isMyAdds == true
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<MyAdsCubit>()
                                          .changeStatusMyProfileAds(
                                            mainItemModel!.id.toString(),
                                            'myAds',
                                          );
                                    },
                                    child: Text(
                                      "Add To My Solid",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<AddAdsCubit>()
                                          .putDataToUpdate(mainItemModel!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                            body: SafeArea(
                                              child: AddScreen(
                                                isUpdate: true,
                                                mainItemModel: mainItemModel,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}