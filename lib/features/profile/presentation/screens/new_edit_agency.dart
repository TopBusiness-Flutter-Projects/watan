import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/snackbar_method.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/new_edit_agent_body_widget.dart';

class NewAndEditAgencyScreen extends StatefulWidget {
  const NewAndEditAgencyScreen({Key? key}) : super(key: key);

  @override
  State<NewAndEditAgencyScreen> createState() => _NewAndEditAgencyScreenState();
}

class _NewAndEditAgencyScreenState extends State<NewAndEditAgencyScreen> {
  late ProfileCubit profileCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    profileCubit.image = null;
    profileCubit.imageLink = '';
    profileCubit.agentBtnText = '';
    profileCubit.nameController.clear();
    profileCubit.emailController.clear();
    profileCubit.passwordController.clear();
    profileCubit.phoneController.clear();
    profileCubit.whatsappController.clear();
    profileCubit.aboutController.clear();
    profileCubit.facebookController.clear();
    profileCubit.instaController.clear();
    profileCubit.twitterController.clear();
    profileCubit.snapController.clear();
  }

  @override
  Widget build(BuildContext context) {
    profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.agentText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileAddedAgentLoaded) {
            Future.delayed(const Duration(milliseconds: 700), () {
              snackBar("Agent Added Successfully", context,
                  color: AppColors.success);
              Navigator.pop(context);
            });
            return const ShowLoadingIndicator();
          }
          if (state is ProfileEditAgentLoaded) {
            Future.delayed(const Duration(milliseconds: 700), () {
              snackBar("Agent Edited Successfully", context,
                  color: AppColors.success);
              Navigator.pop(context);
              Navigator.pop(context);
            });
            return const ShowLoadingIndicator();
          }
          if (state is ProfileAddedAgentLoading ||
              state is ProfileEditAgentLoading) {
            return const ShowLoadingIndicator();
          } else if (state is ProfileAgentValidator) {
            context.read<ProfileCubit>().changeStatus(0);
            return NewEditAgentBodyWidget(status: "error");
          } else {
            return NewEditAgentBodyWidget(status: "new");
          }
        },
      ),
    );
  }
}
