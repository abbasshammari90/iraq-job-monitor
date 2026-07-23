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

  KeywordDTO copyWith({
    String? id,
    String? keyword,
    bool? isDefault,
    DateTime? createdAt,
  }) {
    return KeywordDTO(
      id: id ?? this.id,
      keyword: keyword ?? this.keyword,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'keyword': keyword,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory KeywordDTO.fromJson(Map<String, dynamic> json) {
    return KeywordDTO(
      id: json['id'] ?? '',
      keyword: json['keyword'] ?? '',
      isDefault: json['isDefault'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
