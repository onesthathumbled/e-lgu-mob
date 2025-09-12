import 'package:equatable/equatable.dart';

/// Permit entity
class PermitEntity extends Equatable {
  const PermitEntity({
    required this.id,
    required this.userId,
    required this.permitType,
    required this.businessName,
    required this.businessAddress,
    required this.ownerName,
    required this.contactNumber,
    required this.email,
    required this.businessDescription,
    required this.status,
    required this.submittedAt,
    this.processedAt,
    this.completedAt,
    this.scheduledInspectionDate,
    this.inspectionNotes,
    this.notes,
    this.documents,
    this.fees,
    this.estimatedProcessingTime,
    this.actualProcessingTime,
  });

  final String id;
  final String userId;
  final PermitType permitType;
  final String businessName;
  final String businessAddress;
  final String ownerName;
  final String contactNumber;
  final String email;
  final String businessDescription;
  final PermitStatus status;
  final DateTime submittedAt;
  final DateTime? processedAt;
  final DateTime? completedAt;
  final DateTime? scheduledInspectionDate;
  final String? inspectionNotes;
  final String? notes;
  final List<PermitDocumentEntity>? documents;
  final List<PermitFeeEntity>? fees;
  final int? estimatedProcessingTime; // in days
  final int? actualProcessingTime; // in days

  /// Total fees amount
  double get totalFees {
    if (fees == null || fees!.isEmpty) return 0.0;
    return fees!.fold(0.0, (sum, fee) => sum + fee.amount);
  }

  /// Is application pending
  bool get isPending => status == PermitStatus.pending;

  /// Is application approved
  bool get isApproved => status == PermitStatus.approved;

  /// Is application rejected
  bool get isRejected => status == PermitStatus.rejected;

  /// Is application completed
  bool get isCompleted => status == PermitStatus.completed;

  /// Processing time in days
  int? get processingTimeInDays {
    if (processedAt == null || completedAt == null) return null;
    return completedAt!.difference(processedAt!).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        permitType,
        businessName,
        businessAddress,
        ownerName,
        contactNumber,
        email,
        businessDescription,
        status,
        submittedAt,
        processedAt,
        completedAt,
        scheduledInspectionDate,
        inspectionNotes,
        notes,
        documents,
        fees,
        estimatedProcessingTime,
        actualProcessingTime,
      ];

  @override
  String toString() {
    return 'PermitEntity(id: $id, permitType: $permitType, status: $status)';
  }
}

/// Permit type enum
enum PermitType {
  healthPermit,
  workPermit,
  sanitationPermit,
  buildingPermit,
  businessPermit,
  other,
}

/// Permit status enum
enum PermitStatus {
  pending,
  underReview,
  inspectionScheduled,
  inspectionCompleted,
  approved,
  rejected,
  completed,
  cancelled,
}

/// Permit document entity
class PermitDocumentEntity extends Equatable {
  const PermitDocumentEntity({
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

  @override
  List<Object?> get props => [id, name, type, url, uploadedAt, size, isRequired];

  @override
  String toString() {
    return 'PermitDocumentEntity(id: $id, name: $name, type: $type)';
  }
}

/// Permit fee entity
class PermitFeeEntity extends Equatable {
  const PermitFeeEntity({
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
  final PermitFeeType type;
  final String? description;
  final bool isPaid;
  final DateTime? paidAt;

  @override
  List<Object?> get props => [id, name, amount, type, description, isPaid, paidAt];

  @override
  String toString() {
    return 'PermitFeeEntity(id: $id, name: $name, amount: $amount)';
  }
}

/// Permit fee type enum
enum PermitFeeType {
  application,
  processing,
  inspection,
  penalty,
  renewal,
  other,
}
