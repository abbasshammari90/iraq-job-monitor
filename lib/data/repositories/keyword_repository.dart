import '../../local/database/app_database.dart';
import '../../models/keyword_dto.dart';
import '../../core/constants/app_constants.dart';

class KeywordRepository {
  final AppDatabase _database;

  KeywordRepository(this._database);

  Future<void> initializeDefaultKeywords() async {
    final existing = await getAllKeywords();
    if (existing.isEmpty) {
      for (final keyword in AppConstants.defaultKeywords) {
        await addKeyword(keyword, isDefault: true);
      }
    }
  }

  Future<void> addKeyword(String keyword, {bool isDefault = false}) async {
    await _database.insertKeyword(
      KeywordEntityCompanion.insert(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        keyword: keyword,
        isDefault: isDefault,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<KeywordDTO>> getAllKeywords() async {
    final entities = await _database.getAllKeywords();
    return entities.map((e) => KeywordDTO.fromEntity(e)).toList();
  }

  Future<void> deleteKeyword(String id) => _database.deleteKeyword(id);

  Future<List<String>> getKeywordStrings() async {
    final keywords = await getAllKeywords();
    return keywords.map((k) => k.keyword).toList();
  }
}
