import 'package:elwatn/core/helper/location_helper.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/toast_message_method.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/core/widgets/custom_button.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:elwatn/features/add_project/presentation/cubit/add_project_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../register/presentation/cubit/register_cubit.dart';

class SelectMapLocationScreen extends StatefulWidget {
  const SelectMapLocationScreen({Key? key, required this.kindOfSelected})
      : super(key: key);

  final String kindOfSelected;

  @override
  State<SelectMapLocationScreen> createState() =>
      _SelectMapLocationScreenState();
}

class _SelectMapLocationScreenState extends State<SelectMapLocationScreen> {
  MapController? controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  ValueNotifier<bool> showFab = ValueNotifier(true);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    LocationHelper.getCurrantLocation().then((value) {
      setState(() {
        controller = MapController(
          initMapWithUserPosition: false,
          initPosition: GeoPoint(
            latitude: value.latitude,
            longitude: value.longitude,
          ),
        );
        scaffoldKey = GlobalKey<ScaffoldState>();
        controller!.listenerMapSingleTapping.addListener(() async {
          if (controller!.listenerMapSingleTapping.value != null) {
            if (lastGeoPoint.value != null) {
              controller!.changeLocationMarker(
                oldLocation: lastGeoPoint.value!,
                newLocation: controller!.listenerMapSingleTapping.value!,
              );
            } else {
              await controller!.addMarker(
                controller!.listenerMapSingleTapping.value!,
                markerIcon: MarkerIcon(
                  assetMarker: AssetMarker(
                      image: AssetImage(
                        ImageAssets.markerImage,
                      ),
                      scaleAssetImage: 2),
                ),
              );
            }
            lastGeoPoint.value = controller!.listenerMapSingleTapping.value;
          }
        });
      });
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Stack(
                children: [
                  OSMFlutter(
                    controller: controller!,
                    trackMyPosition: false,
                    androidHotReloadSupport: true,
                    mapIsLoading: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    initZoom: 12,
                    minZoomLevel: 3,
                    maxZoomLevel: 18,
                    stepZoom: 1.0,
                    showContributorBadgeForOSM: false,
                    showDefaultInfoWindow: false,
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 - 32,
                    left: MediaQuery.of(context).size.width / 2 - 32,
                    top: 8,
                    child: InkWell(
                      onTap: () async => await controller!.currentLocation(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(25)),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 35,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller!.listenerMapSingleTapping.value !=
                            null) {
                          if (widget.kindOfSelected == 'addAds') {
                            context.read<AddAdsCubit>().updateLocation(controller!
                                .listenerMapSingleTapping.value!.latitude,controller!
                                .listenerMapSingleTapping.value!.longitude);
                            // context.read<AddAdsCubit>().latitude = controller!
                            //     .listenerMapSingleTapping.value!.latitude;
                            // context.read<AddAdsCubit>().longitude = controller!
                            //     .listenerMapSingleTapping.value!.longitude;
                            Future.delayed(Duration(milliseconds: 250), () {
                              Navigator.pop(context);
                            });
                          } else if (widget.kindOfSelected == 'register') {
                            context.read<RegisterCubit>().latitude = controller!
                                .listenerMapSingleTapping.value!.latitude;
                            context.read<RegisterCubit>().longitude =
                                controller!
                                    .listenerMapSingleTapping.value!.longitude;
                            Future.delayed(Duration(milliseconds: 250), () {
                              Navigator.pop(context);
                            });
                          } else {
                            context.read<AddProjectCubit>().updateLocation(controller!
                                .listenerMapSingleTapping.value!.latitude,controller!
                                .listenerMapSingleTapping.value!.longitude);
                            // context.read<AddProjectCubit>().latitude =
                            //     controller!
                            //         .listenerMapSingleTapping.value!.latitude;
                            // context.read<AddProjectCubit>().longitude =
                            //     controller!
                            //         .listenerMapSingleTapping.value!.longitude;
                            Future.delayed(Duration(milliseconds: 250), () {
                              Navigator.pop(context);
                            });
                          }
                        } else {
                          toastMessage('Please Select The Location', context,
                              color: AppColors.error);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size.infinite,
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(155, 56),
                          backgroundColor: AppColors.primary),
                      child: Text(
                        translateText(AppStrings.selectBtn, context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          maximumSize: Size.infinite,
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(155, 56),
                          backgroundColor: AppColors.buttonBackground),
                      child: Text(
                        translateText(AppStrings.backBtn, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
  }
}
