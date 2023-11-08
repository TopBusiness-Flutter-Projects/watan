import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/widgets/three_icon_details.dart';
import 'package:elwatn/core/widgets/views.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:elwatn/features/home_page/domain/entities/main_item_domain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/utils/app_colors.dart';
import '../../config/locale/app_localizations.dart';
import '../../features/add/presentation/screens/add_screen.dart';
import '../../features/details/presentation/screens/details.dart';
import '../../features/favorite/presentation/cubit/favourites_cubit.dart';
import '../../features/language/presentation/cubit/locale_cubit.dart';
import '../../features/login/presentation/screens/login.dart';
import '../../features/my_ads/presentation/cubit/my_ads_cubit.dart';
import '../utils/app_strings.dart';
import '../utils/convert_numbers_method.dart';
import '../utils/is_language_methods.dart';
import '../utils/toast_message_method.dart';
import '../utils/translate_text_method.dart';
import 'network_image.dart';

class SecondMainItemWidget extends StatefulWidget {
  SecondMainItemWidget({
    Key? key,
    this.mainItemModel,
    this.isMyAdds = false,
  }) : super(key: key);

  final bool isMyAdds;
  final MainItem? mainItemModel;

  @override
  State<SecondMainItemWidget> createState() => _SecondMainItemWidgetState();
}

class _SecondMainItemWidgetState extends State<SecondMainItemWidget> {
  bool isFavourite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.mainItemModel!.isFavourite!;
  }

  @override
  Widget build(BuildContext context) {
    String type = '';
    if (widget.mainItemModel!.type == '1') {
      type = translateText(AppStrings.apartmentText, context);
    } else if (widget.mainItemModel!.type == '2') {
      type = translateText(AppStrings.villaText, context);
    } else if (widget.mainItemModel!.type == '3') {
      type = translateText(AppStrings.industrialLandText, context);
    } else if (widget.mainItemModel!.type == '4') {
      type = translateText(AppStrings.commercialPlotText, context);
    } else if (widget.mainItemModel!.type == '5') {
      type = translateText(AppStrings.shopText, context);
    } else if (widget.mainItemModel!.type == '6') {
      type = translateText(AppStrings.officeText, context);
    } else {
      type = widget.mainItemModel!.type!;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(mainItemModel: widget.mainItemModel);
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
                      child: widget.mainItemModel!.images!.isNotEmpty
                          ? ManageNetworkImage(
                              imageUrl: widget
                                  .mainItemModel!.images!.first.attachment!,
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
                            widget.mainItemModel!.status == "null"
                                ? "nooo"
                                : widget.mainItemModel!.status == "sale"
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
                                    ? widget.mainItemModel!.titleEn ??
                                        "No Title"
                                    : (AppLocalizations.of(context)!.isArLocale
                                        ? widget.mainItemModel!.titleAr ??
                                            "لا عنوان"
                                        : widget.mainItemModel!.titleKu ??
                                            "هیچ ناونیشانێک نییە"),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            widget.isMyAdds
                                ? InkWell(
                                    onTap: () {
                                      context
                                          .read<MyAdsCubit>()
                                          .deleteMyProfileAds(
                                            widget.mainItemModel!.id.toString(),
                                            'myAds',
                                            '1',
                                          );
                                    },
                                    child: SvgPicture.asset(
                                      ImageAssets.deleteAccountIcon,
                                    ),
                                  )
                                : isLoading
                                    ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          color: AppColors.primary,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (context
                                                  .read<LocaleCubit>()
                                                  .loginDataModel ==
                                              null) {
                                            Alert(
                                              context: context,
                                              type: AlertType.warning,
                                              title:
                                                  "\n ${translateText(AppStrings.shouldLoginText, context)} ",
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  color: AppColors
                                                      .buttonBackground,
                                                  child: Text(
                                                    translateText(
                                                        AppStrings.cancelBtn,
                                                        context),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                DialogButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return const LoginScreen();
                                                      },
                                                    ),
                                                  ),
                                                  color: AppColors.error,
                                                  child: Text(
                                                    translateText(
                                                      AppStrings.loginText,
                                                      context,
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                )
                                              ],
                                            ).show();
                                          } else {
                                            context
                                                .read<FavouritesCubit>()
                                                .cubitKind = 'null';
                                            context
                                                .read<FavouritesCubit>()
                                                .getFavourite = 'change';
                                            setState(() {
                                              isLoading = true;
                                            });
                                            context
                                                .read<FavouritesCubit>()
                                                .changeFavouritesStatus(
                                                  widget.mainItemModel!.id
                                                      .toString(),
                                                  'ads',
                                                )
                                                .whenComplete(
                                                  () => Future.delayed(
                                                    Duration(
                                                      milliseconds: 500,
                                                    ),
                                                    () {
                                                      setState(() {
                                                        isLoading = false;
                                                        if (context
                                                                .read<
                                                                    FavouritesCubit>()
                                                                .message !=
                                                            'There are some Errors') {
                                                          isFavourite = context
                                                              .read<
                                                                  FavouritesCubit>()
                                                              .favourite;
                                                        }
                                                      });
                                                      toastMessage(
                                                        context
                                                            .read<
                                                                FavouritesCubit>()
                                                            .message,
                                                        context,
                                                        color:
                                                            AppColors.primary,
                                                      );
                                                    },
                                                  ),
                                                );
                                          }
                                        },
                                        child: Icon(
                                          isFavourite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavourite
                                              ? AppColors.primary
                                              : AppColors.black,
                                        ),
                                      ),
                          ],
                        ),
                        Text(
                          type,
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
                                  ? widget.mainItemModel!.locationNameEn!
                                  : (IsLanguage.isArLanguage(context)
                                      ? widget.mainItemModel!.locationNameAr!
                                      : widget.mainItemModel!.locationNameKu!),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        ThreeIconsDetailsWidget(
                          area: widget.mainItemModel!.size.toString(),
                          bathrooms: widget.mainItemModel!.bathRoom.toString(),
                          bedrooms: widget.mainItemModel!.bedroom.toString(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${AppLocalizations.of(context)!.isEnLocale ? widget.mainItemModel!.price ?? "0" : replaceToArabicNumber(widget.mainItemModel!.price.toString())}',
                                    style: TextStyle(
                                        fontSize: 16, color: AppColors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        "  ${AppLocalizations.of(context)!.isEnLocale ? widget.mainItemModel!.currency! : "دولار"}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                            ViewsWidget(
                                views: widget.mainItemModel!.views.toString()),
                            ManageNetworkImage(
                              imageUrl: widget
                                      .mainItemModel!.userModel!.image ??
                                  'http://clipart-library.com/images/pT5ra4Xgc.jpg',
                              width: 28,
                              height: 28,
                              borderRadius: 36,
                            ),
                          ],
                        ),
                        widget.isMyAdds == true
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<MyAdsCubit>()
                                          .changeStatusMyProfileAds(
                                            widget.mainItemModel!.id.toString(),
                                            'myAds',
                                            '1',
                                          );
                                    },
                                    child: Text(
                                      translateText(
                                          AppStrings.AddToMySolidBtn, context),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<AddAdsCubit>()
                                          .putDataToUpdate(
                                              widget.mainItemModel!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                            body: SafeArea(
                                              child: AddScreen(
                                                isUpdate: true,
                                                mainItemModel:
                                                    widget.mainItemModel,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      translateText(
                                          AppStrings.editBtn, context),
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
