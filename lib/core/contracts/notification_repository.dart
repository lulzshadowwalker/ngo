import 'package:ngo/models/notification.dart';

abstract interface class NotificationRepository {
  Future<List<Notification>> list(String accessToken);
  Future<Notification> find(String accessToken, String id);
  Future<List<Notification>> readAll(String accessToken);
  Future<Notification> read(String accessToken, String id);
  Future<void> destroy(String accessToken, String id);
  Future<void> destroyAll(String accessToken);
}
