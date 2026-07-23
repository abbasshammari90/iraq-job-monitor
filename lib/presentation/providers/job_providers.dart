import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/job_dto.dart';
import 'providers.dart';

final jobsProvider = FutureProvider<List<JobDTO>>((ref) async {
  final jobRepo = ref.watch(jobRepositoryProvider);
  return jobRepo.getAllJobs();
});

final todayJobsProvider = FutureProvider<List<JobDTO>>((ref) async {
  final jobRepo = ref.watch(jobRepositoryProvider);
  return jobRepo.getTodayJobs();
});

final relevantJobsProvider = FutureProvider<List<JobDTO>>((ref) async {
  final jobRepo = ref.watch(jobRepositoryProvider);
  return jobRepo.getRelevantJobs();
});

final jobSearchProvider = FutureProvider.family<List<JobDTO>, String>((ref, query) async {
  if (query.isEmpty) {
    return [];
  }
  final jobRepo = ref.watch(jobRepositoryProvider);
  return jobRepo.searchJobs(query);
});

final jobCountProvider = FutureProvider<int>((ref) async {
  final jobs = await ref.watch(jobsProvider.future);
  return jobs.length;
});
