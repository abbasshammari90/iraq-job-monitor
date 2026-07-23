import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/models/job_dto.dart';
import '../../data/local/database/app_database.dart';

final jobRepositoryProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return JobRepository(database);
});

final jobsProvider = FutureProvider((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getAllJobs();
});

final jobDetailProvider = FutureProvider.family<JobDTO?, String>((ref, jobId) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobById(jobId);
});

final favoriteJobsProvider = FutureProvider((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getFavoriteJobs();
});

final veryRelevantJobsProvider = FutureProvider((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobsByClassification('Very Relevant');
});

final relevantJobsProvider = FutureProvider((ref) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getJobsByClassification('Relevant');
});

final recentJobsProvider = FutureProvider.family<List<JobDTO>, int>((ref, days) async {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.getRecentJobs(days);
});

final toggleFavoriteJobProvider = FutureProvider.family<void, String>((ref, jobId) async {
  final repo = ref.watch(jobRepositoryProvider);
  final job = await repo.getJobById(jobId);
  if (job != null) {
    await repo.toggleFavorite(jobId, !job.isFavorite);
    ref.invalidate(jobsProvider);
    ref.invalidate(favoriteJobsProvider);
  }
});

final createJobProvider = FutureProvider.family<void, JobDTO>((ref, job) async {
  final repo = ref.watch(jobRepositoryProvider);
  await repo.createJob(job);
  ref.invalidate(jobsProvider);
});

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
