import 'package:elwatn/features/home_page/presentation/widgets/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/banner_ads.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/home_page_cubit.dart';
import '../widgets/home_model.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (Routes.isLogout) {
      context.read<HomePageCubit>().getAllDataOfHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        if (state is HomePageLoading) {
          return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomePageCubit>().getAllDataOfHomePage();
              },
              child: Column(
                children: [
                  const ShowLoadingIndicator(),
                ],
              ));
        } else if (state is HomePageGetAllDataFinish) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<HomePageCubit>().getAllDataOfHomePage();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    openMyDrawer: () =>
                        widget.scaffoldKey.currentState!.openDrawer(),
                  ),
                  BannerWidget(sliderData: state.slider.data!),
                  CategoriesWidget(categoriesDatum: state.categories.data!),
                  HomeModelWidget(
                    kind: AppLocalizations.of(context)!
                        .translate(AppStrings.addNewTitle)!,
                    mainItem: state.newPopularItems.data!,
                    slider: state.slider.data!,
                  ),
                  HomeModelWidget(
                    kind: AppLocalizations.of(context)!
                        .translate(AppStrings.popularTitle)!,
                    mainItem: state.newPopularItems.data!,
                    slider: state.slider.data!,
                  ),
                ],
              ),
            ),
          );
        } else if (state is HomePageError) {
          return error_widget.ErrorWidget(
            onPressed: () =>
                context.read<HomePageCubit>().getAllDataOfHomePage(),
          );
        } else {
          return const ShowLoadingIndicator();
        }
      },
    );
  }
}
