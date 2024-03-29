import 'package:elwatn/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../add_project/presentation/cubit/add_project_cubit.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';
import '../../../map/presentation/screens/map_select_location.dart';
import '../cubit/add_ads_cubit.dart';

class SelectYourLocation extends StatelessWidget {
  const SelectYourLocation({Key? key, required this.kindOfSelected})
      : super(key: key);
  final String kindOfSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAdsCubit, AddAdsState>(builder: (context, state) {
      return BlocBuilder<AddProjectCubit, AddProjectState>(
          builder: (context, state) {
        return Column(
          children: [
            ListTileAllDetailsWidget(
              image: ImageAssets.locationGoldIcon,
              text: translateText(AppStrings.locationText, context),
              iconColor: AppColors.primary,
              isAddScreen: true,
            ),
            // context.read<AddAdsCubit>().longitude == 0
            //     ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 8),
                context.read<AddAdsCubit>().longitude == 0
                    ? Text(translateText(
                        AppStrings.selectYourLocationText, context))
                    : Icon(Icons.check, color: AppColors.primary),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SelectMapLocationScreen(
                            kindOfSelected: kindOfSelected);
                      }));
                    },
                    child: Image.asset(
                      ImageAssets.mapImage,
                      height: MediaQuery.of(context).size.width / 7,
                      width: MediaQuery.of(context).size.width / 7,
                    )),
                const SizedBox(width: 8),
              ],
            )
            // : Icon(Icons.check, color: AppColors.primary),
          ],
        );
      });
    });
  }
}
