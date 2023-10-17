import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/widgets/scound_main_project_item.dart';
import 'package:elwatn/features/filter/presentation/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/scound_main_item.dart';

class FilterResult extends StatelessWidget {
  const FilterResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.filterText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        actions: [Image.asset(ImageAssets.logoIcon)],
      ),
      body: TitleScrollNavigation(
        showIdentifier: false,
        barStyle: TitleNavigationBarStyle(
          style: const TextStyle(fontWeight: FontWeight.bold),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 7,
            vertical: 12,
          ),
          spaceBetween: MediaQuery.of(context).size.width / 2,
          activeColor: AppColors.primary,
          // background: AppColors.buttonBackground,
        ),
        titles: [
          translateText(AppStrings.adsText, context),
          translateText(AppStrings.projectText, context),
        ],
        pages: [
          SingleChildScrollView(
            child:
                context.read<FilterCubit>().filterResponse.data!.ads!.length > 0
                    ? Column(
                        children: [
                          ...List.generate(
                            context
                                .read<FilterCubit>()
                                .filterResponse
                                .data!
                                .ads!
                                .length,
                            (index) => SecondMainItemWidget(
                              mainItemModel: context
                                  .read<FilterCubit>()
                                  .filterResponse
                                  .data!
                                  .ads![index],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          translateText("no_data", context),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
          ),
          SingleChildScrollView(
            child: context
                        .read<FilterCubit>()
                        .filterResponse
                        .data!
                        .projects!
                        .length >
                    0
                ? Column(
                    children: [
                      ...List.generate(
                        context
                            .read<FilterCubit>()
                            .filterResponse
                            .data!
                            .projects!
                            .length,
                        (index) => SecondMainProjectItemWidget(
                          mainProjectItemModel: context
                              .read<FilterCubit>()
                              .filterResponse
                              .data!
                              .projects![index],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      translateText("no_data", context),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
