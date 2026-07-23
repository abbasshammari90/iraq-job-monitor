import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/job_providers.dart';
import '../providers/settings_providers.dart';
import '../providers/telegram_providers.dart';
import '../widgets/dashboard_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayJobs = ref.watch(todayJobsProvider);
    final relevantJobs = ref.watch(relevantJobsProvider);
    final groupCount = ref.watch(groupCountProvider);
    final keywordCount = ref.watch(keywordCountProvider);
    final isMonitoring = ref.watch(isMonitoringProvider);
    final lastSync = ref.watch(lastSyncProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iraq Job Monitor'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isMonitoring ? Colors.green.shade100 : Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isMonitoring ? Icons.check_circle : Icons.info,
                    color: isMonitoring ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isMonitoring ? 'Monitoring Active' : 'Monitoring Inactive',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (lastSync != null)
                          Text(
                            'Last sync: ${lastSync.toString().split('.')[0]}',
                            style: const TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Statistics
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                DashboardCard(
                  title: 'Today\'s Jobs',
                  future: todayJobs,
                  icon: Icons.work,
                ),
                DashboardCard(
                  title: 'Relevant Jobs',
                  future: relevantJobs,
                  icon: Icons.trending_up,
                ),
                DashboardCard(
                  title: 'Monitored Groups',
                  future: groupCount,
                  icon: Icons.groups,
                ),
                DashboardCard(
                  title: 'Keywords',
                  future: keywordCount,
                  icon: Icons.tag,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
