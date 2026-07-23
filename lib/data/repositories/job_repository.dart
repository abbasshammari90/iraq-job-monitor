import '../../models/job_dto.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class JobRepository {
  final AppDatabase _database;

  JobRepository(this._database);

  Future<List<JobDTO>> getAllJobs() async {
    final jobs = await _database.getAllJobs();
    return jobs.map(_mapToDTO).toList();
  }

  Future<List<JobDTO>> getJobsByClassification(String classification) async {
    final jobs = await _database.getJobsByClassification(classification);
    return jobs.map(_mapToDTO).toList();
  }

  Future<List<JobDTO>> getFavoriteJobs() async {
    final jobs = await _database.getFavoriteJobs();
    return jobs.map(_mapToDTO).toList();
  }

  Future<List<JobDTO>> getRecentJobs(int days) async {
    final jobs = await _database.getRecentJobs(days);
    return jobs.map(_mapToDTO).toList();
  }

  Future<JobDTO?> getJobById(String id) async {
    final jobs = await _database.getAllJobs();
    final job = jobs.firstWhere((j) => j.id == id, orElse: () => null as dynamic);
    return job != null ? _mapToDTO(job) : null;
  }

  Future<void> createJob(JobDTO job) async {
    await _database.insertJob(
      JobsTableCompanion(
        id: drift.Value(job.id),
        title: drift.Value(job.title),
        company: drift.Value(job.company),
        location: drift.Value(job.location),
        date: drift.Value(job.date),
        description: drift.Value(job.description),
        classification: drift.Value(job.classification),
        importanceScore: drift.Value(job.importanceScore),
        source: drift.Value(job.source),
        matchedKeywords: drift.Value(job.matchedKeywords.join(',')),
        isFavorite: drift.Value(job.isFavorite),
        isSeen: drift.Value(job.isSeen),
      ),
    );
  }

  Future<void> updateJob(JobDTO job) async {
    await _database.updateJob(
      JobsTableCompanion(
        id: drift.Value(job.id),
        title: drift.Value(job.title),
        company: drift.Value(job.company),
        location: drift.Value(job.location),
        date: drift.Value(job.date),
        description: drift.Value(job.description),
        classification: drift.Value(job.classification),
        importanceScore: drift.Value(job.importanceScore),
        source: drift.Value(job.source),
        matchedKeywords: drift.Value(job.matchedKeywords.join(',')),
        isFavorite: drift.Value(job.isFavorite),
        isSeen: drift.Value(job.isSeen),
      ),
    );
  }

  Future<void> deleteJob(String id) => _database.deleteJob(id);

  Future<void> toggleFavorite(String id, bool favorite) =>
      _database.toggleFavorite(id, favorite);

  JobDTO _mapToDTO(JobsTableData job) {
    return JobDTO(
      id: job.id,
      title: job.title,
      company: job.company,
      location: job.location,
      date: job.date,
      description: job.description,
      classification: job.classification,
      importanceScore: job.importanceScore,
      source: job.source,
      matchedKeywords: job.matchedKeywords.isNotEmpty
          ? job.matchedKeywords.split(',')
          : [],
      isFavorite: job.isFavorite,
      isSeen: job.isSeen,
    );
  }
}
