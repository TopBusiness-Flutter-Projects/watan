import 'package:elwatn/core/utils/app_colors.dart';
import 'package:elwatn/core/utils/is_language_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/convert_numbers_method.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../details/presentation/widgets/list_tile_all_details.dart';
import '../cubit/add_project_cubit.dart';

class PaymentPlanesWidget extends StatefulWidget {
  const PaymentPlanesWidget({Key? key}) : super(key: key);

  @override
  State<PaymentPlanesWidget> createState() => _PaymentPlanesWidgetState();
}

class _PaymentPlanesWidgetState extends State<PaymentPlanesWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ListTileAllDetailsWidget(
            image: ImageAssets.priceIcon,
            text: translateText(AppStrings.paymentPlanText, context),
            iconColor: AppColors.primary,
            isAddScreen: true,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: CustomTextField(
                  image: "null",
                  title: translateText(AppStrings.planTitleHint, context),
                  controller:
                      context.read<AddProjectCubit>().paymentTitleController,
                  textInputType: TextInputType.text,
                  validatorMessage:
                      translateText(AppStrings.planTitleValidator, context),
                ),
              ),
              Expanded(
                flex: 3,
                child: CustomTextField(
                  image: "null",
                  title: translateText(AppStrings.percentHint, context),
                  textInputType: TextInputType.number,
                  controller:
                      context.read<AddProjectCubit>().paymentPresentController,
                  validatorMessage:
                      translateText(AppStrings.percentValidator, context),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  side: BorderSide(width: 2.0, color: AppColors.primary),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      context.read<AddProjectCubit>().addPaymentPlans();
                    });
                  }
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.primary,
                ),
              )
            ],
          ),
          context.read<AddProjectCubit>().paymentPlanPresent.isEmpty
              ? const SizedBox()
              : Column(
                  children: [
                    ...List.generate(
                      context.read<AddProjectCubit>().paymentPlanPresent.length,
                      (index) => Column(
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Text(!IsLanguage.isEnLanguage(context)
                                  ? replaceToArabicNumber(context
                                      .read<AddProjectCubit>()
                                      .paymentPlanPresent[index])+' %'
                                  : "${context.read<AddProjectCubit>().paymentPlanPresent[index]} %"),
                              const SizedBox(
                                width: 80,
                              ),
                              Text(context
                                  .read<AddProjectCubit>()
                                  .paymentPlanTitle[index]),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    context
                                        .read<AddProjectCubit>()
                                        .removePaymentPlans(index);
                                  });
                                },
                                child: Icon(
                                  Icons.remove_circle,
                                  color: AppColors.error,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
