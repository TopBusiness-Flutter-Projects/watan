import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/routes/app_routes.dart';
import '../utils/assets_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.openMyDrawer}) : super(key: key);

  final VoidCallback openMyDrawer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: openMyDrawer,
          icon: SvgPicture.asset(
            ImageAssets.menuIcon,
            width: 21,
            height: 21,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.mapScreenRoute);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.buttonBackground,
            ),
            child: Row(
              children: [
                Text(
                  translateText(AppStrings.mapText, context),
                  style: TextStyle(fontSize: 14, color: AppColors.primary),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.filterRoute);
          },
          child: SvgPicture.asset(
            ImageAssets.filterIcon,
          ),
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
