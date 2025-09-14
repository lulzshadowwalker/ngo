part of 'notifications_cubit.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = _Initial;
  const factory NotificationsState.loading() = _Loading;
  const factory NotificationsState.loaded(List<Notification> notifications) =
      _Loaded;
  const factory NotificationsState.error(String message) = _Error;
}
