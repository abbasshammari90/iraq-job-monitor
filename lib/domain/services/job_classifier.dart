import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/job_dto.dart';
import '../../data/repositories/job_repository.dart';
import '../../core/constants/app_constants.dart';

class JobClassifier {
  final List<String> keywords;

  JobClassifier(this.keywords);

  String classifyJob(String messageText) {
    final lowerText = messageText.toLowerCase();
    final lowerKeywords = keywords.map((k) => k.toLowerCase()).toList();

    int exactMatches = 0;
    int partialMatches = 0;

    for (final keyword in lowerKeywords) {
      if (lowerText.contains(keyword)) {
        exactMatches++;
      } else if (_hasSemanticSimilarity(keyword, lowerText)) {
        partialMatches++;
      }
    }

    final totalMatches = exactMatches + (partialMatches ~/ 2);
    final textLength = messageText.split(' ').length;

    if (totalMatches >= 3) {
      return AppConstants.veryRelevant;
    } else if (totalMatches >= 2) {
      return AppConstants.relevant;
    } else if (totalMatches >= 1) {
      return AppConstants.possiblyRelevant;
    }

    return AppConstants.ignore;
  }

  double calculateImportanceScore(String classification, String messageText) {
    final baseScores = {
      AppConstants.veryRelevant: 1.0,
      AppConstants.relevant: 0.7,
      AppConstants.possiblyRelevant: 0.4,
      AppConstants.ignore: 0.0,
    };

    final baseScore = baseScores[classification] ?? 0.0;
    final hasLocation = _hasLocationKeywords(messageText);
    final hasSalary = _hasSalaryKeywords(messageText);

    double score = baseScore;
    if (hasLocation) score += 0.1;
    if (hasSalary) score += 0.15;

    return (score * 100).clamp(0.0, 100.0);
  }

  bool _hasSemanticSimilarity(String keyword, String text) {
    final keywordWords = keyword.split(' ');
    for (final word in keywordWords) {
      if (text.contains(word) && word.length > 3) {
        return true;
      }
    }
    return false;
  }

  bool _hasLocationKeywords(String text) {
    final locationKeywords = [
      'baghdad',
      'basra',
      'erbil',
      'sulaymaniyah',
      'kirkuk',
      'mosul',
      'najaf',
      'karbala',
      'diwaniyah',
      'hilla',
      'nasiriyah',
      'iraq',
      'iraqi'
    ];
    return locationKeywords
        .any((loc) => text.toLowerCase().contains(loc));
  }

  bool _hasSalaryKeywords(String text) {
    final salaryKeywords = [
      'salary',
      'wage',
      'compensation',
      'dinar',
      'usd',
      'rate',
      'package'
    ];
    return salaryKeywords
        .any((sal) => text.toLowerCase().contains(sal));
  }
}
