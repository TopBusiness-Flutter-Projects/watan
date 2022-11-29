import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';
import 'floor_plans_widget.dart';

class UnitDetailsFloorPlansWidget extends StatefulWidget {
  const UnitDetailsFloorPlansWidget(
      {Key? key, required this.mainProjectItemModel})
      : super(key: key);
  final MainProjectItem mainProjectItemModel;

  @override
  State<UnitDetailsFloorPlansWidget> createState() =>
      _UnitDetailsFloorPlansWidgetState();
}

class _UnitDetailsFloorPlansWidgetState
    extends State<UnitDetailsFloorPlansWidget> {
  int page = 0;
  late UnitDetail unitDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String num = widget.mainProjectItemModel.unitDetails[index]
                        .first.bedrooms!;
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            page = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: page == index
                                  ? AppColors.primary
                                  : AppColors.buttonBackground,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              IsLanguage.isEnLanguage(context)?"$num ${translateText(AppStrings.bedroomText, context)}":'${replaceToArabicNumber(num)} ${translateText(AppStrings.bedroomText, context)}',
                              style: TextStyle(
                                  color: page == index
                                      ? AppColors.primary
                                      : AppColors.buttonBackground,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.mainProjectItemModel.unitDetails.length,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloorPlansWidget(
                  unitDetail:
                      (widget.mainProjectItemModel.unitDetails[page])[index],
                ),
              );
            },
            itemCount: widget.mainProjectItemModel.unitDetails[page].length,
          ),
        )
      ],
    );
  }
}
