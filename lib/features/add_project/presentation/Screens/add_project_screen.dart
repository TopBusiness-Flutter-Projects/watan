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
import '../../../add/presentation/widgets/amenities_widget.dart';
import '../../../add/presentation/widgets/connection_widget.dart';
import '../../../add/presentation/widgets/container_dots_pick_images.dart';
import '../../../add/presentation/widgets/container_dots_pick_videos.dart';
import '../../../add/presentation/widgets/property_details_widget.dart';
import '../../../add/presentation/widgets/select_your_location.dart';
import '../../../filter/presentation/widgets/property_type.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';
import '../../../my_ads/presentation/cubit/my_ads_cubit.dart';
import '../cubit/add_project_cubit.dart';
import '../widgets/payment_planes_widget.dart';
import '../widgets/unit_detales_floor_planes_widget.dart';

class AddProjectScreen extends StatefulWidget {
  AddProjectScreen({
    Key? key,
    this.isUpdate = false,
    this.mainProjectItem,
  }) : super(key: key);

  final bool isUpdate;
  final MainProjectItem? mainProjectItem;

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (!widget.isUpdate) {
      context.read<AddProjectCubit>().btnText = '';
    }
    if (context.read<AddProjectCubit>().btnText != 'update') {
      context.read<AddProjectCubit>().clearData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProjectCubit, AddProjectState>(
      builder: (context, state) {
        AddProjectCubit addProjectCubit = context.read<AddProjectCubit>();
        if (state is UpdateAdsPostLoaded) {
          Future.delayed(const Duration(milliseconds: 500), () {
            snackBar("SuccessFully Updated", context, color: AppColors.success);
            context.read<MyAdsCubit>().getMyProfileAds(
                  context
                      .read<AddProjectCubit>()
                      .loginDataModel!
                      .data!
                      .accessToken!,
                  'myAds',
                  '3',
                );
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          });
          return const ShowLoadingIndicator();
        }
        if (state is AddProjectPostLoaded) {
          Future.delayed(const Duration(milliseconds: 500), () {
            snackBar("SuccessFully", context, color: AppColors.success);
          });
        }
        if (state is AddProjectPostError ||
            state is AddProjectPostErrorResponse ||
            state is UpdateAdsPostErrorResponse ||
            state is UpdateAdsPostError) {
          Future.delayed(const Duration(milliseconds: 500), () {
            snackBar("Error", context, color: AppColors.error);
          });
        }
        if (state is AddProjectPostLoading || state is UpdateAdsPostLoading) {
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
                      length: 3,
                      initialIndex: widget.isUpdate
                          ? widget.mainProjectItem!.projectStatus == 'new'
                              ? 0
                              : widget.mainProjectItem!.projectStatus ==
                                      'ongoing'
                                  ? 1
                                  : 2
                          : 0,
                      child: Material(
                        color: AppColors.white,
                        child: TabBar(
                          indicatorColor: AppColors.primary,
                          tabs:  [
                            Tab(
                              text: translateText(AppStrings.newText, context),
                            ),
                            Tab(
                              text: translateText(AppStrings.ongoingText, context),
                            ),
                            Tab(
                              text: translateText(AppStrings.finishedText, context),
                            ),
                          ],
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.black,
                          onTap: (index) {
                            if (index == 0) {
                              context.read<AddProjectCubit>().statusProject =
                                  'new';
                            } else if (index == 1) {
                              context.read<AddProjectCubit>().statusProject =
                                  'ongoing';
                            } else {
                              context.read<AddProjectCubit>().statusProject =
                                  'finished';
                            }
                          },
                          indicator: RectangularIndicator(
                            color: AppColors.primary,
                            bottomLeftRadius: 10,
                            bottomRightRadius: 10,
                            topLeftRadius: 10,
                            topRightRadius: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SelectCityWidget(kind: "addProject"),
                  const SizedBox(height: 12),
                  const SelectCityLocation(kind: 'addProject'),
                  const GrayLine(),
                  const PropertyTypeWidget(kind: "addProject"),
                  const GrayLine(),
                  const PropertyDetailsWidget(kind: "addProject"),
                  const GrayLine(),
                  const PaymentPlanesWidget(),
                  const GrayLine(),
                  const UnitDetailsFloorPlanesWidget(),
                  const GrayLine(),
                  const AmenitiesAddWidget(
                      isSelected: true, kind: 'addProject'),
                  const GrayLine(),
                  const SelectYourLocation(kindOfSelected: 'addProject'),
                  const GrayLine(),
                  PickImagesContainerWidget(
                    title: 'imageProject',
                    kind: 'addProject',
                    isUpdate: widget.isUpdate,
                  ),
                  const GrayLine(),
                  PickImagesContainerWidget(
                    title: translateText(AppStrings.schemaText, context),
                    kind: 'addProject',
                    isUpdate: widget.isUpdate,
                  ),
                  const GrayLine(),
                  PickVideosContainerWidget(
                    title: translateText(AppStrings.videoText, context),
                    kind: 'addProject',
                  ),
                  const GrayLine(),
                  const ContactWidget(kind: 'addProject'),
                  CustomButton(
                    text: widget.isUpdate ? translateText(AppStrings.updateBtnText, context) : translateText(AppStrings.addBtn, context),
                    color: AppColors.primary,
                    paddingHorizontal: 60,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        if (addProjectCubit.cityId == 0) {
                          snackBar("Please Select Your City", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.locationId == 0) {
                          snackBar("Please Select Your Location", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.type == -1) {
                          snackBar("Please Select Your Property Type", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.image.isEmpty) {
                          snackBar("Please Select Your Image ", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.floorPlan.isEmpty) {
                          snackBar("Please Select Your Floor Plans ", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.unitPlanArea.isEmpty) {
                          snackBar("Please inter Some Units ", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.unitPlanArea.length < 2) {
                          snackBar("Your Should Insert more units ", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.paymentPlanPresent.isEmpty) {
                          snackBar("Please inter Some Payment Plans ", context,
                              color: AppColors.primary);
                        } else if (addProjectCubit.paymentPlanPresent.length <
                            2) {
                          snackBar(
                              "Your Should Insert more Payment Plans ", context,
                              color: AppColors.primary);
                        } else {
                          widget.isUpdate
                              ? context.read<AddProjectCubit>().updateAdsPost()
                              : context
                                  .read<AddProjectCubit>()
                                  .addProjectPost();
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
