import '../local/database/app_database.dart';

class JobDTO {
  final String id;
  final String company;
  final String title;
  final String location;
  final DateTime date;
  final String source;
  final String message;
  final double importanceScore;
  final String classification;
  final bool isFavorite;
  final DateTime createdAt;

  JobDTO({
    required this.id,
    required this.company,
    required this.title,
    required this.location,
    required this.date,
    required this.source,
    required this.message,
    required this.importanceScore,
    required this.classification,
    required this.isFavorite,
    required this.createdAt,
  });

  factory JobDTO.fromEntity(JobEntity entity) {
    return JobDTO(
      id: entity.id,
      company: entity.company,
      title: entity.title,
      location: entity.location,
      date: entity.date,
      source: entity.source,
      message: entity.message,
      importanceScore: entity.importanceScore,
      classification: entity.classification,
      isFavorite: entity.isFavorite,
      createdAt: entity.createdAt,
    );
  }
}
