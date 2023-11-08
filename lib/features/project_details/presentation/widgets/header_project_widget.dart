import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../details/presentation/widgets/details_images_banner_widget.dart';
import '../../../details/presentation/widgets/icon_shape.dart';
import '../../../favorite/presentation/cubit/favourites_cubit.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';
import '../../../language/presentation/cubit/locale_cubit.dart';
import '../../../login/presentation/screens/login.dart';
import '../screens/details_photo_project_screen.dart';

class ProjectHeaderWidget extends StatefulWidget {
  const ProjectHeaderWidget({Key? key, required this.mainProjectItemModel})
      : super(key: key);
  final MainProjectItem mainProjectItemModel;

  @override
  State<ProjectHeaderWidget> createState() => _ProjectHeaderWidgetState();
}

class _ProjectHeaderWidgetState extends State<ProjectHeaderWidget> {
  final bool isMap = true;
  bool isFavourite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.mainProjectItemModel.isFavourite!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DetailsBannerWidget(
            isDotes: false, imagesBanner: widget.mainProjectItemModel.images!),
        Positioned(
          top: 8,
          left: 0,
          right: 0,
          child: Row(
            children: [
              //ToDo Icons Actions of fav & share
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: IconShapeWidget(
                      text: "null",
                      icon: Icons.arrow_back_sharp,
                      onClick: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ),
              Expanded(
                  child: IconShapeWidget(
                      text: "null", icon: Icons.share, onClick: () {})),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.opacityWhite),
                    child: isLoading
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (context.read<LocaleCubit>().loginDataModel ==
                                  null) {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "\n You Should Login First ",
                                  buttons: [
                                    DialogButton(
                                      onPressed: () => Navigator.pop(context),
                                      color: AppColors.buttonBackground,
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    DialogButton(
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const LoginScreen();
                                          },
                                        ),
                                      ),
                                      color: AppColors.error,
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ],
                                ).show();
                              } else {
                                context.read<FavouritesCubit>().cubitKind =
                                    'null';
                                context.read<FavouritesCubit>().getFavourite =
                                    'change';
                                setState(() {
                                  isLoading = true;
                                });
                                context
                                    .read<FavouritesCubit>()
                                    .changeFavouritesStatus(
                                      widget.mainProjectItemModel.id.toString(),
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
                                                    .read<FavouritesCubit>()
                                                    .message !=
                                                'There are some Errors') {
                                              isFavourite = context
                                                  .read<FavouritesCubit>()
                                                  .favourite;
                                            }
                                          });
                                          toastMessage(
                                            context
                                                .read<FavouritesCubit>()
                                                .message,
                                            context,
                                            color: AppColors.primary,
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
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          left: 20,
          right: 20,
          child: Row(
            children: [
              widget.mainProjectItemModel.images!.isNotEmpty
                  ? const Spacer()
                  : const SizedBox(width: 0),
              widget.mainProjectItemModel.images!.isNotEmpty
                  ? IconShapeWidget(
                      text: IsLanguage.isEnLanguage(context)
                          ? widget.mainProjectItemModel.images!.length
                              .toString()
                          : replaceToArabicNumber(widget
                              .mainProjectItemModel.images!.length
                              .toString()),
                      icon: Icons.image,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsPhotoProjectScreen(
                                initialPage: 0,
                                mainProjectItemModel:
                                    widget.mainProjectItemModel,
                              );
                            },
                          ),
                        );
                      },
                    )
                  : const SizedBox(width: 0),
              widget.mainProjectItemModel.videos.isNotEmpty
                  ? const Spacer()
                  : const SizedBox(width: 0),
              widget.mainProjectItemModel.videos.isNotEmpty
                  ? IconShapeWidget(
                      text: IsLanguage.isEnLanguage(context)
                          ? widget.mainProjectItemModel.videos.length.toString()
                          : replaceToArabicNumber(widget
                              .mainProjectItemModel.videos.length
                              .toString()),
                      icon: Icons.video_camera_back,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsPhotoProjectScreen(
                                initialPage: 1,
                                mainProjectItemModel:
                                    widget.mainProjectItemModel,
                              );
                            },
                          ),
                        );
                      },
                    )
                  : const SizedBox(width: 0),
              widget.mainProjectItemModel.floorPlans!.isNotEmpty
                  ? const Spacer()
                  : const SizedBox(width: 0),
              widget.mainProjectItemModel.floorPlans!.isNotEmpty
                  ? IconShapeWidget(
                      text: IsLanguage.isEnLanguage(context)
                          ? widget.mainProjectItemModel.floorPlans!.length
                              .toString()
                          : replaceToArabicNumber(widget
                              .mainProjectItemModel.floorPlans!.length
                              .toString()),
                      icon: Icons.schema_outlined,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsPhotoProjectScreen(
                                initialPage: 2,
                                mainProjectItemModel:
                                    widget.mainProjectItemModel,
                              );
                            },
                          ),
                        );
                      },
                    )
                  : const SizedBox(width: 0),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
