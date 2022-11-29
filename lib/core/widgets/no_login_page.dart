import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../config/routes/app_routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import '../utils/translate_text_method.dart';
import 'custom_button.dart';

class NotLoginPage extends StatelessWidget {
  const NotLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${translateText(AppStrings.shouldLoginText, context)} ....",
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Lottie.asset(ImageAssets.noLogin),
            const SizedBox(height: 80),
            CustomButton(
              text: translateText(AppStrings.loginText, context),
              paddingHorizontal: 80,
              color: AppColors.primary,
              onClick: () {
                Navigator.of(context).pushNamed(Routes.loginScreenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
