// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      actionUrl: json['actionUrl'] as String?,
      actionText: json['actionText'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      userId: json['userId'] as String?,
      applicationId: json['applicationId'] as String?,
    );

Map<String, dynamic> _$AppNotificationToJson(AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'actionUrl': instance.actionUrl,
      'actionText': instance.actionText,
      'metadata': instance.metadata,
      'userId': instance.userId,
      'applicationId': instance.applicationId,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.applicationStatus: 'application_status',
  NotificationType.paymentReminder: 'payment_reminder',
  NotificationType.documentReady: 'document_ready',
  NotificationType.appointment: 'appointment',
  NotificationType.announcement: 'announcement',
  NotificationType.emergencyAlert: 'emergency_alert',
  NotificationType.system: 'system',
};
