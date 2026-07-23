import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notification_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => ref.read(clearNotificationsProvider),
            child: const Text('Clear All'),
          ),
        ],
      ),
      body: notifications.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (notifs) => notifs.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No notifications',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: notifs.length,
                itemBuilder: (context, index) {
                  final notif = notifs[index];
                  return ListTile(
                    leading: Icon(
                      notif.type == 'new_job' ? Icons.work : Icons.info,
                      color: notif.isRead ? Colors.grey : Colors.blue,
                    ),
                    title: Text(notif.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notif.message),
                        const SizedBox(height: 4),
                        Text(
                          notif.createdAt.toString(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: !notif.isRead
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          )
                        : null,
                    onTap: () {
                      ref.read(markNotificationReadProvider(notif.id));
                    },
                  );
                },
              ),
      ),
    );
  }
}
