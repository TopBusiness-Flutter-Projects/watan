import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/convert_numbers_method.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../cubit/filter_cubit.dart';

class BedRoomsWidget extends StatefulWidget {
  const BedRoomsWidget({Key? key, required this.typeClass}) : super(key: key);
  final String typeClass;

  @override
  State<BedRoomsWidget> createState() => _BedRoomsWidgetState();
}

class _BedRoomsWidgetState extends State<BedRoomsWidget> {
  int selected = -1;
  bool isAllSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.typeClass == 'add') {
      if (context.read<AddAdsCubit>().btnText == 'update') {
        selected = context.read<AddAdsCubit>().bedroom;
      } else {
        context.read<AddAdsCubit>().bedroom = -1;
      }
    } else {
      context.read<FilterCubit>().bedroom = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              ImageAssets.roomsGoldIcon,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 10),
            Text(
              translateText(AppStrings.bedroomText, context),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  isAllSelected = !isAllSelected;
                });
              },
              child: Text(
                translateText(
                    isAllSelected
                        ? AppStrings.unselectAllText
                        : AppStrings.selectAllText,
                    context),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isAllSelected ? AppColors.primary : AppColors.gray),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                16,
                (index) => GestureDetector(
                  onTap: () {
                    if (widget.typeClass == 'add') {
                      setState(() {
                        selected = index;
                        context.read<AddAdsCubit>().bedroom = selected;
                      });
                    } else {
                      if (selected == index) {
                        setState(() {
                          selected = -1;
                          context.read<FilterCubit>().bedroom = -1;
                        });
                      } else {
                        setState(() {
                          selected = index;
                          context.read<FilterCubit>().bedroom = selected;
                        });
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: index == 0 ? 100 : 50,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: (selected == index || isAllSelected)
                              ? AppColors.primary
                              : AppColors.gray,
                          width: (selected == index || isAllSelected) ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          index == 0
                              ? translateText(AppStrings.studioText, context)
                              : IsLanguage.isEnLanguage(context)
                                  ? index.toString()
                                  : replaceToArabicNumber(index.toString()),
                          style: TextStyle(
                            fontSize: 12,
                            color: (selected == index || isAllSelected)
                                ? AppColors.primary
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
