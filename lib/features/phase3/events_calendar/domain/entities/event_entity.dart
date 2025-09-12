import 'package:equatable/equatable.dart';

/// Event types
enum EventType {
  lguOfficial,
  citizenLed,
  community,
  cultural,
  sports,
  educational,
  religious,
  social,
  emergency,
}

/// Event status
enum EventStatus {
  draft,
  published,
  cancelled,
  completed,
  postponed,
}

/// RSVP status
enum RsvpStatus {
  notResponded,
  attending,
  notAttending,
  maybe,
}

/// Event entity
class EventEntity extends Equatable {
  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.organizerId,
    required this.organizerName,
    required this.organizerType, // 'lgu' or 'citizen'
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.isPublic,
    required this.maxAttendees,
    required this.registrationRequired,
    required this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.contactEmail,
    this.contactPhone,
    this.registrationDeadline,
    this.registrationFee,
    this.requirements,
    this.agenda,
    this.speakers,
    this.sponsors,
    this.tags,
    this.attachments,
    this.reminderSettings,
  });

  final String id;
  final String title;
  final String description;
  final EventType type;
  final EventStatus status;
  final String organizerId;
  final String organizerName;
  final String organizerType;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final bool isPublic;
  final int? maxAttendees;
  final bool registrationRequired;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final String? contactEmail;
  final String? contactPhone;
  final DateTime? registrationDeadline;
  final double? registrationFee;
  final List<String>? requirements;
  final List<String>? agenda;
  final List<String>? speakers;
  final List<String>? sponsors;
  final List<String>? tags;
  final List<String>? attachments;
  final Map<String, dynamic>? reminderSettings;

  /// Duration of event in hours
  double get durationHours {
    return endDate.difference(startDate).inHours.toDouble();
  }

  /// Check if event is upcoming
  bool get isUpcoming {
    return DateTime.now().isBefore(startDate);
  }

  /// Check if event is ongoing
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  /// Check if event is completed
  bool get isCompleted {
    return DateTime.now().isAfter(endDate);
  }

  /// Check if registration is still open
  bool get isRegistrationOpen {
    if (!registrationRequired) return false;
    if (registrationDeadline == null) return true;
    return DateTime.now().isBefore(registrationDeadline!);
  }

  /// Check if event is LGU official
  bool get isLguOfficial {
    return organizerType == 'lgu';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        status,
        organizerId,
        organizerName,
        organizerType,
        startDate,
        endDate,
        location,
        isPublic,
        maxAttendees,
        registrationRequired,
        createdAt,
        updatedAt,
        imageUrl,
        contactEmail,
        contactPhone,
        registrationDeadline,
        registrationFee,
        requirements,
        agenda,
        speakers,
        sponsors,
        tags,
        attachments,
        reminderSettings,
      ];
}

/// Event registration entity
class EventRegistrationEntity extends Equatable {
  const EventRegistrationEntity({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.registrationDate,
    required this.status,
    this.notes,
    this.emergencyContact,
    this.dietaryRequirements,
    this.accessibilityNeeds,
    this.paymentStatus,
    this.paymentReference,
  });

  final String id;
  final String eventId;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final DateTime registrationDate;
  final RsvpStatus status;
  final String? notes;
  final String? emergencyContact;
  final String? dietaryRequirements;
  final String? accessibilityNeeds;
  final String? paymentStatus;
  final String? paymentReference;

  @override
  List<Object?> get props => [
        id,
        eventId,
        userId,
        userName,
        userEmail,
        userPhone,
        registrationDate,
        status,
        notes,
        emergencyContact,
        dietaryRequirements,
        accessibilityNeeds,
        paymentStatus,
        paymentReference,
      ];
}

/// Event reminder entity
class EventReminderEntity extends Equatable {
  const EventReminderEntity({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.reminderTime,
    required this.message,
    required this.isSent,
    this.sentAt,
  });

  final String id;
  final String eventId;
  final String userId;
  final DateTime reminderTime;
  final String message;
  final bool isSent;
  final DateTime? sentAt;

  @override
  List<Object?> get props => [
        id,
        eventId,
        userId,
        reminderTime,
        message,
        isSent,
        sentAt,
      ];
}
