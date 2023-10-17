import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/snackbar_method.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;
import '../../../language/presentation/cubit/locale_cubit.dart';
import '../cubit/show_lists_cubit.dart';
import '../widgets/show_list_body_widget.dart';
import '../widgets/show_project_list_body_widget.dart';

class ShowLists extends StatefulWidget {
  const ShowLists({Key? key, required this.kind, required this.index})
      : super(key: key);
  final String kind;
  final int index;

  @override
  State<ShowLists> createState() => _ShowListsState();
}

class _ShowListsState extends State<ShowLists> {
  @override
  void initState() {
    super.initState();
    getPosts();
  }

  getPosts() {
    if (widget.index == 0) {
      context.read<ShowListsCubit>().loginDataModel =
          context.read<LocaleCubit>().loginDataModel;
      context.read<ShowListsCubit>().getShowListsData(pram: "clients");
    } else if (widget.index == 1) {
      context.read<ShowListsCubit>().loginDataModel =
          context.read<LocaleCubit>().loginDataModel;
      context.read<ShowListsCubit>().getShowListsData(pram: 'companies');
    } else {
      context.read<ShowListsCubit>().loginDataModel =
          context.read<LocaleCubit>().loginDataModel;
      context.read<ShowListsCubit>().getShowProjectListsData(pram: 'projects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(widget.kind),
      ),
      body: BlocBuilder<ShowListsCubit, ShowListsState>(
        builder: (context, state) {
          if (state is ShowListsLoading) {
            return const ShowLoadingIndicator();
          } else if (state is ShowListsLoadedError) {
            return error_widget.ErrorWidget(
              onPressed: () => getPosts(),
            );
          }
          return LazyLoadScrollView(
            isLoading: context.read<ShowListsCubit>().isLoadingVertical,
            onEndOfPage: () {
              if (widget.index == 0 || widget.index == 1) {
                if (context.read<ShowListsCubit>().showLists.links!.next ==
                    null) {
                  snackBar(
                    translateText(AppStrings.noDataMessage, context),
                    context,
                    color: AppColors.error,
                  );
                } else {
                  snackBar("loading", context);
                  context.read<ShowListsCubit>().getPaginationShowListsData(
                        pram: context
                            .read<ShowListsCubit>()
                            .showLists
                            .links!
                            .next!,
                      );
                }
              } else {
                if (context
                    .read<ShowListsCubit>()
                    .showProjectLists
                    .nextPageUrl
                    .isEmpty) {
                  snackBar(
                    translateText(AppStrings.noDataMessage, context),
                    context,
                    color: AppColors.error,
                  );
                } else {
                  snackBar("loading", context);
                  context
                      .read<ShowListsCubit>()
                      .getPaginationProjectShowListsData(
                        pram: context
                            .read<ShowListsCubit>()
                            .showProjectLists
                            .nextPageUrl,
                      );
                }
              }
            },
            child: widget.index == 0 || widget.index == 1
                ? RefreshIndicator(
                    onRefresh: () => getPosts(),
                    child: context.read<ShowListsCubit>().mainItemsList.length>0? ShowListBodyWidget(
                      mainItemModel:
                          context.read<ShowListsCubit>().mainItemsList,
                    ):
          Center(
          child: Text(translateText("no_data", context),
          style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
          ),
          ),
                  )
                : RefreshIndicator(
                    onRefresh: () => getPosts(),
                    child: context.read<ShowListsCubit>().mainProjectItemsList.length>0? ShowProjectListBodyWidget(
                      mainProjectItemModel:
                          context.read<ShowListsCubit>().mainProjectItemsList,
                    ) :   Center(
            child: Text(translateText("no_data", context),
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
          ),
          ),
                  ),
          );
        },
      ),
    );
  }
}
