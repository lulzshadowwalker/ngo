import '../../models/notification.dart';
import '../contracts/notification_repository.dart';
import 'laravel_repository.dart';


final class LaravelNotificationRepository extends LaravelRepository
    implements NotificationRepository {
  @override
  Future<List<Notification>> list(String accessToken) async {
    final response = await get(
      '/v1/notifications',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as List;
    return data
        .map((item) => Notification.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Notification> find(String accessToken, String id) async {
    final response = await get(
      '/v1/notifications/$id',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return Notification.fromLaravel(data);
  }

  @override
  Future<List<Notification>> readAll(String accessToken) async {
    final response = await patch(
      '/v1/notifications/read',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as List;
    return data
        .map((item) => Notification.fromLaravel(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Notification> read(String accessToken, String id) async {
    final response = await patch(
      '/v1/notifications/$id/read',
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final data = response['data'] as Map<String, dynamic>;
    return Notification.fromLaravel(data);
  }

  @override
  Future<void> destroy(String accessToken, String id) async {
    await delete(
      '/v1/notifications/$id',
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  @override
  Future<void> destroyAll(String accessToken) async {
    await delete(
      '/v1/notifications',
      headers: {'Authorization': 'Bearer $accessToken'},
    );
  }

  
}
