import 'package:equatable/equatable.dart';

/// Notification entity
class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.readAt,
    this.actionUrl,
    this.data,
    this.priority = NotificationPriority.normal,
    this.category,
  });

  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final DateTime createdAt;
  final DateTime? readAt;
  final String? actionUrl;
  final Map<String, dynamic>? data;
  final NotificationPriority priority;
  final String? category;

  /// Is notification read
  bool get isRead => readAt != null;

  /// Is notification unread
  bool get isUnread => readAt == null;

  /// Is high priority notification
  bool get isHighPriority => priority == NotificationPriority.high;

  /// Is urgent notification
  bool get isUrgent => priority == NotificationPriority.urgent;

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        type,
        createdAt,
        readAt,
        actionUrl,
        data,
        priority,
        category,
      ];

  @override
  String toString() {
    return 'NotificationEntity(id: $id, title: $title, type: $type, isRead: $isRead)';
  }
}

/// Notification type enum
enum NotificationType {
  applicationStatus,
  paymentReminder,
  documentReady,
  appointment,
  announcement,
  emergencyAlert,
  systemUpdate,
  general,
}

/// Notification priority enum
enum NotificationPriority {
  low,
  normal,
  high,
  urgent,
}

/// Notification category enum
enum NotificationCategory {
  businessPermits,
  propertyTax,
  digitalId,
  civilRegistry,
  permits,
  socialPrograms,
  community,
  system,
  emergency,
}
