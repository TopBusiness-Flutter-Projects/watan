import 'package:dropdown_search/dropdown_search.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../add_project/presentation/cubit/add_project_cubit.dart';
import '../cubit/filter_cubit.dart';

class DropdownSearchWidget extends StatelessWidget {
  const DropdownSearchWidget({
    Key? key,
    required this.dropdownList,
    required this.icon,
    required this.labelText,
    required this.isEnable,
    this.kind = "null",
    this.update = "null",
  }) : super(key: key);
  final List<String> dropdownList;
  final IconData icon;
  final String labelText;
  final bool isEnable;
  final String? kind;
  final String? update;

  @override
  Widget build(BuildContext context) {
    List<String> s = [];
    List<String> ids = [];
    for (var element in dropdownList) {
      s.add(element.split("/")[0]);
      ids.add(element.split("/")[1]);
    }

    return Theme(
      data: ThemeData(
          textTheme: const TextTheme(subtitle1: TextStyle(fontSize: 14))),
      child: DropdownSearch<String>(
        selectedItem: kind == 'addAds'
            ? context.read<AddAdsCubit>().btnText == 'update'
                ? context.read<AddAdsCubit>().citiesEn.isNotEmpty
                    ? s[ids
                        .indexOf(context.read<AddAdsCubit>().cityId.toString())]
                    : null
                : null
            : kind == "addPriceCurrency"
                ? context.read<AddAdsCubit>().currency == 'USD'
                    ? s[0]
                    : s[1]
                : kind == "addProject"
                    ? context.read<AddProjectCubit>().btnText == 'update'
                        ? context.read<AddProjectCubit>().citiesEn.isNotEmpty
                            ? s[ids.indexOf(
                                context.read<AddProjectCubit>().cityId.toString())]
                            : null
                        : null
                    : null,
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
          fit: FlexFit.loose,
        ),
        enabled: isEnable,
        items: s,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            filled: true,
            enabled: true,
            isCollapsed: false,
            hintText: labelText,
            iconColor: AppColors.primary,
            focusColor: AppColors.primary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: icon == Icons.abc
                ? null
                : Icon(
                    icon,
                    color: AppColors.gray,
                  ),
          ),
        ),
        autoValidateMode: AutovalidateMode.always,
        onChanged: (text) {
          if (labelText == translateText(AppStrings.selectCityText, context)) {
            for (var element in dropdownList) {
              if (element.contains(text!)) {
                if (kind == 'addAds') {
                  context.read<AddAdsCubit>().clearCitiesLocations();
                  context
                      .read<AddAdsCubit>()
                      .getAllLocationOfCitiesById(element.split("/")[1]);
                  context.read<AddAdsCubit>().cityId =
                      int.parse(element.split("/")[1]);
                } else if (kind == 'addProject') {
                  context.read<AddProjectCubit>().clearCitiesLocations();
                  context
                      .read<AddProjectCubit>()
                      .getAllLocationOfCitiesById(element.split("/")[1]);
                  context.read<AddProjectCubit>().cityId =
                      int.parse(element.split("/")[1]);
                } else {
                  context.read<FilterCubit>().clearCitiesLocations();
                  context
                      .read<FilterCubit>()
                      .getAllLocationOfCitiesById(element.split("/")[1]);
                  context.read<FilterCubit>().cityId =
                      int.parse(element.split("/")[1]);
                }
              }
            }
          } else if (labelText == "Select Agent") {
            for (var element in dropdownList) {
              if (element.contains(text!)) {
                context.read<FilterCubit>().agentId =
                    int.parse(element.split("/")[1]);
              }
            }
          } else if (labelText ==
              translateText(AppStrings.currencyText, context)) {
            for (var element in dropdownList) {
              if (element.contains(text!)) {
                if (kind == "addPriceCurrency") {
                  context.read<AddAdsCubit>().currency = element.split("/")[1];
                } else if (kind == "addProject") {
                  context.read<AddProjectCubit>().currency = element.split("/")[1];
                } else {
                  context.read<FilterCubit>().currency = element.split("/")[1];
                }
              }
            }
          }
        },
      ),
    );
  }
}
