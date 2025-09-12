import 'package:equatable/equatable.dart';

/// Building permit application entity
class BuildingPermitEntity extends Equatable {
  const BuildingPermitEntity({
    required this.id,
    required this.applicantName,
    required this.applicantContact,
    required this.propertyAddress,
    required this.buildingType,
    required this.constructionType,
    required this.totalFloorArea,
    required this.numberOfFloors,
    required this.estimatedCost,
    required this.status,
    required this.submittedAt,
    this.processedAt,
    this.approvedAt,
    this.rejectedAt,
    this.permitNumber,
    this.validUntil,
    this.notes,
    this.documents,
    this.fees,
    this.inspectionSchedule,
    this.engineeringReview,
    this.planningReview,
  });

  final String id;
  final String applicantName;
  final String applicantContact;
  final String propertyAddress;
  final BuildingType buildingType;
  final ConstructionType constructionType;
  final double totalFloorArea;
  final int numberOfFloors;
  final double estimatedCost;
  final ObosStatus status;
  final DateTime submittedAt;
  final DateTime? processedAt;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final String? permitNumber;
  final DateTime? validUntil;
  final String? notes;
  final List<String>? documents;
  final List<ObosFeeEntity>? fees;
  final DateTime? inspectionSchedule;
  final EngineeringReviewEntity? engineeringReview;
  final PlanningReviewEntity? planningReview;

  /// Is application pending
  bool get isPending => status == ObosStatus.pending;

  /// Is application approved
  bool get isApproved => status == ObosStatus.approved;

  /// Is application rejected
  bool get isRejected => status == ObosStatus.rejected;

  /// Is application under review
  bool get isUnderReview => status == ObosStatus.underReview;

  /// Total fees amount
  double get totalFees {
    if (fees == null) return 0.0;
    return fees!.fold(0.0, (sum, fee) => sum + fee.amount);
  }

  /// Processing time in days
  int? get processingTimeInDays {
    if (approvedAt == null) return null;
    return approvedAt!.difference(submittedAt).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        applicantName,
        applicantContact,
        propertyAddress,
        buildingType,
        constructionType,
        totalFloorArea,
        numberOfFloors,
        estimatedCost,
        status,
        submittedAt,
        processedAt,
        approvedAt,
        rejectedAt,
        permitNumber,
        validUntil,
        notes,
        documents,
        fees,
        inspectionSchedule,
        engineeringReview,
        planningReview,
      ];

  @override
  String toString() {
    return 'BuildingPermitEntity(id: $id, status: $status, buildingType: $buildingType)';
  }
}

/// Engineering review entity
class EngineeringReviewEntity extends Equatable {
  const EngineeringReviewEntity({
    required this.id,
    required this.reviewerName,
    required this.reviewDate,
    required this.status,
    required this.comments,
    this.recommendations,
    this.requiredChanges,
  });

  final String id;
  final String reviewerName;
  final DateTime reviewDate;
  final ReviewStatus status;
  final String comments;
  final List<String>? recommendations;
  final List<String>? requiredChanges;

  @override
  List<Object?> get props => [
        id,
        reviewerName,
        reviewDate,
        status,
        comments,
        recommendations,
        requiredChanges,
      ];
}

/// Planning review entity
class PlanningReviewEntity extends Equatable {
  const PlanningReviewEntity({
    required this.id,
    required this.reviewerName,
    required this.reviewDate,
    required this.status,
    required this.comments,
    this.zoningCompliance,
    this.setbackCompliance,
    this.heightCompliance,
  });

  final String id;
  final String reviewerName;
  final DateTime reviewDate;
  final ReviewStatus status;
  final String comments;
  final bool? zoningCompliance;
  final bool? setbackCompliance;
  final bool? heightCompliance;

  @override
  List<Object?> get props => [
        id,
        reviewerName,
        reviewDate,
        status,
        comments,
        zoningCompliance,
        setbackCompliance,
        heightCompliance,
      ];
}

/// OBOS fee entity
class ObosFeeEntity extends Equatable {
  const ObosFeeEntity({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.description,
    this.isPaid = false,
    this.paymentDate,
  });

  final String id;
  final String name;
  final double amount;
  final ObosFeeType type;
  final String description;
  final bool isPaid;
  final DateTime? paymentDate;

  @override
  List<Object?> get props => [
        id,
        name,
        amount,
        type,
        description,
        isPaid,
        paymentDate,
      ];
}

/// Building type enum
enum BuildingType {
  residential,
  commercial,
  industrial,
  institutional,
  agricultural,
  mixedUse,
}

/// Construction type enum
enum ConstructionType {
  newConstruction,
  renovation,
  addition,
  demolition,
  repair,
}

/// OBOS status enum
enum ObosStatus {
  pending,
  underReview,
  engineeringReview,
  planningReview,
  inspectionRequired,
  approved,
  rejected,
  expired,
}

/// Review status enum
enum ReviewStatus {
  pending,
  approved,
  rejected,
  requiresChanges,
}

/// OBOS fee type enum
enum ObosFeeType {
  application,
  processing,
  inspection,
  permit,
  penalty,
}
