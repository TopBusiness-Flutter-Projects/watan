import 'package:elwatn/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LongText extends StatelessWidget {
  const LongText({Key? key, required this.text}) : super(key: key);
final String text;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:
      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        style:  TextStyle(fontSize: 12,color: AppColors.gray),
      ),
    );

  }
}
