import 'package:elwatn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListTileAllDetailsWidget extends StatelessWidget {
  ListTileAllDetailsWidget(
      {Key? key,
      required this.image,
      required this.text,
      this.iconColor = Colors.black,
      this.isAddScreen = false})
      : super(key: key);
  final String image;
  final String text;
  final bool? isAddScreen;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              image,
              width: 20,
              height: 20,
              color: iconColor,
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isAddScreen! ? text : text.split(':')[0],
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14, color: AppColors.color3),
                  ),
                ),
                !isAddScreen!
                    ? Expanded(
                        child: Text(
                          isAddScreen! ? text : text.split(':')[1],
                          textAlign: TextAlign.justify,
                          style:
                              TextStyle(fontSize: 13, color: AppColors.color3),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
