import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';

import 'package:elwatn/features/notification/domain/entities/notifications_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/base_notifications_repositories.dart';
import '../data_sources/notifcation_data_source.dart';

class NotificationRepositories extends BaseNotificationsRepositories {
  final BaseNotificationsDataSource baseNotificationsDataSource;

  NotificationRepositories(this.baseNotificationsDataSource);

  @override
  Future<Either<Failure, NotificationsModel>> getNotificationList(
      String token) async {
    try {
      final response =
          await baseNotificationsDataSource.listOfNotifications(token);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
