import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:elwatn/features/filter/presentation/widgets/agency.dart';
import 'package:elwatn/features/filter/presentation/widgets/area_range.dart';
import 'package:elwatn/features/filter/presentation/widgets/bathroom.dart';
import 'package:elwatn/features/filter/presentation/widgets/bedrooms.dart';
import 'package:elwatn/features/filter/presentation/widgets/the_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/select_city_location_widget.dart';
import '../../../../core/widgets/select_city_widget.dart';
import '../cubit/filter_cubit.dart';
import '../widgets/dropdown_search.dart';
import '../widgets/dropdown_search_locations.dart';
import '../widgets/price.dart';
import '../widgets/property_type.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.filterText,context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: BlocBuilder<FilterCubit, FilterState>(
            builder: (context, state) {
              if (state is FilterResponseLoading) {
                return const ShowLoadingIndicator();
              } else if (state is FilterResponseLoaded) {
                Future.delayed(const Duration(milliseconds: 700), () {
                  Navigator.pushNamed(context, Routes.filterResultRoute).then(
                      (value) => context.read<FilterCubit>().pageChange());
                });
                return const ShowLoadingIndicator();
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Material(
                        color: AppColors.white,
                        child: TabBar(
                          indicatorColor: AppColors.primary,
                          tabs:  [
                            Tab(
                              text: translateText(AppStrings.statusSaleText,context),
                            ),
                            Tab(
                              text: translateText(AppStrings.statusRentText,context),
                            ),
                          ],
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.black,
                          onTap: (index) {
                            if (index == 0) {
                              context.read<FilterCubit>().status = 'sale';
                            } else {
                              context.read<FilterCubit>().status = 'rent';
                            }
                          },
                          indicator: RectangularIndicator(
                            color: AppColors.primary,
                            bottomLeftRadius: 100,
                            bottomRightRadius: 100,
                            topLeftRadius: 100,
                            topRightRadius: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const SelectCityWidget(kind: "filter"),
                  const SizedBox(height: 12),
                  const SelectCityLocation(kind: 'filter'),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const PropertyTypeWidget(kind: "filter"),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const PriceWidget(),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const BedRoomsWidget(typeClass: 'filter'),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const ListNumbersWidget(
                    image: ImageAssets.bathGoldIcon,
                    title: "Bathroom",
                  ),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const AreaRangeWidget(),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const AgencyWidget(),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                  const TheBottomWidget(),
                  const SizedBox(height: 6),
                  const Divider(thickness: 2),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}