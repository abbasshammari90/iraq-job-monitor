import '../../local/database/app_database.dart';
import '../../models/job_dto.dart';

class JobRepository {
  final AppDatabase _database;

  JobRepository(this._database);

  Future<void> saveJob(JobDTO job) async {
    await _database.insertOrUpdateJob(
      JobEntityCompanion.insert(
        id: job.id,
        company: job.company,
        title: job.title,
        location: job.location,
        date: job.date,
        source: job.source,
        message: job.message,
        importanceScore: job.importanceScore,
        classification: job.classification,
        isFavorite: job.isFavorite,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> saveJobs(List<JobDTO> jobs) async {
    final companions = jobs.map((job) => JobEntityCompanion.insert(
      id: job.id,
      company: job.company,
      title: job.title,
      location: job.location,
      date: job.date,
      source: job.source,
      message: job.message,
      importanceScore: job.importanceScore,
      classification: job.classification,
      isFavorite: job.isFavorite,
      createdAt: DateTime.now(),
    )).toList();

    await _database.insertOrUpdateJobs(companions);
  }

  Future<List<JobDTO>> getAllJobs() async {
    final entities = await _database.getAllJobs();
    return entities.map((e) => JobDTO.fromEntity(e)).toList();
  }

  Future<List<JobDTO>> getJobsByClassification(String classification) async {
    final entities = await _database.getJobsByClassification(classification);
    return entities.map((e) => JobDTO.fromEntity(e)).toList();
  }

  Future<List<JobDTO>> searchJobs(String query) async {
    final entities = await _database.searchJobs(query);
    return entities.map((e) => JobDTO.fromEntity(e)).toList();
  }

  Future<List<JobDTO>> getTodayJobs() async {
    final now = DateTime.now();
    final allJobs = await getAllJobs();
    return allJobs
        .where((job) =>
            job.date.year == now.year &&
            job.date.month == now.month &&
            job.date.day == now.day)
        .toList();
  }

  Future<List<JobDTO>> getRelevantJobs() async {
    final veryRelevant =
        await getJobsByClassification('Very Relevant');
    final relevant =
        await getJobsByClassification('Relevant');
    return [...veryRelevant, ...relevant];
  }
}
