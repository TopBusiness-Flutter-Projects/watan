import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import 'package:elwatn/core/widgets/error_widget.dart' as error_widget;
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/notification_cubit.dart';
import '../widgets/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          translateText(AppStrings.notificationText, context),
          style: TextStyle(color: AppColors.black),
        ),
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        actions: [Image.asset(ImageAssets.logoIcon)],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationListLoading) {
            return ShowLoadingIndicator();
          } else if (state is NotificationListLoaded) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<NotificationCubit>().getAllNotification(),
              child: SingleChildScrollView(
                child:     state.notificationsModel.data!.length>0?Column(
                  children: [
                    ...List.generate(
                      state.notificationsModel.data!.length,
                      (index) => NotificationModelWidget(
                        notificationsDatum:
                            state.notificationsModel.data![index],
                      ),
                    ),
                    if(state.notificationsModel.data!.length<4)...{
                      Container(height: 800)
                    }
                  ],
                ):    Center(
                  child: Text(translateText("no_data", context),
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          } else {
            return error_widget.ErrorWidget(
              onPressed: () =>
                  context.read<NotificationCubit>().getAllNotification(),
            );
          }
        },
      ),
    );
  }
}
