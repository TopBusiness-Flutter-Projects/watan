import 'package:dio/dio.dart';
import 'package:elwatn/core/api/end_points.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../domain/entities/notifications_model.dart';

abstract class BaseNotificationsDataSource {
  Future<NotificationsModel> listOfNotifications(String token);
}

class NotificationsDataSource extends BaseNotificationsDataSource {
  final BaseApiConsumer apiConsumer;

  NotificationsDataSource(this.apiConsumer);

  @override
  Future<NotificationsModel> listOfNotifications(String token) async {
    final response = await apiConsumer.get(
      EndPoints.notificationsUrl,
      options: Options(
        headers: {"Authorization": token},
      ),
    );
    return NotificationsModel.fromJson(response);
  }
}
