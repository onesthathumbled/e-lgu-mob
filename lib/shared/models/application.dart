import 'package:json_annotation/json_annotation.dart';

part 'application.g.dart';

/// Base application model for all LGU services
@JsonSerializable()
class Application {
  const Application({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.status,
    required this.submittedAt,
    this.processedAt,
    this.completedAt,
    this.notes,
    this.documents,
    this.fees,
    this.estimatedProcessingTime,
    this.actualProcessingTime,
  });

  final String id;
  final String userId;
  final String serviceType;
  final ApplicationStatus status;
  final DateTime submittedAt;
  final DateTime? processedAt;
  final DateTime? completedAt;
  final String? notes;
  final List<ApplicationDocument>? documents;
  final List<ApplicationFee>? fees;
  final int? estimatedProcessingTime; // in days
  final int? actualProcessingTime; // in days

  /// Total fees amount
  double get totalFees {
    if (fees == null || fees!.isEmpty) return 0.0;
    return fees!.fold(0.0, (sum, fee) => sum + fee.amount);
  }

  /// Is application pending
  bool get isPending => status == ApplicationStatus.pending;

  /// Is application approved
  bool get isApproved => status == ApplicationStatus.approved;

  /// Is application rejected
  bool get isRejected => status == ApplicationStatus.rejected;

  /// Is application completed
  bool get isCompleted => status == ApplicationStatus.completed;

  /// Processing time in days
  int? get processingTimeInDays {
    if (processedAt == null || completedAt == null) return null;
    return completedAt!.difference(processedAt!).inDays;
  }

  factory Application.fromJson(Map<String, dynamic> json) => _$ApplicationFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationToJson(this);

  Application copyWith({
    String? id,
    String? userId,
    String? serviceType,
    ApplicationStatus? status,
    DateTime? submittedAt,
    DateTime? processedAt,
    DateTime? completedAt,
    String? notes,
    List<ApplicationDocument>? documents,
    List<ApplicationFee>? fees,
    int? estimatedProcessingTime,
    int? actualProcessingTime,
  }) {
    return Application(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      serviceType: serviceType ?? this.serviceType,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
      processedAt: processedAt ?? this.processedAt,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
      documents: documents ?? this.documents,
      fees: fees ?? this.fees,
      estimatedProcessingTime: estimatedProcessingTime ?? this.estimatedProcessingTime,
      actualProcessingTime: actualProcessingTime ?? this.actualProcessingTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Application && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Application(id: $id, serviceType: $serviceType, status: $status)';
  }
}

/// Application status enum
enum ApplicationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('under_review')
  underReview,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

/// Application document model
@JsonSerializable()
class ApplicationDocument {
  const ApplicationDocument({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.uploadedAt,
    this.size,
    this.isRequired = false,
  });

  final String id;
  final String name;
  final String type;
  final String url;
  final DateTime uploadedAt;
  final int? size;
  final bool isRequired;

  /// File size in MB
  double? get sizeInMB {
    if (size == null) return null;
    return size! / (1024 * 1024);
  }

  factory ApplicationDocument.fromJson(Map<String, dynamic> json) => _$ApplicationDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationDocumentToJson(this);

  ApplicationDocument copyWith({
    String? id,
    String? name,
    String? type,
    String? url,
    DateTime? uploadedAt,
    int? size,
    bool? isRequired,
  }) {
    return ApplicationDocument(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      size: size ?? this.size,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApplicationDocument && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ApplicationDocument(id: $id, name: $name, type: $type)';
  }
}

/// Application fee model
@JsonSerializable()
class ApplicationFee {
  const ApplicationFee({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    this.description,
    this.isPaid = false,
    this.paidAt,
  });

  final String id;
  final String name;
  final double amount;
  final FeeType type;
  final String? description;
  final bool isPaid;
  final DateTime? paidAt;

  factory ApplicationFee.fromJson(Map<String, dynamic> json) => _$ApplicationFeeFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationFeeToJson(this);

  ApplicationFee copyWith({
    String? id,
    String? name,
    double? amount,
    FeeType? type,
    String? description,
    bool? isPaid,
    DateTime? paidAt,
  }) {
    return ApplicationFee(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      isPaid: isPaid ?? this.isPaid,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApplicationFee && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ApplicationFee(id: $id, name: $name, amount: $amount)';
  }
}

/// Fee type enum
enum FeeType {
  @JsonValue('application')
  application,
  @JsonValue('processing')
  processing,
  @JsonValue('penalty')
  penalty,
  @JsonValue('renewal')
  renewal,
  @JsonValue('amendment')
  amendment,
  @JsonValue('other')
  other,
}
