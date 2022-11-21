import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/notifications_model.dart';

abstract class BaseNotificationsRepositories{
  Future<Either<Failure, NotificationsModel>> getNotificationList(String token);
}