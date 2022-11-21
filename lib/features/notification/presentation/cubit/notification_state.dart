part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationListLoading extends NotificationState {}
class NotificationListLoaded extends NotificationState {
  final NotificationsModel notificationsModel;

  NotificationListLoaded(this.notificationsModel);
}
class NotificationListError extends NotificationState {}
