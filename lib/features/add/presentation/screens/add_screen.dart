import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:elwatn/core/widgets/custom_button.dart';
import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/gray_line.dart';
import '../../../../core/widgets/select_city_location_widget.dart';
import '../../../../core/widgets/select_city_widget.dart';
import '../../../filter/presentation/widgets/bathroom.dart';
import '../../../filter/presentation/widgets/bedrooms.dart';
import '../../../filter/presentation/widgets/property_type.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';
import '../../../my_ads/presentation/cubit/my_ads_cubit.dart';
import '../cubit/add_ads_cubit.dart';
import '../widgets/amenities_widget.dart';
import '../widgets/connection_widget.dart';
import '../widgets/container_dots_pick_images.dart';
import '../widgets/container_dots_pick_videos.dart';
import '../widgets/furnished_widget.dart';
import '../widgets/price_widget.dart';
import '../widgets/property_details_widget.dart';
import '../widgets/select_your_location.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({
    Key? key,
    this.isUpdate = false,
    this.mainItemModel,
  }) : super(key: key);

  final bool isUpdate;
  final MainItem? mainItemModel;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (!widget.isUpdate) {
      context.read<AddAdsCubit>().btnText = '';
    }
    if (context.read<AddAdsCubit>().btnText != 'update') {
      context.read<AddAdsCubit>().clearData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAdsCubit, AddAdsState>(
      builder: (context, state) {
        AddAdsCubit addAdsCubit = context.read<AddAdsCubit>();
        if (state is AddAdsPostLoaded) {
          Future.delayed(const Duration(milliseconds: 500), () {
            snackBar(
                translateText(AppStrings.successFullyAddedMessage, context),
                context,
                color: AppColors.success);
          });
        }
        if (state is AddAdsPostError ||
            state is AddAdsPostErrorResponse ||
            state is AddAdsPostError) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              snackBar(
                  translateText(AppStrings.someErrorMessage, context), context,
                  color: AppColors.error);
            },
          );
        }
        if (state is AddAdsPostLoading || state is UpdateAdsPostLoading) {
          return const ShowLoadingIndicator();
        }
        if (state is UpdateAdsPostLoaded) {
          Future.delayed(Duration(milliseconds: 400), () {
            context.read<MyAdsCubit>().setStateWidgets();
            Navigator.pop(context);
          });
          return const ShowLoadingIndicator();
        }
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: widget.isUpdate
                          ? widget.mainItemModel!.status != 'rent'
                              ? 0
                              : 1
                          : 0,
                      child: Material(
                        color: AppColors.white,
                        child: TabBar(
                          indicatorColor: AppColors.primary,
                          tabs: [
                            Tab(
                              text: translateText(
                                  AppStrings.statusSaleText, context),
                            ),
                            Tab(
                              text: translateText(
                                  AppStrings.statusRentText, context),
                            ),
                          ],
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.black,
                          onTap: (index) {
                            if (index == 0) {
                              context.read<AddAdsCubit>().status = 'sale';
                            } else {
                              context.read<AddAdsCubit>().status = 'rent';
                            }
                          },
                          indicator: RectangularIndicator(
                            color: AppColors.primary,
                            bottomLeftRadius: 100,
                            bottomRightRadius: 100,
                            topLeftRadius: 100,
                            topRightRadius: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const SelectCityWidget(kind: "addAds"),
                  const SizedBox(height: 12),
                  const SelectCityLocation(kind: 'addAds'),
                  const GrayLine(),
                  const PropertyTypeWidget(kind: "addAds"),
                  const GrayLine(),
                  const PropertyDetailsWidget(),
                  const GrayLine(),
                  const FurnishedWidget(),
                  const GrayLine(),
                  PriceAddWidget(
                      title: translateText(AppStrings.priceText, context)),
                  const GrayLine(),
                  PriceAddWidget(
                      title: translateText(AppStrings.areaText, context)),
                  const GrayLine(),
                  const AmenitiesAddWidget(isSelected: true, kind: 'addAds'),
                  const GrayLine(),
                  const BedRoomsWidget(typeClass: 'add'),
                  const GrayLine(),
                  ListNumbersWidget(
                    image: ImageAssets.bathGoldIcon,
                    title: translateText(AppStrings.bathroomText, context),
                    kind: 'bathroom',
                  ),
                  const GrayLine(),
                  ListNumbersWidget(
                    image: ImageAssets.kitchenIcon,
                    title: translateText(AppStrings.kitchenText, context),
                    kind: 'kitchen',
                  ),
                  const GrayLine(),
                  ListNumbersWidget(
                    image: ImageAssets.livingRoomIcon,
                    title: translateText(AppStrings.livingText, context),
                    kind: 'living',
                  ),
                  const GrayLine(),
                  ListNumbersWidget(
                    image: ImageAssets.livingRoomIcon,
                    title: translateText(AppStrings.diningText, context),
                    kind: 'dining',
                  ),
                  const GrayLine(),
                  const SelectYourLocation(kindOfSelected: 'addAds'),
                  const GrayLine(),
                  PickImagesContainerWidget(
                      title: translateText(AppStrings.imagesText, context),
                      isUpdate: widget.isUpdate),
                  const GrayLine(),
                  PickVideosContainerWidget(
                    title: translateText(AppStrings.videoText, context),
                    kind: 'addAds',
                  ),
                  const GrayLine(),
                  const ContactWidget(),
                  CustomButton(
                    text: context.read<AddAdsCubit>().btnText == 'update'
                        ? translateText(AppStrings.updateBtnText, context)
                        : translateText(AppStrings.publishBtn, context),
                    color: AppColors.primary,
                    paddingHorizontal: 60,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        if (addAdsCubit.cityId == 0) {
                          snackBar(
                              translateText(AppStrings.selectCityText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.locationId == 0) {
                          snackBar(
                              translateText(
                                  AppStrings.selectLocationText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.type == -1) {
                          snackBar(
                              translateText(
                                  AppStrings.selectPropertyTypeText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.currency == '') {
                          snackBar(
                              translateText(
                                  AppStrings.selectCurrencyText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.bedroom == -1) {
                          snackBar(
                              translateText(
                                  AppStrings.selectBedRoomText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.kitchen == 0) {
                          snackBar(
                              translateText(
                                  AppStrings.selectKitchenText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.bathroom == 0) {
                          snackBar(
                              translateText(
                                  AppStrings.selectBathRoomText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.livingRoom == 0) {
                          snackBar(
                              translateText(
                                  AppStrings.selectLivingRoomText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.diningRoom == 0) {
                          snackBar(
                              translateText(
                                  AppStrings.selectDiningRoomText, context),
                              context,
                              color: AppColors.primary);
                        } else if (addAdsCubit.image.isEmpty) {
                          snackBar(
                            translateText(
                                AppStrings.selectImageValidator, context),
                            context,
                            color: AppColors.primary,
                          );
                        } else if (addAdsCubit.phoneController.text.length <
                                10 ||
                            addAdsCubit.phoneController.text.length > 11) {
                          snackBar(
                            translateText(AppStrings.correctPhoneText, context),
                            context,
                            color: AppColors.error,
                          );
                        } else if (addAdsCubit.whatsappController.text.length <
                                10 ||
                            addAdsCubit.whatsappController.text.length > 11) {
                          snackBar(
                            translateText(
                                AppStrings.correctWhatsappText, context),
                            context,
                            color: AppColors.error,
                          );
                        } else {
                          // if (!widget.isUpdate) {
                            if (addAdsCubit.longitude == 0.0 ||
                                addAdsCubit.latitude == 0.0) {
                              snackBar(
                                translateText(
                                    AppStrings.selectLocationText, context),
                                context,
                                color: AppColors.primary,
                              );
                            } else {
                              context.read<AddAdsCubit>().btnText == 'update'
                                  ? context.read<AddAdsCubit>().updateAdsPost()
                                  : context.read<AddAdsCubit>().addAdsPost();
                            }
                          // }
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
