// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceType: json['serviceType'] as String,
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      notes: json['notes'] as String?,
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => ApplicationDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      fees: (json['fees'] as List<dynamic>?)
          ?.map((e) => ApplicationFee.fromJson(e as Map<String, dynamic>))
          .toList(),
      estimatedProcessingTime:
          (json['estimatedProcessingTime'] as num?)?.toInt(),
      actualProcessingTime: (json['actualProcessingTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'serviceType': instance.serviceType,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'submittedAt': instance.submittedAt.toIso8601String(),
      'processedAt': instance.processedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'notes': instance.notes,
      'documents': instance.documents,
      'fees': instance.fees,
      'estimatedProcessingTime': instance.estimatedProcessingTime,
      'actualProcessingTime': instance.actualProcessingTime,
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 'pending',
  ApplicationStatus.underReview: 'under_review',
  ApplicationStatus.approved: 'approved',
  ApplicationStatus.rejected: 'rejected',
  ApplicationStatus.completed: 'completed',
  ApplicationStatus.cancelled: 'cancelled',
};

ApplicationDocument _$ApplicationDocumentFromJson(Map<String, dynamic> json) =>
    ApplicationDocument(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      size: (json['size'] as num?)?.toInt(),
      isRequired: json['isRequired'] as bool? ?? false,
    );

Map<String, dynamic> _$ApplicationDocumentToJson(
        ApplicationDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'url': instance.url,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'size': instance.size,
      'isRequired': instance.isRequired,
    };

ApplicationFee _$ApplicationFeeFromJson(Map<String, dynamic> json) =>
    ApplicationFee(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$FeeTypeEnumMap, json['type']),
      description: json['description'] as String?,
      isPaid: json['isPaid'] as bool? ?? false,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
    );

Map<String, dynamic> _$ApplicationFeeToJson(ApplicationFee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'type': _$FeeTypeEnumMap[instance.type]!,
      'description': instance.description,
      'isPaid': instance.isPaid,
      'paidAt': instance.paidAt?.toIso8601String(),
    };

const _$FeeTypeEnumMap = {
  FeeType.application: 'application',
  FeeType.processing: 'processing',
  FeeType.penalty: 'penalty',
  FeeType.renewal: 'renewal',
  FeeType.amendment: 'amendment',
  FeeType.other: 'other',
};
