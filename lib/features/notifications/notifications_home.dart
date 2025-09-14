import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/notifications/cubit/notifications_cubit.dart';
import 'package:ngo/service_locator.dart';

class NotificationsHome extends HookWidget {
  const NotificationsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final lang = AppLocalizations.of(context)!;

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
              color: selectedFilter.value == label
                  ? Colors.white
                  : Colors.black,
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
            child: Icon(Icons.notifications, color: Colors.white, size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: isRead ? Colors.grey : Colors.black87),
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
      create: (context) => sl<NotificationsCubit>()..fetchNotifications(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
            title: Text(
              lang.notifications,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        buildFilterChip(lang.all_filter),
                        const SizedBox(width: 8),
                        buildFilterChip(lang.unread_filter),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<NotificationsCubit>().markAllAsRead();
                      },
                      child: Text(
                        lang.mark_all_as_read,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      if (state.runtimeType.toString().contains('Initial')) {
                        return Center(
                          child: Text(lang.no_notifications_available),
                        );
                      } else if (state.runtimeType.toString().contains(
                        'Loading',
                      )) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.runtimeType.toString().contains(
                        'Loaded',
                      )) {
                        final loadedState = state as dynamic;
                        final notifications =
                            loadedState.notifications as List<dynamic>;

                        final filteredNotifications =
                            selectedFilter.value == lang.all_filter
                            ? notifications
                            : notifications.where((n) => !n.isRead).toList();

                        if (filteredNotifications.isEmpty) {
                          return Center(
                            child: Text(
                              selectedFilter.value == lang.all_filter
                                  ? lang.no_notifications
                                  : lang.no_unread_notifications,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: filteredNotifications.length,
                          itemBuilder: (context, index) {
                            final notification = filteredNotifications[index];
                            return buildNotificationCard(
                              title: notification.title ?? lang.no_title,
                              subtitle: notification.message ?? lang.no_message,
                              time: _formatTime(
                                notification.sentAt ?? DateTime.now(),
                                lang,
                              ),
                              isRead: notification.isRead ?? false,
                              onTap: () {
                                if (!(notification.isRead ?? true)) {
                                  // Mark as read when tapped
                                  context.read<NotificationsCubit>().markAsRead(
                                    notification.id ?? '',
                                  );
                                }
                              },
                            );
                          },
                        );
                      } else if (state.runtimeType.toString().contains(
                        'Error',
                      )) {
                        final errorState = state as dynamic;
                        final message =
                            errorState.message ?? lang.unknown_error;

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error: $message'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<NotificationsCubit>()
                                    .fetchNotifications(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text(lang.unknown_state));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime, AppLocalizations lang) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return lang.just_now;
    }
  }
}
