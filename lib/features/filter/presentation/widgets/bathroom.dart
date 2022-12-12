import 'package:elwatn/core/utils/convert_numbers_method.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:elwatn/features/add/presentation/cubit/add_ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../cubit/filter_cubit.dart';

class ListNumbersWidget extends StatefulWidget {
  const ListNumbersWidget({
    Key? key,
    required this.title,
    required this.image,
    this.kind = "null",
  }) : super(key: key);
  final String title;
  final String image;
  final String kind;

  @override
  State<ListNumbersWidget> createState() => _ListNumbersWidgetState();
}

class _ListNumbersWidgetState extends State<ListNumbersWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.kind != 'null') {
      if (context.read<AddAdsCubit>().btnText == 'update') {
        if (widget.kind == 'bathroom') {
          selected = context.read<AddAdsCubit>().bathroom;
        } else if (widget.kind == 'kitchen') {
          selected = context.read<AddAdsCubit>().kitchen;
        } else if (widget.kind == 'living') {
          selected = context.read<AddAdsCubit>().livingRoom;
        } else if (widget.kind == 'dining') {
          selected = context.read<AddAdsCubit>().diningRoom;
        }
      } else {
        context.read<AddAdsCubit>().bathroom = 0;
      }
    } else {
      context.read<FilterCubit>().bathroom = 0;
    }
  }

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              widget.image,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 10),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
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
                15,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                    if (widget.kind == 'null') {
                      context.read<FilterCubit>().bathroom = selected + 1;
                    } else {
                      if (widget.kind == 'bathroom') {
                        context.read<AddAdsCubit>().bathroom = selected + 1;
                      } else if (widget.kind == 'kitchen') {
                        context.read<AddAdsCubit>().kitchen = selected + 1;
                      } else if (widget.kind == 'living') {
                        context.read<AddAdsCubit>().livingRoom = selected + 1;
                      } else if (widget.kind == 'dining') {
                        context.read<AddAdsCubit>().diningRoom = selected + 1;
                      }
                    }
                  },
                  child: selected == index
                      ? Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 50,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.primary, width: 2),
                            ),
                            child: Center(
                                child: Text(
                              IsLanguage.isEnLanguage(context)
                                  ? (index + 1).toString()
                                  : replaceToArabicNumber(
                                      (index + 1).toString(),
                                    ),
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.primary),
                            )),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 50,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.gray),
                            ),
                            child: Center(
                                child: Text(
                              IsLanguage.isEnLanguage(context)
                                  ? (index + 1).toString()
                                  : replaceToArabicNumber(
                                      (index + 1).toString()),
                              style: const TextStyle(fontSize: 12),
                            )),
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
