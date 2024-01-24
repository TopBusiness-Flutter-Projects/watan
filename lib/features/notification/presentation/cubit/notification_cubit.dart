import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/data/models/login_data_model.dart';
import '../../domain/entities/notifications_model.dart';
import '../../domain/use_cases/get_all_notification_use_case.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.getAllNotificationUseCase)
      : super(NotificationInitial()) {
    _getStoreUser().whenComplete(() => getAllNotification());
  }

  final GetAllNotificationUseCase getAllNotificationUseCase;

  LoginDataModel? loginDataModel;

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    }
  }

  getAllNotification() async {
    emit(NotificationListLoading());
    final response =
        await getAllNotificationUseCase(loginDataModel!.data!.accessToken!);
    response.fold(
      (failure) => emit(NotificationListError()),
      (notificationList) => emit(NotificationListLoaded(notificationList)),
    );
  }
}
