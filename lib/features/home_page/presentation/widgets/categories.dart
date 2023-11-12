import 'package:elwatn/features/show_lists/presentation/screens/show_lists_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/widgets/network_image.dart';
import '../../domain/entities/categories_domain_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key, required this.categoriesDatum})
      : super(key: key);
  final List<CategoriesDatum> categoriesDatum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: (MediaQuery.of(context).size.width / 5) - 70,
          ),
          itemCount: categoriesDatum.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowLists(
                          kind: IsLanguage.isEnLanguage(context)
                              ? categoriesDatum[index].nameEn!
                              : (IsLanguage.isArLanguage(context)
                                  ? categoriesDatum[index].nameAr!
                                  : categoriesDatum[index].nameKo!),
                          index: index),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowLists(
                          kind: IsLanguage.isEnLanguage(context)
                              ? categoriesDatum[index].nameEn!
                              : (IsLanguage.isArLanguage(context)
                                  ? categoriesDatum[index].nameAr!
                                  : categoriesDatum[index].nameKo!),
                          index: index),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowLists(
                          kind: IsLanguage.isEnLanguage(context)
                              ? categoriesDatum[index].nameEn!
                              : (IsLanguage.isArLanguage(context)
                                  ? categoriesDatum[index].nameAr!
                                  : categoriesDatum[index].nameKo!),
                          index: index),
                    ),
                  );
                }
              },
              child: Stack(
                children: [
                  categoriesDatum[index].image!.substring(
                              categoriesDatum[index].image!.length - 3) ==
                          "svg"
                      ? SvgPicture.network(
                          categoriesDatum[index].image!,
                          height: 80,
                          width: 80,
                        )
                      : Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: ManageNetworkImage(
                            imageUrl: categoriesDatum[index].image!,
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        textAlign: TextAlign.center,
                        IsLanguage.isEnLanguage(context)
                            ? categoriesDatum[index].nameEn!
                            : (IsLanguage.isArLanguage(context)
                                ? categoriesDatum[index].nameAr!
                                : categoriesDatum[index].nameKo!),
                        style: TextStyle(fontSize: 14, color: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
