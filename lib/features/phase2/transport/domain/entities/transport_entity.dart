import 'package:equatable/equatable.dart';

/// Tricycle franchise entity
class TricycleFranchiseEntity extends Equatable {
  const TricycleFranchiseEntity({
    required this.id,
    required this.operatorName,
    required this.operatorContact,
    required this.tricycleNumber,
    required this.engineNumber,
    required this.chassisNumber,
    required this.route,
    required this.status,
    required this.applicationDate,
    this.approvedDate,
    this.expiryDate,
    this.franchiseNumber,
    this.fees,
    this.documents,
    this.inspectionDate,
    this.notes,
  });

  final String id;
  final String operatorName;
  final String operatorContact;
  final String tricycleNumber;
  final String engineNumber;
  final String chassisNumber;
  final String route;
  final FranchiseStatus status;
  final DateTime applicationDate;
  final DateTime? approvedDate;
  final DateTime? expiryDate;
  final String? franchiseNumber;
  final List<TransportFeeEntity>? fees;
  final List<String>? documents;
  final DateTime? inspectionDate;
  final String? notes;

  /// Is franchise active
  bool get isActive => status == FranchiseStatus.active;

  /// Is franchise expired
  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  /// Days until expiry
  int? get daysUntilExpiry {
    if (expiryDate == null) return null;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  /// Total fees amount
  double get totalFees {
    if (fees == null) return 0.0;
    return fees!.fold(0.0, (sum, fee) => sum + fee.amount);
  }

  @override
  List<Object?> get props => [
        id,
        operatorName,
        operatorContact,
        tricycleNumber,
        engineNumber,
        chassisNumber,
        route,
        status,
        applicationDate,
        approvedDate,
        expiryDate,
        franchiseNumber,
        fees,
        documents,
        inspectionDate,
        notes,
      ];

  @override
  String toString() {
    return 'TricycleFranchiseEntity(id: $id, tricycleNumber: $tricycleNumber, status: $status)';
  }
}

/// Parking permit entity
class ParkingPermitEntity extends Equatable {
  const ParkingPermitEntity({
    required this.id,
    required this.vehicleOwner,
    required this.vehiclePlateNumber,
    required this.vehicleType,
    required this.parkingLocation,
    required this.permitType,
    required this.status,
    required this.applicationDate,
    this.approvedDate,
    this.expiryDate,
    this.permitNumber,
    this.fees,
    this.documents,
    this.notes,
  });

  final String id;
  final String vehicleOwner;
  final String vehiclePlateNumber;
  final VehicleType vehicleType;
  final String parkingLocation;
  final ParkingPermitType permitType;
  final PermitStatus status;
  final DateTime applicationDate;
  final DateTime? approvedDate;
  final DateTime? expiryDate;
  final String? permitNumber;
  final List<TransportFeeEntity>? fees;
  final List<String>? documents;
  final String? notes;

  /// Is permit active
  bool get isActive => status == PermitStatus.active;

  /// Is permit expired
  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  /// Days until expiry
  int? get daysUntilExpiry {
    if (expiryDate == null) return null;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  /// Total fees amount
  double get totalFees {
    if (fees == null) return 0.0;
    return fees!.fold(0.0, (sum, fee) => sum + fee.amount);
  }

  @override
  List<Object?> get props => [
        id,
        vehicleOwner,
        vehiclePlateNumber,
        vehicleType,
        parkingLocation,
        permitType,
        status,
        applicationDate,
        approvedDate,
        expiryDate,
        permitNumber,
        fees,
        documents,
        notes,
      ];

  @override
  String toString() {
    return 'ParkingPermitEntity(id: $id, vehiclePlateNumber: $vehiclePlateNumber, status: $status)';
  }
}

/// Traffic violation entity
class TrafficViolationEntity extends Equatable {
  const TrafficViolationEntity({
    required this.id,
    required this.violatorName,
    required this.violatorContact,
    required this.vehiclePlateNumber,
    required this.violationType,
    required this.violationLocation,
    required this.violationDate,
    required this.fineAmount,
    required this.status,
    this.paymentDate,
    this.paymentMethod,
    this.receiptNumber,
    this.officerName,
    this.notes,
    this.adjudicationDate,
    this.adjudicationResult,
  });

  final String id;
  final String violatorName;
  final String violatorContact;
  final String vehiclePlateNumber;
  final ViolationType violationType;
  final String violationLocation;
  final DateTime violationDate;
  final double fineAmount;
  final ViolationStatus status;
  final DateTime? paymentDate;
  final String? paymentMethod;
  final String? receiptNumber;
  final String? officerName;
  final String? notes;
  final DateTime? adjudicationDate;
  final String? adjudicationResult;

  /// Is violation paid
  bool get isPaid => status == ViolationStatus.paid;

  /// Is violation pending
  bool get isPending => status == ViolationStatus.pending;

  /// Is violation overdue
  bool get isOverdue {
    if (isPaid) return false;
    final dueDate = violationDate.add(const Duration(days: 30));
    return DateTime.now().isAfter(dueDate);
  }

  /// Days until due date
  int get daysUntilDue {
    final dueDate = violationDate.add(const Duration(days: 30));
    return dueDate.difference(DateTime.now()).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        violatorName,
        violatorContact,
        vehiclePlateNumber,
        violationType,
        violationLocation,
        violationDate,
        fineAmount,
        status,
        paymentDate,
        paymentMethod,
        receiptNumber,
        officerName,
        notes,
        adjudicationDate,
        adjudicationResult,
      ];

  @override
  String toString() {
    return 'TrafficViolationEntity(id: $id, violationType: $violationType, status: $status)';
  }
}

/// Transport fee entity
class TransportFeeEntity extends Equatable {
  const TransportFeeEntity({
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
  final TransportFeeType type;
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

/// Franchise status enum
enum FranchiseStatus {
  pending,
  underReview,
  approved,
  active,
  suspended,
  cancelled,
  expired,
}

/// Permit status enum
enum PermitStatus {
  pending,
  underReview,
  approved,
  active,
  suspended,
  cancelled,
  expired,
}

/// Violation status enum
enum ViolationStatus {
  pending,
  paid,
  contested,
  dismissed,
  overdue,
}

/// Vehicle type enum
enum VehicleType {
  motorcycle,
  tricycle,
  car,
  van,
  truck,
  bus,
  other,
}

/// Parking permit type enum
enum ParkingPermitType {
  residential,
  commercial,
  temporary,
  special,
}

/// Violation type enum
enum ViolationType {
  noHelmet,
  noLicense,
  recklessDriving,
  overspeeding,
  illegalParking,
  noRegistration,
  noInsurance,
  drivingUnderInfluence,
  other,
}

/// Transport fee type enum
enum TransportFeeType {
  application,
  processing,
  inspection,
  permit,
  renewal,
  penalty,
}
