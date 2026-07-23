class NotificationDTO {
  final String id;
  final String title;
  final String message;
  final String type; // 'new_job', 'status', 'alert'
  final bool isRead;
  final DateTime createdAt;
  final String? jobId;
  final Map<String, dynamic>? metadata;

  NotificationDTO({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.jobId,
    this.metadata,
  });

  NotificationDTO copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    String? jobId,
    Map<String, dynamic>? metadata,
  }) {
    return NotificationDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      jobId: jobId ?? this.jobId,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'jobId': jobId,
      'metadata': metadata,
    };
  }

  factory NotificationDTO.fromJson(Map<String, dynamic> json) {
    return NotificationDTO(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'status',
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      jobId: json['jobId'],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}
