import 'package:flutter/material.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../details/presentation/widgets/veiw_map_widget.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';

class DetailsPhotoProjectScreen extends StatefulWidget {
  const DetailsPhotoProjectScreen(
      {Key? key, required this.initialPage, required this.mainProjectItemModel})
      : super(key: key);
  final int initialPage;
  final MainProjectItem mainProjectItemModel;

  @override
  State<DetailsPhotoProjectScreen> createState() => _DetailsPhotoProjectScreenState();
}

class _DetailsPhotoProjectScreenState extends State<DetailsPhotoProjectScreen> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.mainProjectItemModel.videos.isNotEmpty) {
      _controller = VideoPlayerController.network(
          widget.mainProjectItemModel.videos[0].attachment!);
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.setLooping(true);
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    if (widget.mainProjectItemModel.videos.isNotEmpty) {
      _controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.detailsText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: TitleScrollNavigation(
        initialPage: widget.initialPage,
        showIdentifier: false,
        barStyle: TitleNavigationBarStyle(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 16,
                vertical: 12),
            spaceBetween: MediaQuery.of(context).size.width / 8,
            activeColor: AppColors.primary,
            background: AppColors.buttonBackground),
        titles: [
          translateText(AppStrings.imagesText,context),
          translateText(AppStrings.videoText,context),
          translateText(AppStrings.schemaText,context),
          translateText(AppStrings.mapText,context),
        ],
        pages: [
          SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  widget.mainProjectItemModel.images!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ManageNetworkImage(
                      imageUrl: widget.mainProjectItemModel.images![index].attachment!,
                      width: MediaQuery.of(context).size.width - 55,
                      height: 200,
                      borderRadius: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                if(widget.mainProjectItemModel.videos.isNotEmpty)...{
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        return const SizedBox(
                          height: 150,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                }else...{
                  Container(),
                }

              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  widget.mainProjectItemModel.floorPlans!.length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ManageNetworkImage(
                      imageUrl: widget.mainProjectItemModel.floorPlans![index].attachment!,
                      width: MediaQuery.of(context).size.width - 55,
                      height: 200,
                      borderRadius: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ViewMapWidget(
            latitude: widget.mainProjectItemModel.latitude!,
            longitude: widget.mainProjectItemModel.longitude!,
          ),
        ],
      ),
    );
  }
}
