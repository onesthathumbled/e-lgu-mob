import 'package:equatable/equatable.dart';

/// Waste collection types
enum WasteType {
  general,
  recyclable,
  biodegradable,
  hazardous,
  electronic,
  bulky,
}

/// Collection status
enum CollectionStatus {
  scheduled,
  inProgress,
  completed,
  missed,
  rescheduled,
  cancelled,
}

/// Waste collection schedule entity
class WasteScheduleEntity extends Equatable {
  const WasteScheduleEntity({
    required this.id,
    required this.barangayId,
    required this.barangayName,
    required this.zone,
    required this.wasteType,
    required this.collectionDate,
    required this.collectionTime,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.notes,
    this.collectionTruckId,
    this.collectionCrew,
    this.estimatedDuration,
    this.actualDuration,
    this.collectedWeight,
    this.collectedVolume,
    this.issues,
    this.residentsNotified,
  });

  final String id;
  final String barangayId;
  final String barangayName;
  final String zone;
  final WasteType wasteType;
  final DateTime collectionDate;
  final String collectionTime;
  final CollectionStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;
  final String? notes;
  final String? collectionTruckId;
  final String? collectionCrew;
  final int? estimatedDuration; // in minutes
  final int? actualDuration; // in minutes
  final double? collectedWeight; // in kg
  final double? collectedVolume; // in cubic meters
  final List<String>? issues;
  final bool? residentsNotified;

  /// Check if collection is today
  bool get isToday {
    final today = DateTime.now();
    return collectionDate.year == today.year &&
        collectionDate.month == today.month &&
        collectionDate.day == today.day;
  }

  /// Check if collection is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return collectionDate.year == tomorrow.year &&
        collectionDate.month == tomorrow.month &&
        collectionDate.day == tomorrow.day;
  }

  /// Check if collection is upcoming (within next 7 days)
  bool get isUpcoming {
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    return collectionDate.isAfter(now) && collectionDate.isBefore(weekFromNow);
  }

  /// Check if collection is overdue
  bool get isOverdue {
    return status == CollectionStatus.scheduled && 
        DateTime.now().isAfter(collectionDate);
  }

  /// Get collection time as DateTime
  DateTime get collectionDateTime {
    final timeParts = collectionTime.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    
    return DateTime(
      collectionDate.year,
      collectionDate.month,
      collectionDate.day,
      hour,
      minute,
    );
  }

  @override
  List<Object?> get props => [
        id,
        barangayId,
        barangayName,
        zone,
        wasteType,
        collectionDate,
        collectionTime,
        status,
        createdAt,
        updatedAt,
        completedAt,
        notes,
        collectionTruckId,
        collectionCrew,
        estimatedDuration,
        actualDuration,
        collectedWeight,
        collectedVolume,
        issues,
        residentsNotified,
      ];
}

/// Waste collection reminder entity
class WasteReminderEntity extends Equatable {
  const WasteReminderEntity({
    required this.id,
    required this.userId,
    required this.scheduleId,
    required this.reminderTime,
    required this.message,
    required this.isSent,
    this.sentAt,
  });

  final String id;
  final String userId;
  final String scheduleId;
  final DateTime reminderTime;
  final String message;
  final bool isSent;
  final DateTime? sentAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        scheduleId,
        reminderTime,
        message,
        isSent,
        sentAt,
      ];
}

/// Barangay waste management info
class BarangayWasteInfoEntity extends Equatable {
  const BarangayWasteInfoEntity({
    required this.barangayId,
    required this.barangayName,
    required this.zones,
    required this.collectionSchedule,
    required this.contactInfo,
    required this.specialInstructions,
    this.recyclingCenter,
    this.hazardousWasteDropOff,
    this.bulkyWasteCollection,
  });

  final String barangayId;
  final String barangayName;
  final List<String> zones;
  final Map<WasteType, List<String>> collectionSchedule; // waste type -> days of week
  final Map<String, String> contactInfo;
  final List<String> specialInstructions;
  final String? recyclingCenter;
  final String? hazardousWasteDropOff;
  final String? bulkyWasteCollection;

  /// Get collection days for a specific waste type
  List<String> getCollectionDays(WasteType wasteType) {
    return collectionSchedule[wasteType] ?? [];
  }

  /// Check if collection happens on a specific day for waste type
  bool hasCollectionOnDay(WasteType wasteType, String day) {
    final days = getCollectionDays(wasteType);
    return days.contains(day.toLowerCase());
  }

  @override
  List<Object?> get props => [
        barangayId,
        barangayName,
        zones,
        collectionSchedule,
        contactInfo,
        specialInstructions,
        recyclingCenter,
        hazardousWasteDropOff,
        bulkyWasteCollection,
      ];
}
