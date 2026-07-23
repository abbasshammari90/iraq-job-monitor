import '../../models/keyword_dto.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class KeywordRepository {
  final AppDatabase _database;

  KeywordRepository(this._database);

  Future<List<KeywordDTO>> getAllKeywords() async {
    final keywords = await _database.getAllKeywords();
    return keywords.map(_mapToDTO).toList();
  }

  Future<List<KeywordDTO>> getDefaultKeywords() async {
    final keywords = await _database.getDefaultKeywords();
    return keywords.map(_mapToDTO).toList();
  }

  Future<void> createKeyword(KeywordDTO keyword) async {
    await _database.insertKeyword(
      KeywordsTableCompanion(
        id: drift.Value(keyword.id),
        keyword: drift.Value(keyword.keyword),
        isDefault: drift.Value(keyword.isDefault),
        createdAt: drift.Value(keyword.createdAt),
      ),
    );
  }

  Future<void> deleteKeyword(String id) => _database.deleteKeyword(id);

  KeywordDTO _mapToDTO(KeywordsTableData keyword) {
    return KeywordDTO(
      id: keyword.id,
      keyword: keyword.keyword,
      isDefault: keyword.isDefault,
      createdAt: keyword.createdAt,
    );
  }
}
