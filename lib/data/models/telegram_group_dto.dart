class TelegramGroupDTO {
  final String id;
  final String name;
  final String username;
  final bool isChannel;
  final bool isActive;
  final DateTime addedAt;
  final int? memberCount;

  TelegramGroupDTO({
    required this.id,
    required this.name,
    required this.username,
    required this.isChannel,
    required this.isActive,
    required this.addedAt,
    this.memberCount,
  });

  TelegramGroupDTO copyWith({
    String? id,
    String? name,
    String? username,
    bool? isChannel,
    bool? isActive,
    DateTime? addedAt,
    int? memberCount,
  }) {
    return TelegramGroupDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      isChannel: isChannel ?? this.isChannel,
      isActive: isActive ?? this.isActive,
      addedAt: addedAt ?? this.addedAt,
      memberCount: memberCount ?? this.memberCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'isChannel': isChannel,
      'isActive': isActive,
      'addedAt': addedAt.toIso8601String(),
      'memberCount': memberCount,
    };
  }

  factory TelegramGroupDTO.fromJson(Map<String, dynamic> json) {
    return TelegramGroupDTO(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      isChannel: json['isChannel'] ?? false,
      isActive: json['isActive'] ?? true,
      addedAt: DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
      memberCount: json['memberCount'],
    );
  }
}
