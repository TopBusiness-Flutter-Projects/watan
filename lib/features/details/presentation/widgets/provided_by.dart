import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../home_page/domain/entities/main_item_domain_model.dart';

class ProvidedByWidget extends StatelessWidget {
  const ProvidedByWidget({Key? key, this.mainItemModel}) : super(key: key);
  final MainItem? mainItemModel;

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
            imageUrl: mainItemModel!.userModel!.image??'http://clipart-library.com/images/pT5ra4Xgc.jpg',
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
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on),
              Text(
                IsLanguage.isEnLanguage(context)
                    ? mainItemModel!.locationNameEn!
                    : (IsLanguage.isArLanguage(context)
                        ? mainItemModel!.locationNameAr!
                        : mainItemModel!.locationNameKu!),
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            mainItemModel!.userModel!.name??"noooooo",
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          
        ],
      ),
    );
  }
}
