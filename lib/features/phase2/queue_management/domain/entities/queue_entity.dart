import 'package:equatable/equatable.dart';

/// Queue ticket entity
class QueueTicketEntity extends Equatable {
  const QueueTicketEntity({
    required this.id,
    required this.ticketNumber,
    required this.serviceType,
    required this.citizenName,
    required this.citizenContact,
    required this.estimatedWaitTime,
    required this.status,
    required this.createdAt,
    this.servedAt,
    this.notes,
    this.priority = QueuePriority.normal,
    this.officeLocation,
    this.serviceDetails,
  });

  final String id;
  final String ticketNumber;
  final QueueServiceType serviceType;
  final String citizenName;
  final String citizenContact;
  final int estimatedWaitTime; // in minutes
  final QueueStatus status;
  final DateTime createdAt;
  final DateTime? servedAt;
  final String? notes;
  final QueuePriority priority;
  final String? officeLocation;
  final Map<String, dynamic>? serviceDetails;

  /// Is ticket active (waiting or being served)
  bool get isActive => status == QueueStatus.waiting || status == QueueStatus.serving;

  /// Is ticket completed
  bool get isCompleted => status == QueueStatus.completed;

  /// Is ticket cancelled
  bool get isCancelled => status == QueueStatus.cancelled;

  /// Is high priority ticket
  bool get isHighPriority => priority == QueuePriority.high;

  /// Is urgent ticket
  bool get isUrgent => priority == QueuePriority.urgent;

  /// Estimated completion time
  DateTime get estimatedCompletionTime => createdAt.add(Duration(minutes: estimatedWaitTime));

  /// Time remaining in queue (in minutes)
  int get timeRemaining {
    if (isCompleted || isCancelled) return 0;
    final now = DateTime.now();
    final completionTime = estimatedCompletionTime;
    if (now.isAfter(completionTime)) return 0;
    return completionTime.difference(now).inMinutes;
  }

  @override
  List<Object?> get props => [
        id,
        ticketNumber,
        serviceType,
        citizenName,
        citizenContact,
        estimatedWaitTime,
        status,
        createdAt,
        servedAt,
        notes,
        priority,
        officeLocation,
        serviceDetails,
      ];

  @override
  String toString() {
    return 'QueueTicketEntity(id: $id, ticketNumber: $ticketNumber, status: $status)';
  }
}

/// Queue office entity
class QueueOfficeEntity extends Equatable {
  const QueueOfficeEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.operatingHours,
    required this.services,
    required this.currentQueue,
    required this.averageWaitTime,
    required this.isOpen,
    this.capacity,
    this.currentServing,
    this.nextAvailable,
  });

  final String id;
  final String name;
  final String location;
  final String operatingHours;
  final List<QueueServiceType> services;
  final int currentQueue;
  final int averageWaitTime; // in minutes
  final bool isOpen;
  final int? capacity;
  final String? currentServing;
  final DateTime? nextAvailable;

  /// Is office at capacity
  bool get isAtCapacity {
    if (capacity == null) return false;
    return currentQueue >= capacity!;
  }

  /// Available capacity
  int get availableCapacity {
    if (capacity == null) return 0;
    return capacity! - currentQueue;
  }

  /// Queue status
  String get queueStatus {
    if (!isOpen) return 'Closed';
    if (isAtCapacity) return 'At Capacity';
    if (currentQueue == 0) return 'No Queue';
    if (currentQueue <= 5) return 'Short Queue';
    if (currentQueue <= 15) return 'Moderate Queue';
    return 'Long Queue';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        operatingHours,
        services,
        currentQueue,
        averageWaitTime,
        isOpen,
        capacity,
        currentServing,
        nextAvailable,
      ];

  @override
  String toString() {
    return 'QueueOfficeEntity(id: $id, name: $name, queueStatus: $queueStatus)';
  }
}

/// Queue service type enum
enum QueueServiceType {
  businessPermit,
  propertyTax,
  civilRegistry,
  healthPermit,
  buildingPermit,
  tricycleFranchise,
  parkingPermit,
  violationPayment,
  generalInquiry,
  documentRequest,
}

/// Queue status enum
enum QueueStatus {
  waiting,
  serving,
  completed,
  cancelled,
  noShow,
}

/// Queue priority enum
enum QueuePriority {
  low,
  normal,
  high,
  urgent,
  senior,
  pwd,
}
