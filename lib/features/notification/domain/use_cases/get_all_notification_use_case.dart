import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notifications_model.dart';
import '../repositories/base_notifications_repositories.dart';

class GetAllNotificationUseCase implements UseCase<NotificationsModel, String> {
  const GetAllNotificationUseCase({required this.baseNotificationsRepositories});

  final BaseNotificationsRepositories baseNotificationsRepositories;

  @override
  Future<Either<Failure, NotificationsModel>> call(String params) =>
      baseNotificationsRepositories.getNotificationList(params);
}
