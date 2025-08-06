import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    }) {
      return ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return Scaffold(
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
              // Handle mark all as read
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
              child: ListView(
                children: [
                  buildNotificationCard(
                    title: 'Jordan Youth NGO',
                    subtitle:
                        'accepted your application for "Community Service Day"',
                    time: '2 hours ago',
                  ),
                  buildNotificationCard(
                    title: 'Amman Volunteers',
                    subtitle: 'is now following you',
                    time: '3 hours ago',
                  ),
                  buildNotificationCard(
                    title: 'Beach Cleanup Event',
                    subtitle: 'Please rate your experience with this event',
                    time: '5 hours ago',
                  ),
                  buildNotificationCard(
                    title: 'Education Initiative',
                    subtitle: 'Your application is under review',
                    time: '1 day ago',
                  ),
                  buildNotificationCard(
                    title: 'Environmental Society',
                    subtitle: 'has posted a new volunteer opportunity',
                    time: '1 day ago',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
