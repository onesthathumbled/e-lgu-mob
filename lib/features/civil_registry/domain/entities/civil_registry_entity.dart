import 'package:equatable/equatable.dart';

/// Civil registry document entity
class CivilRegistryDocumentEntity extends Equatable {
  const CivilRegistryDocumentEntity({
    required this.id,
    required this.userId,
    required this.documentType,
    required this.requestorName,
    required this.requestorAddress,
    required this.contactNumber,
    required this.email,
    required this.purpose,
    required this.status,
    required this.submittedAt,
    this.processedAt,
    this.completedAt,
    this.pickupDate,
    this.deliveryAddress,
    this.deliveryMethod,
    this.paymentStatus,
    this.totalAmount,
    this.notes,
    this.documents,
  });

  final String id;
  final String userId;
  final CivilRegistryDocumentType documentType;
  final String requestorName;
  final String requestorAddress;
  final String contactNumber;
  final String email;
  final String purpose;
  final CivilRegistryStatus status;
  final DateTime submittedAt;
  final DateTime? processedAt;
  final DateTime? completedAt;
  final DateTime? pickupDate;
  final String? deliveryAddress;
  final DeliveryMethod? deliveryMethod;
  final PaymentStatus? paymentStatus;
  final double? totalAmount;
  final String? notes;
  final List<DocumentAttachmentEntity>? documents;

  /// Is request pending
  bool get isPending => status == CivilRegistryStatus.pending;

  /// Is request approved
  bool get isApproved => status == CivilRegistryStatus.approved;

  /// Is request rejected
  bool get isRejected => status == CivilRegistryStatus.rejected;

  /// Is request completed
  bool get isCompleted => status == CivilRegistryStatus.completed;

  /// Processing time in days
  int? get processingTimeInDays {
    if (processedAt == null || completedAt == null) return null;
    return completedAt!.difference(processedAt!).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        documentType,
        requestorName,
        requestorAddress,
        contactNumber,
        email,
        purpose,
        status,
        submittedAt,
        processedAt,
        completedAt,
        pickupDate,
        deliveryAddress,
        deliveryMethod,
        paymentStatus,
        totalAmount,
        notes,
        documents,
      ];

  @override
  String toString() {
    return 'CivilRegistryDocumentEntity(id: $id, documentType: $documentType, status: $status)';
  }
}

/// Civil registry document type enum
enum CivilRegistryDocumentType {
  birthCertificate,
  marriageCertificate,
  deathCertificate,
  certificateOfNoMarriage,
  certificateOfLiveBirth,
  certificateOfMarriage,
  certificateOfDeath,
  other,
}

/// Civil registry status enum
enum CivilRegistryStatus {
  pending,
  underReview,
  approved,
  rejected,
  readyForPickup,
  completed,
  cancelled,
}

/// Delivery method enum
enum DeliveryMethod {
  pickup,
  delivery,
  courier,
}

/// Payment status enum
enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

/// Document attachment entity
class DocumentAttachmentEntity extends Equatable {
  const DocumentAttachmentEntity({
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
    return 'DocumentAttachmentEntity(id: $id, name: $name, type: $type)';
  }
}
