import '../../../../core/network/dio_client.dart';
import '../models/notification_models.dart';

class NotificationRepository {
  final DioClient _dioClient;

  NotificationRepository(this._dioClient);

  Future<List<NotificationItem>> listNotifications() async {
    final response = await _dioClient.dio.get('/notifications');
    return (response.data as List)
        .map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> markAsRead(String id) async {
    await _dioClient.dio.put('/notifications/$id/read');
  }

  Future<int> getUnreadCount() async {
    final response = await _dioClient.dio.get('/notifications/unread-count');
    return response.data['count'] as int;
  }
}
