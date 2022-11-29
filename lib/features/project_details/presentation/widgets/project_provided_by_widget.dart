import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../home_page/domain/entities/main_project_item_domain_model.dart';

class ProjectProvidedByWidget extends StatelessWidget {
  const ProjectProvidedByWidget({Key? key, required this.mainProjectItemModel})
      : super(key: key);
  final MainProjectItem mainProjectItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: IsLanguage.isEnLanguage(context)
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Text(
              translateText(AppStrings.listingProvidedByText, context),
            ),
          ),
          const SizedBox(height: 16),
          CachedNetworkImage(
            imageUrl: mainProjectItemModel.user.image!,
            width: 60,
            height: 60,
            fit: BoxFit.fill,
            placeholder: (context, url) => CircularProgressIndicator(
              color: AppColors.primary2,
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              size: 64,
              color: AppColors.primary,
            ),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundColor: AppColors.primary2,
              backgroundImage: imageProvider,
            ),
          ),          const SizedBox(height: 16),
          Text(
            mainProjectItemModel.user.name!,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
