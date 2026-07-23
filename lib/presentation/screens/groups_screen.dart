import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/telegram_group_providers.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(telegramGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Telegram Groups'),
        elevation: 0,
      ),
      body: groups.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (groupList) => groupList.isEmpty
            ? const Center(child: Text('No groups added yet'))
            : ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (context, index) {
                  final group = groupList[index];
                  return ListTile(
                    leading: Icon(group.isChannel ? Icons.rss_feed : Icons.groups),
                    title: Text(group.name),
                    subtitle: Text(group.isChannel ? 'Channel' : 'Group'),
                    trailing: Icon(
                      group.isActive ? Icons.check_circle : Icons.cancel,
                      color: group.isActive ? Colors.green : Colors.grey,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
