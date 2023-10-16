import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/convert_numbers_method.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/profile/presentation/cubit/profile_cubit.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.image,
    required this.title,
    required this.textInputType,
    this.minLine = 1,
    this.isPassword = false,
    this.validatorMessage = '',
    this.isNum = false,
    this.isAgent = false,
    this.controller,
    this.imageColor = Colors.grey,
  }) : super(key: key);
  final String image;
  final Color imageColor;
  final String title;
  final String validatorMessage;
  final int minLine;
  final bool isPassword;
  final bool isNum;
  final bool isAgent;
  final TextInputType textInputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        children: [
          image != "null"
              ? Row(
                  children: [
                    SvgPicture.asset(
                      image,
                      color: imageColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
              : const SizedBox(width: 0),
          image != "null"
              ? const SizedBox(height: 6)
              : const SizedBox(width: 0),
          Directionality(
            textDirection: isNum
                ? TextDirection.ltr
                : IsLanguage.isEnLanguage(context)
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child: TextFormField(
              controller: controller,
              keyboardType: textInputType,
              inputFormatters: textInputType == TextInputType.number
                  ? [ThousandsSeparatorInputFormatter()]
                  : [],
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: isNum
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Text(
                          IsLanguage.isEnLanguage(context)
                              ? "+20"
                              : "+ ${replaceToArabicNumber("20")}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : null,
                hintText: title,
                border: image != "null"
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                fillColor: AppColors.scaffoldBackground,
                filled: true,
              ),
              maxLines: isPassword ? 1 : 20,
              minLines: minLine,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validatorMessage;
                } else if (isAgent) {
                  if (context.read<ProfileCubit>().statusCode == 422) {
                    return validatorMessage;
                  }
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
