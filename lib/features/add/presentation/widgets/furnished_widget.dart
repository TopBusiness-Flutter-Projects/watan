import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/features/add/presentation/widgets/radio_choose.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';

class FurnishedWidget extends StatelessWidget {
  const FurnishedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileAllDetailsWidget(
          image: ImageAssets.areaIcon,
          isAddScreen: true,
          text: translateText(
            AppStrings.furnishedText,
            context,
          ),
        ),
        const SizedBox(height: 6),
        const RadioChooseWidget(),
      ],
    );
  }
}
