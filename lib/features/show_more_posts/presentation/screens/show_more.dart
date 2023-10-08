import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/features/show_more_posts/presentation/cubit/show_more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/snackbar_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;

import '../../../home_page/data/models/slider_data_model.dart';
import '../widgets/body_widget.dart';

class ShowMoreScreen extends StatefulWidget {
  const ShowMoreScreen({Key? key, required this.kind, required this.sliderList})
      : super(key: key);
  final String kind;
  final List<DatumModel> sliderList;

  @override
  State<ShowMoreScreen> createState() => _ShowMoreScreenState();
}

class _ShowMoreScreenState extends State<ShowMoreScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.kind.toLowerCase() == 'popular') {
      context.read<ShowMoreCubit>().getShowMoreData(pram: 'popular');
    } else {
      context.read<ShowMoreCubit>().getShowMoreData(pram: 'new');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(widget.kind),
      ),
      body: BlocBuilder<ShowMoreCubit, ShowMoreState>(
        builder: (BuildContext context, state) {
          if (state is ShowMoreLoading) {
            return const ShowLoadingIndicator();
          } else if (state is ShowMoreLoadedError) {
            return error_widget.ErrorWidget(
              onPressed: () => context.read<ShowMoreCubit>().getShowMoreData(
                    pram: widget.kind.toLowerCase(),
                  ),
            );
          } else {
            return LazyLoadScrollView(
              isLoading: context.read<ShowMoreCubit>().isLoadingVertical,
              onEndOfPage: () {
                if (context.read<ShowMoreCubit>().showMore.data!.links!.next ==
                    null) {
                  snackBar(
                      translateText(AppStrings.noDataMessage, context), context,
                      color: AppColors.error);
                } else {
                  snackBar("loading", context);
                  context.read<ShowMoreCubit>().getPaginationData(
                      link: context
                          .read<ShowMoreCubit>()
                          .showMore
                          .data!
                          .links!
                          .next!,
                      pram: widget.kind.toLowerCase() == 'popular'
                          ? "popular"
                          : "new");
                }
              },
              child: BodyWidget(
                showMoreList: context.read<ShowMoreCubit>().mainItemsList,
                myContext: context,
                sliderList: widget.sliderList,
              ),
            );
          }
        },
      ),
    );
  }
}
