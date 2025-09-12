import 'package:equatable/equatable.dart';

/// Business permit entity
class BusinessPermitEntity extends Equatable {
  const BusinessPermitEntity({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.businessType,
    required this.businessAddress,
    required this.ownerName,
    required this.ownerAddress,
    required this.contactNumber,
    required this.email,
    required this.businessDescription,
    required this.capitalization,
    required this.employeesCount,
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
  final String businessName;
  final String businessType;
  final BusinessAddressEntity businessAddress;
  final String ownerName;
  final String ownerAddress;
  final String contactNumber;
  final String email;
  final String businessDescription;
  final double capitalization;
  final int employeesCount;
  final BusinessPermitStatus status;
  final DateTime submittedAt;
  final DateTime? processedAt;
  final DateTime? completedAt;
  final String? notes;
  final List<BusinessDocumentEntity>? documents;
  final List<BusinessFeeEntity>? fees;
  final int? estimatedProcessingTime; // in days
  final int? actualProcessingTime; // in days

  /// Total fees amount
  double get totalFees {
    if (fees == null || fees!.isEmpty) return 0.0;
    return fees!.fold(0.0, (sum, fee) => sum + fee.amount);
  }

  /// Is application pending
  bool get isPending => status == BusinessPermitStatus.pending;

  /// Is application approved
  bool get isApproved => status == BusinessPermitStatus.approved;

  /// Is application rejected
  bool get isRejected => status == BusinessPermitStatus.rejected;

  /// Is application completed
  bool get isCompleted => status == BusinessPermitStatus.completed;

  /// Processing time in days
  int? get processingTimeInDays {
    if (processedAt == null || completedAt == null) return null;
    return completedAt!.difference(processedAt!).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        businessName,
        businessType,
        businessAddress,
        ownerName,
        ownerAddress,
        contactNumber,
        email,
        businessDescription,
        capitalization,
        employeesCount,
        status,
        submittedAt,
        processedAt,
        completedAt,
        notes,
        documents,
        fees,
        estimatedProcessingTime,
        actualProcessingTime,
      ];

  @override
  String toString() {
    return 'BusinessPermitEntity(id: $id, businessName: $businessName, status: $status)';
  }
}

/// Business permit status enum
enum BusinessPermitStatus {
  pending,
  underReview,
  approved,
  rejected,
  completed,
  cancelled,
}

/// Business address entity
class BusinessAddressEntity extends Equatable {
  const BusinessAddressEntity({
    required this.street,
    required this.barangay,
    required this.city,
    required this.province,
    required this.postalCode,
    this.landmark,
  });

  final String street;
  final String barangay;
  final String city;
  final String province;
  final String postalCode;
  final String? landmark;

  /// Full address getter
  String get fullAddress {
    final parts = [street, barangay, city, province, postalCode];
    if (landmark != null && landmark!.isNotEmpty) {
      parts.insert(1, 'Near $landmark');
    }
    return parts.join(', ');
  }

  @override
  List<Object?> get props => [street, barangay, city, province, postalCode, landmark];

  @override
  String toString() {
    return 'BusinessAddressEntity(fullAddress: $fullAddress)';
  }
}

/// Business document entity
class BusinessDocumentEntity extends Equatable {
  const BusinessDocumentEntity({
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
    return 'BusinessDocumentEntity(id: $id, name: $name, type: $type)';
  }
}

/// Business fee entity
class BusinessFeeEntity extends Equatable {
  const BusinessFeeEntity({
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
  final BusinessFeeType type;
  final String? description;
  final bool isPaid;
  final DateTime? paidAt;

  @override
  List<Object?> get props => [id, name, amount, type, description, isPaid, paidAt];

  @override
  String toString() {
    return 'BusinessFeeEntity(id: $id, name: $name, amount: $amount)';
  }
}

/// Business fee type enum
enum BusinessFeeType {
  application,
  processing,
  penalty,
  renewal,
  amendment,
  other,
}
