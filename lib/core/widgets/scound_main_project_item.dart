import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/widgets/views.dart';
import 'package:elwatn/features/add_project/presentation/Screens/add_project_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/utils/app_colors.dart';
import '../../config/locale/app_localizations.dart';
import '../../features/add_project/presentation/cubit/add_project_cubit.dart';
import '../../features/favorite/presentation/cubit/favourites_cubit.dart';
import '../../features/home_page/domain/entities/main_project_item_domain_model.dart';
import '../../features/language/presentation/cubit/locale_cubit.dart';
import '../../features/login/presentation/screens/login.dart';
import '../../features/my_ads/presentation/cubit/my_ads_cubit.dart';
import '../../features/project_details/presentation/screens/project_details.dart';
import '../utils/app_strings.dart';
import '../utils/convert_numbers_method.dart';
import '../utils/is_language_methods.dart';
import '../utils/toast_message_method.dart';
import '../utils/translate_text_method.dart';
import 'network_image.dart';

class SecondMainProjectItemWidget extends StatefulWidget {
  const SecondMainProjectItemWidget({
    Key? key,
    this.mainProjectItemModel,
    this.isMyAdds = false,
  }) : super(key: key);

  final MainProjectItem? mainProjectItemModel;
  final bool isMyAdds;

  @override
  State<SecondMainProjectItemWidget> createState() =>
      _SecondMainProjectItemWidgetState();
}

class _SecondMainProjectItemWidgetState
    extends State<SecondMainProjectItemWidget> {
  bool isFavourite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.mainProjectItemModel!.isFavourite!;
  }

  @override
  Widget build(BuildContext context) {
    String type = '';
    String projectStatus = '';

    if (widget.mainProjectItemModel!.projectStatus == 'new') {
      projectStatus = translateText(AppStrings.newText, context);
    } else if (widget.mainProjectItemModel!.projectStatus == 'ongoing') {
      projectStatus = translateText(AppStrings.ongoingText, context);
    } else if (widget.mainProjectItemModel!.projectStatus == 'finished') {
      projectStatus = translateText(AppStrings.finishedText, context);
    } else {
      projectStatus = widget.mainProjectItemModel!.projectStatus!;
    }

    if (widget.mainProjectItemModel!.type == '1') {
      type = translateText(AppStrings.apartmentText, context);
    } else if (widget.mainProjectItemModel!.type == '2') {
      type = translateText(AppStrings.villaText, context);
    } else if (widget.mainProjectItemModel!.type == '3') {
      type = translateText(AppStrings.industrialLandText, context);
    } else if (widget.mainProjectItemModel!.type == '4') {
      type = translateText(AppStrings.commercialPlotText, context);
    } else if (widget.mainProjectItemModel!.type == '5') {
      type = translateText(AppStrings.shopText, context);
    } else if (widget.mainProjectItemModel!.type == '6') {
      type = translateText(AppStrings.officeText, context);
    } else {
      type = widget.mainProjectItemModel!.type??"";
    }


    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProjectDetails(
                  mainProjectItemModel: widget.mainProjectItemModel!);
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
                      child: widget.mainProjectItemModel!.images!.isNotEmpty
                          ? ManageNetworkImage(
                              imageUrl: widget.mainProjectItemModel!.images!
                                  .first.attachment!,
                              width: 120,
                              height: 160,
                              borderRadius: 12,
                            )
                          : Image.asset(
                              ImageAssets.watanLogo,
                              width: 120,
                              height: 120,
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
                            Text(
                              AppLocalizations.of(context)!.isEnLocale
                                  ? widget.mainProjectItemModel!.titleEn ??
                                      "No Title"
                                  : (AppLocalizations.of(context)!.isArLocale
                                      ? widget.mainProjectItemModel!.titleAr ??
                                          "لا عنوان"
                                      : widget.mainProjectItemModel!.titleKu ??
                                          "هیچ ناونیشانێک نییە"),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            widget.isMyAdds
                                ? InkWell(
                                    onTap: () {
                                      context
                                          .read<MyAdsCubit>()
                                          .deleteMyProfileAds(
                                            widget.mainProjectItemModel!.id
                                                .toString(),
                                            'myAds',
                                            '3',
                                          );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SvgPicture.asset(
                                        ImageAssets.deleteAccountIcon,
                                      ),
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
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                DialogButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .push(
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
                                                        context),
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
                                                  widget
                                                      .mainProjectItemModel!.id
                                                      .toString(),
                                                  'project',
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
                            const Icon(
                              Icons.location_on,
                              size: 20,
                            ),
                            Text(
                              IsLanguage.isEnLanguage(context)
                                  ? widget.mainProjectItemModel!
                                          .locationNameEn ??
                                      "NO Location"
                                  : (IsLanguage.isArLanguage(context)
                                      ? widget.mainProjectItemModel!
                                              .locationNameAr ??
                                          "NO Location"
                                      : widget.mainProjectItemModel!
                                              .locationNameKu ??
                                          "NO Location"),
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SvgPicture.asset(
                                ImageAssets.clockIcon,
                                width: 14,
                                height: 14,
                                color: Colors.black,
                              )),
                              Expanded(
                                  flex: 8,
                                  child: Text(
                                    "${translateText(AppStrings.purposeText, context)}"
                                    "  :  "
                                    "${projectStatus}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SvgPicture.asset(
                                ImageAssets.dateIcon,
                                width: 14,
                                height: 14,
                                color: Colors.black,
                              )),
                              Expanded(
                                  flex: 8,
                                  child: Text(
                                    "${AppLocalizations.of(context)!.translate(AppStrings.postedOnText)}"
                                    "  :  "
                                    "${IsLanguage.isEnLanguage(context) ? widget.mainProjectItemModel!.createdAt.toString().substring(0, 10) : replaceToArabicDate(widget.mainProjectItemModel!.createdAt.toString())}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 14),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                              .isEnLocale
                                          ? "${widget.mainProjectItemModel!.minPrice} - ${widget.mainProjectItemModel!.maxPrice}"
                                          : "${replaceToArabicNumber(widget.mainProjectItemModel!.minPrice.toString())}"
                                              " - "
                                              "${replaceToArabicNumber(widget.mainProjectItemModel!.maxPrice.toString())}",
                                      style: TextStyle(
                                          fontSize: 16, color: AppColors.black),
                                    ),
                                    TextSpan(
                                      text: " ${AppLocalizations.of(context)!.isEnLocale ? widget.mainProjectItemModel!.currency : widget.mainProjectItemModel!.currency == "USD" ? "دولار" : "دينار"}",
                                      // "  ${AppLocalizations.of(context)!.isEnLocale ? mainProjectItemModel!.id! : "دولار"}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                              ViewsWidget(
                                  views: widget.mainProjectItemModel!.views
                                      .toString()),
                              widget.isMyAdds == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<AddProjectCubit>()
                                                .putDataToUpdate(widget
                                                    .mainProjectItemModel!);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  body: SafeArea(
                                                    child: AddProjectScreen(
                                                      isUpdate: true,
                                                      mainProjectItem: widget
                                                          .mainProjectItemModel,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            translateText(AppStrings.editBtn, context),
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
                        )
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
