import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../add_project/presentation/cubit/add_project_cubit.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';

class PickVideosContainerWidget extends StatefulWidget {
  const PickVideosContainerWidget(
      {Key? key, required this.title, this.kind = 'null'})
      : super(key: key);
  final String title;
  final String kind;

  @override
  State<PickVideosContainerWidget> createState() =>
      _PickVideosContainerWidgetState();
}

class _PickVideosContainerWidgetState extends State<PickVideosContainerWidget> {
  final picker = ImagePicker();
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.kind == 'addAds') {
      if (context.read<AddAdsCubit>().btnText == 'update') {
        if (context.read<AddAdsCubit>().videoLink.isNotEmpty) {
          _controller = VideoPlayerController.network(
            context.read<AddAdsCubit>().videoLink.split('@').first,
          );
          _initializeVideoPlayerFuture = _controller!.initialize();
          _controller!.setLooping(true);
        }
      }
    } else if (widget.kind == 'addProject') {
      if (context.read<AddProjectCubit>().btnText == 'update') {
        if (context.read<AddProjectCubit>().videoLink.isNotEmpty) {
          _controller = VideoPlayerController.network(
            context.read<AddProjectCubit>().videoLink.split('@').first,
          );
          _initializeVideoPlayerFuture = _controller!.initialize();
          _controller!.setLooping(true);
        }
      }
    }
  }

  @override
  void dispose() {
    if (_video != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileAllDetailsWidget(
          image: ImageAssets.cameraIcon,
          text: widget.title,
          iconColor: AppColors.primary,
          isAddScreen: true,
        ),
        if (widget.kind == 'addAds') ...{
          if (context.read<AddAdsCubit>().videoLink.isNotEmpty) ...{
            Column(
              children: [
                Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
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
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              _controller!.pause();
                              context.read<AddAdsCubit>().removedVideos.add(
                                    context
                                        .read<AddAdsCubit>()
                                        .videoLink
                                        .split('@')[1],
                                  );
                              context.read<AddAdsCubit>().videoLink = '';
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary,
                          ),
                          child: Icon(
                            Icons.clear,
                            size: 25,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: InkWell(
                        onTap: () async {
                          context.read<AddAdsCubit>().videoLink = '';
                          _pickVideo();
                        },
                        child: Container(
                          height: 80,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.addIcon,
                                  width: 16,
                                  height: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  translateText(AppStrings.uploadText, context),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        setState(
                          () {
                            if (_controller!.value.isPlaying) {
                              _controller!.pause();
                            } else {
                              _controller!.play();
                            }
                          },
                        );
                      },
                      child: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            )
          } else ...{
            GestureDetector(
              onTap: () async {
                if (_video == null) {
                  _pickVideo();
                }
              },
              child: Container(
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _video == null
                    ? Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImageAssets.addIcon),
                            const SizedBox(width: 5),
                            Text(
                              translateText(AppStrings.uploadText, context),
                              style: TextStyle(
                                color: AppColors.gray,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    setState(
                                      () {
                                        _controller!.pause();
                                        _video = null;
                                        _controller = null;
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.primary,
                                    ),
                                    child: Icon(
                                      Icons.clear,
                                      size: 25,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: InkWell(
                                  onTap: () async {
                                    _pickVideo();
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.primary)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.addIcon,
                                            width: 16,
                                            height: 16,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            translateText(AppStrings.uploadText, context),
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FloatingActionButton(
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  setState(() {
                                    if (_controller!.value.isPlaying) {
                                      _controller!.pause();
                                    } else {
                                      _controller!.play();
                                    }
                                  });
                                },
                                child: Icon(
                                  _controller!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                              const Spacer(),
                            ],
                          )
                        ],
                      ),
              ),
            ),
          }
        } else ...{
          if (context.read<AddProjectCubit>().videoLink.isNotEmpty) ...{
            Column(
              children: [
                Stack(
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
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
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              _controller!.pause();
                              context.read<AddProjectCubit>().removedVideos.add(
                                    context
                                        .read<AddProjectCubit>()
                                        .videoLink
                                        .split('@')[1],
                                  );
                              context.read<AddProjectCubit>().videoLink = '';
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary,
                          ),
                          child: Icon(
                            Icons.clear,
                            size: 25,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: InkWell(
                        onTap: () async {
                          context.read<AddProjectCubit>().videoLink = '';
                          _pickVideo();
                        },
                        child: Container(
                          height: 80,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.addIcon,
                                  width: 16,
                                  height: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  translateText(AppStrings.uploadText, context),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                        setState(
                          () {
                            if (_controller!.value.isPlaying) {
                              _controller!.pause();
                            } else {
                              _controller!.play();
                            }
                          },
                        );
                      },
                      child: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            )
          } else ...{
            GestureDetector(
              onTap: () async {
                if (_video == null) {
                  _pickVideo();
                }
              },
              child: Container(
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _video == null
                    ? Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(ImageAssets.addIcon),
                            const SizedBox(width: 5),
                            Text(
                              translateText(AppStrings.uploadText, context),
                              style: TextStyle(
                                color: AppColors.gray,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    setState(
                                      () {
                                        _controller!.pause();
                                        _video = null;
                                        _controller = null;
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.primary,
                                    ),
                                    child: Icon(
                                      Icons.clear,
                                      size: 25,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: InkWell(
                                  onTap: () async {
                                    _pickVideo();
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.primary)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            ImageAssets.addIcon,
                                            width: 16,
                                            height: 16,
                                            color: AppColors.primary,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            translateText(AppStrings.uploadText, context),
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FloatingActionButton(
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  setState(() {
                                    if (_controller!.value.isPlaying) {
                                      _controller!.pause();
                                    } else {
                                      _controller!.play();
                                    }
                                  });
                                },
                                child: Icon(
                                  _controller!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                              const Spacer(),
                            ],
                          )
                        ],
                      ),
              ),
            ),
          }
        },
      ],
    );
  }

  VideoPlayerController? _controller;
  File? _video;

  _pickVideo() async {
    XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    widget.kind == 'addProject'
        ? context.read<AddProjectCubit>().video = pickedFile
        : context.read<AddAdsCubit>().video = pickedFile;
    _video = File(pickedFile!.path);
    _controller = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _controller!.play();
      });
  }
}
