import 'package:equatable/equatable.dart';

/// Evacuation center entity
class EvacuationCenterEntity extends Equatable {
  const EvacuationCenterEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.capacity,
    required this.currentOccupancy,
    required this.status,
    required this.category,
    required this.facilities,
    this.contactNumber,
    this.contactPerson,
    this.operatingHours,
    this.notes,
    this.lastUpdated,
  });

  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int capacity;
  final int currentOccupancy;
  final EvacCenterStatus status;
  final EvacCenterCategory category;
  final List<EvacFacility> facilities;
  final String? contactNumber;
  final String? contactPerson;
  final String? operatingHours;
  final String? notes;
  final DateTime? lastUpdated;

  /// Is center available
  bool get isAvailable => status == EvacCenterStatus.available;

  /// Is center at capacity
  bool get isAtCapacity => currentOccupancy >= capacity;

  /// Available capacity
  int get availableCapacity => capacity - currentOccupancy;

  /// Occupancy percentage
  double get occupancyPercentage => (currentOccupancy / capacity) * 100;

  /// Is center operational
  bool get isOperational => status == EvacCenterStatus.available || status == EvacCenterStatus.partial;

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        latitude,
        longitude,
        capacity,
        currentOccupancy,
        status,
        category,
        facilities,
        contactNumber,
        contactPerson,
        operatingHours,
        notes,
        lastUpdated,
      ];

  @override
  String toString() {
    return 'EvacuationCenterEntity(id: $id, name: $name, status: $status)';
  }
}

/// Disaster alert entity
class DisasterAlertEntity extends Equatable {
  const DisasterAlertEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.alertType,
    required this.severity,
    required this.affectedAreas,
    required this.issuedAt,
    required this.validUntil,
    required this.status,
    this.instructions,
    this.contactInfo,
    this.evacuationCenters,
    this.safetyTips,
  });

  final String id;
  final String title;
  final String description;
  final DisasterType alertType;
  final AlertSeverity severity;
  final List<String> affectedAreas;
  final DateTime issuedAt;
  final DateTime validUntil;
  final AlertStatus status;
  final List<String>? instructions;
  final String? contactInfo;
  final List<String>? evacuationCenters;
  final List<String>? safetyTips;

  /// Is alert active
  bool get isActive => status == AlertStatus.active;

  /// Is alert expired
  bool get isExpired => DateTime.now().isAfter(validUntil);

  /// Time remaining
  Duration get timeRemaining => validUntil.difference(DateTime.now());

  /// Is high severity
  bool get isHighSeverity => severity == AlertSeverity.high || severity == AlertSeverity.critical;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        alertType,
        severity,
        affectedAreas,
        issuedAt,
        validUntil,
        status,
        instructions,
        contactInfo,
        evacuationCenters,
        safetyTips,
      ];

  @override
  String toString() {
    return 'DisasterAlertEntity(id: $id, title: $title, severity: $severity)';
  }
}

/// Flood zone entity
class FloodZoneEntity extends Equatable {
  const FloodZoneEntity({
    required this.id,
    required this.zoneName,
    required this.riskLevel,
    required this.coordinates,
    required this.affectedBarangays,
    this.waterLevel,
    this.lastUpdate,
    this.notes,
  });

  final String id;
  final String zoneName;
  final FloodRiskLevel riskLevel;
  final List<Map<String, double>> coordinates;
  final List<String> affectedBarangays;
  final double? waterLevel;
  final DateTime? lastUpdate;
  final String? notes;

  /// Is high risk zone
  bool get isHighRisk => riskLevel == FloodRiskLevel.high;

  /// Is critical risk zone
  bool get isCriticalRisk => riskLevel == FloodRiskLevel.critical;

  @override
  List<Object?> get props => [
        id,
        zoneName,
        riskLevel,
        coordinates,
        affectedBarangays,
        waterLevel,
        lastUpdate,
        notes,
      ];

  @override
  String toString() {
    return 'FloodZoneEntity(id: $id, zoneName: $zoneName, riskLevel: $riskLevel)';
  }
}

/// Evacuation center status enum
enum EvacCenterStatus {
  available,
  partial,
  full,
  closed,
  maintenance,
}

/// Evacuation center category enum
enum EvacCenterCategory {
  school,
  church,
  communityCenter,
  gymnasium,
  hospital,
  governmentBuilding,
  other,
}

/// Evacuation facility enum
enum EvacFacility {
  electricity,
  water,
  toilets,
  kitchen,
  medical,
  security,
  parking,
  accessibility,
  communication,
  storage,
}

/// Disaster type enum
enum DisasterType {
  typhoon,
  flood,
  earthquake,
  fire,
  landslide,
  volcanic,
  tsunami,
  other,
}

/// Alert severity enum
enum AlertSeverity {
  low,
  medium,
  high,
  critical,
}

/// Alert status enum
enum AlertStatus {
  active,
  cancelled,
  expired,
}

/// Flood risk level enum
enum FloodRiskLevel {
  low,
  medium,
  high,
  critical,
}
