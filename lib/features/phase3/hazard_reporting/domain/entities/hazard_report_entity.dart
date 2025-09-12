import 'package:equatable/equatable.dart';

/// Hazard types
enum HazardType {
  roadDamage,
  electricalPost,
  flooding,
  fallenTree,
  brokenStreetlight,
  damagedSidewalk,
  blockedDrainage,
  looseWires,
  damagedBridge,
  landslide,
  fireHazard,
  waterLeak,
  gasLeak,
  structuralDamage,
  other,
}

/// Hazard severity levels
enum HazardSeverity {
  low,
  medium,
  high,
  critical,
  emergency,
}

/// Report status
enum HazardReportStatus {
  submitted,
  underReview,
  assigned,
  inProgress,
  resolved,
  closed,
  rejected,
}

/// Hazard report entity
class HazardReportEntity extends Equatable {
  const HazardReportEntity({
    required this.id,
    required this.reporterId,
    required this.reporterName,
    required this.reporterEmail,
    required this.reporterPhone,
    required this.hazardType,
    required this.severity,
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.reportDate,
    required this.isAnonymous,
    this.updatedAt,
    this.assignedTo,
    this.assignedDate,
    this.estimatedResolutionDate,
    this.actualResolutionDate,
    this.resolutionNotes,
    this.images,
    this.videos,
    this.audioNotes,
    this.contactPreference,
    this.publicVisibility,
    this.tags,
    this.relatedReports,
    this.priority,
    this.estimatedCost,
    this.actualCost,
    this.workOrderNumber,
    this.contractor,
    this.beforeImages,
    this.afterImages,
  });

  final String id;
  final String reporterId;
  final String reporterName;
  final String reporterEmail;
  final String reporterPhone;
  final HazardType hazardType;
  final HazardSeverity severity;
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final HazardReportStatus status;
  final DateTime reportDate;
  final bool isAnonymous;
  final DateTime? updatedAt;
  final String? assignedTo;
  final DateTime? assignedDate;
  final DateTime? estimatedResolutionDate;
  final DateTime? actualResolutionDate;
  final String? resolutionNotes;
  final List<String>? images;
  final List<String>? videos;
  final List<String>? audioNotes;
  final String? contactPreference;
  final bool? publicVisibility;
  final List<String>? tags;
  final List<String>? relatedReports;
  final int? priority;
  final double? estimatedCost;
  final double? actualCost;
  final String? workOrderNumber;
  final String? contractor;
  final List<String>? beforeImages;
  final List<String>? afterImages;

  /// Days since report was submitted
  int get daysSinceReport {
    return DateTime.now().difference(reportDate).inDays;
  }

  /// Check if report is overdue
  bool get isOverdue {
    if (estimatedResolutionDate == null) return false;
    return DateTime.now().isAfter(estimatedResolutionDate!) && 
        status != HazardReportStatus.resolved;
  }

  /// Check if report is in progress
  bool get isInProgress {
    return status == HazardReportStatus.assigned || 
        status == HazardReportStatus.inProgress;
  }

  /// Check if report is resolved
  bool get isResolved {
    return status == HazardReportStatus.resolved || 
        status == HazardReportStatus.closed;
  }

  /// Get status color for UI
  String get statusColor {
    switch (status) {
      case HazardReportStatus.submitted:
        return 'blue';
      case HazardReportStatus.underReview:
        return 'yellow';
      case HazardReportStatus.assigned:
        return 'orange';
      case HazardReportStatus.inProgress:
        return 'purple';
      case HazardReportStatus.resolved:
        return 'green';
      case HazardReportStatus.closed:
        return 'gray';
      case HazardReportStatus.rejected:
        return 'red';
    }
  }

  /// Get severity color for UI
  String get severityColor {
    switch (severity) {
      case HazardSeverity.low:
        return 'green';
      case HazardSeverity.medium:
        return 'yellow';
      case HazardSeverity.high:
        return 'orange';
      case HazardSeverity.critical:
        return 'red';
      case HazardSeverity.emergency:
        return 'red';
    }
  }

  @override
  List<Object?> get props => [
        id,
        reporterId,
        reporterName,
        reporterEmail,
        reporterPhone,
        hazardType,
        severity,
        title,
        description,
        location,
        latitude,
        longitude,
        status,
        reportDate,
        isAnonymous,
        updatedAt,
        assignedTo,
        assignedDate,
        estimatedResolutionDate,
        actualResolutionDate,
        resolutionNotes,
        images,
        videos,
        audioNotes,
        contactPreference,
        publicVisibility,
        tags,
        relatedReports,
        priority,
        estimatedCost,
        actualCost,
        workOrderNumber,
        contractor,
        beforeImages,
        afterImages,
      ];
}

/// Hazard report update/comment entity
class HazardReportUpdateEntity extends Equatable {
  const HazardReportUpdateEntity({
    required this.id,
    required this.reportId,
    required this.userId,
    required this.userName,
    required this.userRole,
    required this.updateType,
    required this.message,
    required this.timestamp,
    this.images,
    this.statusChange,
    this.assignedTo,
    this.estimatedDate,
    this.actualDate,
  });

  final String id;
  final String reportId;
  final String userId;
  final String userName;
  final String userRole; // 'reporter', 'admin', 'contractor', 'inspector'
  final String updateType; // 'comment', 'status_change', 'assignment', 'resolution'
  final String message;
  final DateTime timestamp;
  final List<String>? images;
  final HazardReportStatus? statusChange;
  final String? assignedTo;
  final DateTime? estimatedDate;
  final DateTime? actualDate;

  @override
  List<Object?> get props => [
        id,
        reportId,
        userId,
        userName,
        userRole,
        updateType,
        message,
        timestamp,
        images,
        statusChange,
        assignedTo,
        estimatedDate,
        actualDate,
      ];
}

/// Hazard statistics entity
class HazardStatsEntity extends Equatable {
  const HazardStatsEntity({
    required this.totalReports,
    required this.resolvedReports,
    required this.pendingReports,
    required this.overdueReports,
    required this.averageResolutionTime,
    required this.reportsByType,
    required this.reportsBySeverity,
    required this.reportsByStatus,
    required this.monthlyTrends,
  });

  final int totalReports;
  final int resolvedReports;
  final int pendingReports;
  final int overdueReports;
  final double averageResolutionTime; // in days
  final Map<HazardType, int> reportsByType;
  final Map<HazardSeverity, int> reportsBySeverity;
  final Map<HazardReportStatus, int> reportsByStatus;
  final Map<String, int> monthlyTrends; // month -> count

  /// Resolution rate percentage
  double get resolutionRate {
    if (totalReports == 0) return 0.0;
    return (resolvedReports / totalReports) * 100;
  }

  /// Pending rate percentage
  double get pendingRate {
    if (totalReports == 0) return 0.0;
    return (pendingReports / totalReports) * 100;
  }

  @override
  List<Object?> get props => [
        totalReports,
        resolvedReports,
        pendingReports,
        overdueReports,
        averageResolutionTime,
        reportsByType,
        reportsBySeverity,
        reportsByStatus,
        monthlyTrends,
      ];
}
