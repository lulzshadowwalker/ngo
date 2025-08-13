import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/notification_repository.dart';
import 'package:ngo/core/helpers/helper.dart';
import 'package:ngo/models/notification.dart';

part 'notifications_cubit.freezed.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepository _repository;

  NotificationsCubit(this._repository) : super(const NotificationsState.initial());

  Future<void> fetchNotifications() async {
    final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      emit(const NotificationsState.loading());
      
      final notifications = await _repository.list(accessToken);
      
      emit(NotificationsState.loaded(notifications));
    } catch (error) {
      emit(NotificationsState.error(error.toString()));
    }
  }

  Future<void> markAllAsRead() async {
        final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      await _repository.readAll(accessToken);
      
      // Refresh the notifications list
      await fetchNotifications();
    } catch (error) {
      emit(NotificationsState.error('Failed to mark all as read: ${error.toString()}'));
    }
  }

  Future<void> markAsRead(String notificationId) async {
         final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      await _repository.read(accessToken, notificationId);
      
      // Refresh the notifications list
      await fetchNotifications();
    } catch (error) {
      emit(NotificationsState.error('Failed to mark as read: ${error.toString()}'));
    }
  }

  Future<void> deleteNotification( String notificationId) async {
         final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      await _repository.destroy(accessToken, notificationId);
      
      // Refresh the notifications list
      await fetchNotifications();
    } catch (error) {
      emit(NotificationsState.error('Failed to delete notification: ${error.toString()}'));
    }
  }

  Future<void> deleteAllNotifications() async {
         final accessToken = await SharedPrefHelper.getAccessToken();
    try {
      await _repository.destroyAll(accessToken);
      
      // Refresh the notifications list
      await fetchNotifications();
    } catch (error) {
      emit(NotificationsState.error('Failed to delete all notifications: ${error.toString()}'));
    }
  }
}
