import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/local/database/app_database.dart';

class JobsStatsModel {
  final int totalJobs;
  final int thisWeek;
  final int relevantCount;
  final int veryRelevantCount;

  JobsStatsModel({
    required this.totalJobs,
    required this.thisWeek,
    required this.relevantCount,
    required this.veryRelevantCount,
  });
}

final jobRepositoryProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return JobRepository(database);
});

final jobsStatsProvider = FutureProvider((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  final allJobs = await repo.getAllJobs();
  final recentJobs = await repo.getRecentJobs(7);
  final relevant = await repo.getJobsByClassification('Relevant');
  final veryRelevant = await repo.getJobsByClassification('Very Relevant');

  return JobsStatsModel(
    totalJobs: allJobs.length,
    thisWeek: recentJobs.length,
    relevantCount: relevant.length,
    veryRelevantCount: veryRelevant.length,
  );
});

final classificationStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  final allJobs = await repo.getAllJobs();
  final stats = <String, int>{};

  for (final job in allJobs) {
    stats[job.classification] = (stats[job.classification] ?? 0) + 1;
  }

  return stats;
});

final keywordStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  final allJobs = await repo.getAllJobs();
  final stats = <String, int>{};

  for (final job in allJobs) {
    for (final keyword in job.matchedKeywords) {
      stats[keyword] = (stats[keyword] ?? 0) + 1;
    }
  }

  return stats..entries.toList()..sort((a, b) => b.value.compareTo(a.value));
});

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
