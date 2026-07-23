import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_providers.dart';
import '../providers/telegram_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final darkMode = ref.watch(darkModeProvider);
    final language = ref.watch(languageProvider);
    final isTelegramConnected = ref.watch(isTelegramConnectedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (settingsData) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: darkMode,
              onChanged: (value) => ref.read(updateSettingsProvider(
                settingsData.copyWith(isDarkMode: value),
              )),
            ),
            ListTile(
              title: const Text('Language'),
              trailing: DropdownButton<String>(
                value: language,
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                ],
                onChanged: (value) => ref.read(updateSettingsProvider(
                  settingsData.copyWith(languageCode: value ?? 'en'),
                )),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: settingsData.notificationsEnabled,
              onChanged: (value) => ref.read(updateSettingsProvider(
                settingsData.copyWith(notificationsEnabled: value),
              )),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Monitoring',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SwitchListTile(
              title: const Text('Background Monitoring'),
              value: settingsData.backgroundMonitoringEnabled,
              onChanged: (value) => ref.read(updateSettingsProvider(
                settingsData.copyWith(backgroundMonitoringEnabled: value),
              )),
            ),
            SwitchListTile(
              title: const Text('Auto Update'),
              value: settingsData.autoUpdateEnabled,
              onChanged: (value) => ref.read(updateSettingsProvider(
                settingsData.copyWith(autoUpdateEnabled: value),
              )),
            ),
            ListTile(
              title: const Text('Sync Interval'),
              subtitle: Text('${settingsData.syncIntervalMinutes} minutes'),
              trailing: DropdownButton<int>(
                value: settingsData.syncIntervalMinutes,
                items: const [
                  DropdownMenuItem(value: 5, child: Text('5 min')),
                  DropdownMenuItem(value: 15, child: Text('15 min')),
                  DropdownMenuItem(value: 30, child: Text('30 min')),
                  DropdownMenuItem(value: 60, child: Text('1 hour')),
                ],
                onChanged: (value) => ref.read(updateSettingsProvider(
                  settingsData.copyWith(syncIntervalMinutes: value ?? 15),
                )),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Account',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              title: const Text('Telegram Account'),
              subtitle: Text(isTelegramConnected ? 'Connected' : 'Disconnected'),
              trailing: isTelegramConnected
                  ? TextButton(
                      onPressed: () => ref.read(telegramLogoutProvider),
                      child: const Text('Logout'),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
