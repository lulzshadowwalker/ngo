import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ngo/features/notifications/cubit/notifications_cubit.dart';
import 'package:ngo/service_locator.dart';

class NotificationsHome extends HookWidget {
  const NotificationsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');

    Widget buildFilterChip(String label) {
      return GestureDetector(
        onTap: () {
          selectedFilter.value = label;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selectedFilter.value == label
                ? Colors.green
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selectedFilter.value == label ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget buildNotificationCard({
      required String title,
      required String subtitle,
      required String time,
      required bool isRead,
      required VoidCallback onTap,
    }) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: isRead ? Colors.grey[300] : Colors.green,
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: isRead ? Colors.grey : Colors.black87,
            ),
          ),
          trailing: Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          onTap: onTap,
        ),
      );
    }

    return BlocProvider(
      create: (context) => sl<NotificationsCubit>()..fetchNotifications(), // Replace with actual token
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<NotificationsCubit>().markAllAsRead(); // Replace with actual token
              },
              child: const Text(
                'Mark all as read',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildFilterChip('All'),
                  const SizedBox(width: 8),
                  buildFilterChip('Unread'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                    if (state.runtimeType.toString().contains('Initial')) {
                      return const Center(
                        child: Text('No notifications available'),
                      );
                    } else if (state.runtimeType.toString().contains('Loading')) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.runtimeType.toString().contains('Loaded')) {
                      final loadedState = state as dynamic;
                      final notifications = loadedState.notifications as List<dynamic>;

                      final filteredNotifications = selectedFilter.value == 'All'
                          ? notifications
                          : notifications.where((n) => !n.isRead).toList();

                      if (filteredNotifications.isEmpty) {
                        return Center(
                          child: Text(
                            selectedFilter.value == 'All'
                                ? 'No notifications'
                                : 'No unread notifications',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final notification = filteredNotifications[index];
                          return buildNotificationCard(
                            title: notification.title ?? 'No title',
                            subtitle: notification.message ?? 'No message',
                            time: _formatTime(notification.sentAt ?? DateTime.now()),
                            isRead: notification.isRead ?? false,
                            onTap: () {
                              if (!(notification.isRead ?? true)) {
                                // Mark as read when tapped
                                context.read<NotificationsCubit>().markAsRead(
                                  notification.id ?? '', // Replace with actual notification ID
                                );
                              }
                            },
                          );
                        },
                      );
                    } else if (state.runtimeType.toString().contains('Error')) {
                      final errorState = state as dynamic;
                      final message = errorState.message ?? 'Unknown error';

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error: $message'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<NotificationsCubit>()
                                  .fetchNotifications(), // Replace with actual token
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Unknown state'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
