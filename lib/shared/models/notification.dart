import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

/// Notification model for LGU app
@JsonSerializable()
class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.readAt,
    this.actionUrl,
    this.actionText,
    this.metadata,
    this.userId,
    this.applicationId,
  });

  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  final DateTime? readAt;
  final String? actionUrl;
  final String? actionText;
  final Map<String, dynamic>? metadata;
  final String? userId;
  final String? applicationId;

  /// Is notification read
  bool get isRead => readAt != null;

  /// Is notification unread
  bool get isUnread => readAt == null;

  /// Time since creation
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? createdAt,
    DateTime? readAt,
    String? actionUrl,
    String? actionText,
    Map<String, dynamic>? metadata,
    String? userId,
    String? applicationId,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      actionUrl: actionUrl ?? this.actionUrl,
      actionText: actionText ?? this.actionText,
      metadata: metadata ?? this.metadata,
      userId: userId ?? this.userId,
      applicationId: applicationId ?? this.applicationId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppNotification && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AppNotification(id: $id, title: $title, type: $type, isRead: $isRead)';
  }
}

/// Notification type enum
enum NotificationType {
  @JsonValue('application_status')
  applicationStatus,
  @JsonValue('payment_reminder')
  paymentReminder,
  @JsonValue('document_ready')
  documentReady,
  @JsonValue('appointment')
  appointment,
  @JsonValue('announcement')
  announcement,
  @JsonValue('emergency_alert')
  emergencyAlert,
  @JsonValue('system')
  system,
}

/// Notification priority enum
enum NotificationPriority {
  @JsonValue('low')
  low,
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}
