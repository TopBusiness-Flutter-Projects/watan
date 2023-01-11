import 'package:elwatn/config/routes/app_routes.dart';
import 'package:elwatn/core/utils/snackbar_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../login/data/models/login_data_model.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/body_profile.dart';
import '../widgets/header_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.loginDataModel}) : super(key: key);
  final LoginDataModel loginDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileUserDeletedError) {
          Future.delayed(const Duration(milliseconds: 500), () {
            snackBar("Errrrrrror", context);
          });
        }
        if (state is ProfileUserDeletedLoading) {
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loadingScreenWidgetRoute,
              (route) => false,
            );
          });
          Future.delayed(Duration(milliseconds: 700), () {
            Navigator.pop(context);
          });
          return const ShowLoadingIndicator();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              HeaderProfileWidget(loginDataModel: loginDataModel),
              const SizedBox(height: 30),
              BodyProfileWidget(loginDataModel: loginDataModel),
            ],
          ),
        );
      },
    );
  }
}
