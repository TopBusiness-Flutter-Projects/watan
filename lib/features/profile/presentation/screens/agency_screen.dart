import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:elwatn/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/snackbar_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/agency_item.dart';

class AgencyScreen extends StatefulWidget {
  const AgencyScreen({Key? key}) : super(key: key);

  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getStoreUser().then(
          (value) => value.data!.user!.userType != 1
              ? value.data!.accessToken != null
                  ? context
                      .read<ProfileCubit>()
                      .getAgentList(value.data!.accessToken!)
                  : null
              : null,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            title: Text(translateText(AppStrings.agencyText, context),
                style: TextStyle(color: AppColors.black)),
            iconTheme: IconThemeData(color: AppColors.black)),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProfileAgentDeletedSuccessfully) {
              Future.delayed(const Duration(seconds: 2), () {
                snackBar(
                    translateText(
                        AppStrings.deleteSuccessfullyMessage, context),
                    context,
                    color: AppColors.success);
              });
            }
            if (state is ProfileAgentError) {
              return error_widget.ErrorWidget(
                onPressed: () => context.read<ProfileCubit>().getAgentList(
                    context
                        .read<ProfileCubit>()
                        .loginDataModel
                        .data!
                        .accessToken!),
              );
            } else if (state is ProfileAgentLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileCubit>().getAgentList(
                        context
                            .read<ProfileCubit>()
                            .loginDataModel
                            .data!
                            .accessToken!,
                      );
                },
                child: Stack(
                  children: [
                    state.agentProfileList.data!.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary))
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 70),
                            child: ListView.builder(
                              itemCount: state.agentProfileList.data!.length,
                              itemBuilder: (context, index) => AgencyItem(
                                agentModel: state.agentProfileList.data![index],
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CustomButton(
                        paddingHorizontal: 65,
                        text: translateText(AppStrings.addAgencyBtn, context),
                        color: AppColors.primary,
                        onClick: () {
                          print('aaaa');
                          Navigator.pushNamed(
                            context,
                            Routes.newAndEditAgencyScreenRoute,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const ShowLoadingIndicator();
            }
          },
        ));
  }
}
