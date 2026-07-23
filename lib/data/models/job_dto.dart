class JobDTO {
  final String id;
  final String title;
  final String company;
  final String location;
  final DateTime date;
  final String description;
  final String classification;
  final double importanceScore;
  final String source;
  final List<String> matchedKeywords;
  final bool isFavorite;
  final bool isSeen;

  JobDTO({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.date,
    required this.description,
    required this.classification,
    required this.importanceScore,
    required this.source,
    required this.matchedKeywords,
    this.isFavorite = false,
    this.isSeen = false,
  });

  JobDTO copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    DateTime? date,
    String? description,
    String? classification,
    double? importanceScore,
    String? source,
    List<String>? matchedKeywords,
    bool? isFavorite,
    bool? isSeen,
  }) {
    return JobDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      date: date ?? this.date,
      description: description ?? this.description,
      classification: classification ?? this.classification,
      importanceScore: importanceScore ?? this.importanceScore,
      source: source ?? this.source,
      matchedKeywords: matchedKeywords ?? this.matchedKeywords,
      isFavorite: isFavorite ?? this.isFavorite,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'date': date.toIso8601String(),
      'description': description,
      'classification': classification,
      'importanceScore': importanceScore,
      'source': source,
      'matchedKeywords': matchedKeywords,
      'isFavorite': isFavorite,
      'isSeen': isSeen,
    };
  }

  factory JobDTO.fromJson(Map<String, dynamic> json) {
    return JobDTO(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      description: json['description'] ?? '',
      classification: json['classification'] ?? 'Ignore',
      importanceScore: (json['importanceScore'] ?? 0).toDouble(),
      source: json['source'] ?? '',
      matchedKeywords: List<String>.from(json['matchedKeywords'] ?? []),
      isFavorite: json['isFavorite'] ?? false,
      isSeen: json['isSeen'] ?? false,
    );
  }
}
