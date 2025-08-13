import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    required String title,
    required String message,
    required Map<String, dynamic>? data,
    required DateTime? readAt,
    required bool isRead,
    required DateTime sentAt,
  }) = _Notification;

  factory Notification.fromLaravel(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    
    return Notification(
      title: attributes['title'] as String? ?? '',
      message: attributes['message'] as String? ?? '',
      data: attributes['data'] as Map<String, dynamic>?,
      readAt: attributes['readAt'] != null
          ? DateTime.parse(attributes['readAt'] as String).toUtc()
          : null,
      isRead: attributes['isRead'] as bool? ?? false,
      sentAt: DateTime.parse(attributes['sentAt'] as String).toUtc(),
    );
  }
}
