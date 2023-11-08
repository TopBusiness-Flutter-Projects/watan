import 'package:elwatn/features/home_page/presentation/widgets/home_item.dart';
import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../show_more_posts/presentation/screens/show_more.dart';
import '../../data/models/slider_data_model.dart';
import '../../domain/entities/new_popular_domain_model.dart';
import '../../domain/entities/slider_domain_model.dart';

class HomeModelWidget extends StatelessWidget {
  const HomeModelWidget(
      {Key? key,
      required this.kind,
      required this.mainItem,
      required this.slider})
      : super(key: key);

  final String kind;
  final NewPopularData mainItem;
  final List<DatumModel> slider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Align(
              alignment: AppLocalizations.of(context)!.isEnLocale
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                kind,
                style: TextStyle(fontSize: 18, color: AppColors.primary),
              )),
        ),
        if (kind ==
            AppLocalizations.of(context)!
                .translate(AppStrings.popularTitle)!) ...{
          ...List.generate(
            mainItem.popular!.length,
            (index) => HomeItemWidget(
              mainItem: mainItem.popular![index],
            ),
          )
        } else ...{
          ...List.generate(
            mainItem.dataNew!.length,
            (index) => HomeItemWidget(
              mainItem: mainItem.dataNew![index],
            ),
          )
        },
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ShowMoreScreen(
                  kind: kind,
                  sliderList: slider,
                );
              },
            ));
          },
          style: ElevatedButton.styleFrom(
              maximumSize: Size.infinite,
              minimumSize: const Size(300, 46),
              side: BorderSide.none,
              backgroundColor: AppColors.buttonBackground),
          child: Text(
            AppLocalizations.of(context)!.translate(AppStrings.viewMoreText)!,
          ),
        ),
        const SizedBox(height: 35)
      ],
    );
  }
}
