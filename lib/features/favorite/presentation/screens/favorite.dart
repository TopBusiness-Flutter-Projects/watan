import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/scound_main_item.dart';
import '../../../../core/widgets/scound_main_project_item.dart';
import '../cubit/favourites_cubit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<FavouritesCubit>().getFavourite == 'null' ||
        context.read<FavouritesCubit>().getFavourite == 'change') {
      context.read<FavouritesCubit>().getMyFavourites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        if (state is FavouritesLoading) {
          return const ShowLoadingIndicator();
        } else if (state is FavouritesFailure) {
          return error_widget.ErrorWidget(
            onPressed: () => context.read<FavouritesCubit>().getMyFavourites(),
          );
        }
        return context.read<FavouritesCubit>().mainItemModel != null
            ? SafeArea(
                child: TitleScrollNavigation(
                  showIdentifier: false,
                  identiferStyle: NavigationIdentiferStyle(
                      color: AppColors.primary, width: 2),
                  barStyle: TitleNavigationBarStyle(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 7,
                      vertical: 12,
                    ),
                    spaceBetween: MediaQuery.of(context).size.width / 2,
                    activeColor: AppColors.primary,
                  ),
                  titles: [
                    translateText(AppStrings.adsText, context),
                    translateText(AppStrings.projectText, context),
                  ],
                  pages: [
                    RefreshIndicator(
                      onRefresh: () async {
                        context.read<FavouritesCubit>().getMyFavourites();
                      },
                      child:  context
                          .read<FavouritesCubit>()
                          .mainItemModel!
                          .length>0?ListView(
                        children: [
                          ...List.generate(
                            context
                                .read<FavouritesCubit>()
                                .mainItemModel!
                                .length,
                            (index) => SecondMainItemWidget(
                              mainItemModel: context
                                  .read<FavouritesCubit>()
                                  .mainItemModel![index],
                            ),
                          ),
                        ],
                      ) :   Center(
        child: Text(translateText("no_data", context),
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
        ),
        ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        context.read<FavouritesCubit>().getMyFavourites();
                      },
                      child: context
            .read<FavouritesCubit>()
            .mainProjectItemModel!
            .length>0? ListView(
                        children: [
                          ...List.generate(
                            context
                                .read<FavouritesCubit>()
                                .mainProjectItemModel!
                                .length,
                            (index) => SecondMainProjectItemWidget(
                              mainProjectItemModel: context
                                  .read<FavouritesCubit>()
                                  .mainProjectItemModel![index],
                            ),
                          ),
                        ],
                      ):    Center(
                        child: Text(translateText("no_data", context),
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ShowLoadingIndicator();
      },
    );
  }
}
