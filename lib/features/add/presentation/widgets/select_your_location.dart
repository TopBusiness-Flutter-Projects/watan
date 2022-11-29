import 'package:elwatn/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';
import '../../../map/presentation/screens/map_select_location.dart';

class SelectYourLocation extends StatelessWidget {
  const SelectYourLocation({Key? key, required this.kindOfSelected})
      : super(key: key);
  final String kindOfSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileAllDetailsWidget(
          image: ImageAssets.locationGoldIcon,
          text: translateText(AppStrings.locationText,context),
          iconColor: AppColors.primary,
          isAddScreen: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 8),
             Text(translateText(AppStrings.selectYourLocationText, context)),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectMapLocationScreen(
                        kindOfSelected: kindOfSelected,
                      );
                    },
                  ),
                );
              },
              child: Image.asset(
                ImageAssets.mapImage,
                height: 48,
                width: 48,
              ),
            ),
            const SizedBox(width: 8),
          ],
        )
      ],
    );
  }
}
