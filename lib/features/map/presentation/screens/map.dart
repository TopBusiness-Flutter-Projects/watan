import 'package:elwatn/core/helper/location_helper.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/toast_message_method.dart';
import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/map_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
            print(controller!.listenerMapSingleTapping.value);

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
                    scaleAssetImage: 2,
                  ),
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
        ? BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              if (state is AllMapLocationsError) {
                toastMessage(
                  'Error To Get Posts Locations',
                  context,
                  color: AppColors.error,
                );
              }
              if (state is AllMapLocationsLoading) {
                return ShowLoadingIndicator();
              } else {
                return Scaffold(
                  key: scaffoldKey,
                  resizeToAvoidBottomInset: true,
                  body: SafeArea(
                    child: OSMFlutter(
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
                      initZoom: 8,
                      minZoomLevel: 3,
                      maxZoomLevel: 18,
                      stepZoom: 1.0,
                      showContributorBadgeForOSM: false,
                      showDefaultInfoWindow: false,
                      staticPoints: [
                        StaticPositionGeoPoint(
                          "line 1",
                          MarkerIcon(
                            assetMarker: AssetMarker(
                                image: AssetImage(
                                  ImageAssets.markerImage,
                                ),
                                scaleAssetImage: 2),
                          ),
                          context.read<MapCubit>().geoPoints,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
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
