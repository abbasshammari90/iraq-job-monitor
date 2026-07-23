import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/keyword_dto.dart';
import 'providers.dart';

final keywordsProvider = FutureProvider<List<KeywordDTO>>((ref) async {
  final keywordRepo = ref.watch(keywordRepositoryProvider);
  return keywordRepo.getAllKeywords();
});

final keywordCountProvider = FutureProvider<int>((ref) async {
  final keywords = await ref.watch(keywordsProvider.future);
  return keywords.length;
});

final addKeywordProvider = FutureProvider.family<void, String>((ref, keyword) async {
  final keywordRepo = ref.watch(keywordRepositoryProvider);
  await keywordRepo.addKeyword(keyword);
  ref.invalidate(keywordsProvider);
  ref.invalidate(keywordCountProvider);
});

final deleteKeywordProvider = FutureProvider.family<void, String>((ref, id) async {
  final keywordRepo = ref.watch(keywordRepositoryProvider);
  await keywordRepo.deleteKeyword(id);
  ref.invalidate(keywordsProvider);
  ref.invalidate(keywordCountProvider);
});
