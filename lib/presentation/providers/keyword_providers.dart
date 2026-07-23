import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/keyword_repository.dart';
import '../../data/models/keyword_dto.dart';
import '../../data/local/database/app_database.dart';

final keywordRepositoryProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return KeywordRepository(database);
});

final keywordsProvider = FutureProvider((ref) async {
  final repo = ref.watch(keywordRepositoryProvider);
  return repo.getAllKeywords();
});

final defaultKeywordsProvider = FutureProvider((ref) async {
  final repo = ref.watch(keywordRepositoryProvider);
  return repo.getDefaultKeywords();
});

final addKeywordProvider = FutureProvider.family<void, String>((ref, keyword) async {
  final repo = ref.watch(keywordRepositoryProvider);
  final newKeyword = KeywordDTO(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    keyword: keyword,
    isDefault: false,
    createdAt: DateTime.now(),
  );
  await repo.createKeyword(newKeyword);
  ref.invalidate(keywordsProvider);
});

final removeKeywordProvider = FutureProvider.family<void, String>((ref, keywordId) async {
  final repo = ref.watch(keywordRepositoryProvider);
  await repo.deleteKeyword(keywordId);
  ref.invalidate(keywordsProvider);
});

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
