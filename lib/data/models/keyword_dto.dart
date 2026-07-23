import '../local/database/app_database.dart';

class KeywordDTO {
  final String id;
  final String keyword;
  final bool isDefault;
  final DateTime createdAt;

  KeywordDTO({
    required this.id,
    required this.keyword,
    required this.isDefault,
    required this.createdAt,
  });

  factory KeywordDTO.fromEntity(KeywordEntity entity) {
    return KeywordDTO(
      id: entity.id,
      keyword: entity.keyword,
      isDefault: entity.isDefault,
      createdAt: entity.createdAt,
    );
  }
}
