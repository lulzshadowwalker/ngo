# Notifications System Usage

## Overview
The notifications system is now fully implemented with:
- NotificationsCubit for state management
- NotificationRepository interface
- LaravelNotificationRepository implementation
- NotificationsHome UI with real API integration

## Usage

### 1. Replace dummy tokens with real authentication
In `NotificationsHome`, replace `'dummy_token'` with actual user tokens:

```dart
// Get the actual token from your auth system
final authToken = await AuthService.getToken(); // Your auth implementation

// Use it in cubit calls
context.read<NotificationsCubit>().fetchNotifications(authToken);
```

### 2. Handle notification IDs properly
Currently using notification title as ID placeholder. Update to use actual notification IDs:

```dart
// In buildNotificationCard onTap
context.read<NotificationsCubit>().markAsRead(
  authToken,
  notification.id, // Use actual notification ID
);
```

### 3. Add notification model ID field
Update the Notification model to include an ID field:

```dart
@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    required String id, // Add this field
    required String title,
    required String message,
    // ... other fields
  }) = _Notification;
}
```

## API Endpoints
The system integrates with these Laravel endpoints:
- `GET /v1/notifications` - List all notifications
- `GET /v1/notifications/{id}` - Get specific notification
- `PATCH /v1/notifications/read` - Mark all as read
- `PATCH /v1/notifications/{id}/read` - Mark specific as read
- `DELETE /v1/notifications/{id}` - Delete specific notification
- `DELETE /v1/notifications` - Delete all notifications

## Features
- ✅ Load notifications from API
- ✅ Filter by All/Unread
- ✅ Mark individual notifications as read
- ✅ Mark all notifications as read
- ✅ Visual indicators for read/unread status
- ✅ Error handling and retry functionality
- ✅ Time formatting (e.g., "2 hours ago")
- ✅ Empty states for no notifications
