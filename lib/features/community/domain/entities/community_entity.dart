import 'package:equatable/equatable.dart';

/// Community event entity
class CommunityEventEntity extends Equatable {
  const CommunityEventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizer,
    required this.contactNumber,
    required this.contactEmail,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.maxParticipants,
    this.currentParticipants,
    required this.registrationRequired,
    this.registrationDeadline,
    this.fee,
    this.imageUrl,
    this.requirements,
    this.benefits,
  });

  final String id;
  final String title;
  final String description;
  final EventType eventType;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String organizer;
  final String contactNumber;
  final String contactEmail;
  final EventStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? maxParticipants;
  final int? currentParticipants;
  final bool registrationRequired;
  final DateTime? registrationDeadline;
  final double? fee;
  final String? imageUrl;
  final List<String>? requirements;
  final List<String>? benefits;

  /// Is event active
  bool get isActive => status == EventStatus.active;

  /// Is event cancelled
  bool get isCancelled => status == EventStatus.cancelled;

  /// Is event completed
  bool get isCompleted => status == EventStatus.completed;

  /// Is event full
  bool get isFull {
    if (maxParticipants == null || currentParticipants == null) return false;
    return currentParticipants! >= maxParticipants!;
  }

  /// Remaining slots
  int? get remainingSlots {
    if (maxParticipants == null || currentParticipants == null) return null;
    return maxParticipants! - currentParticipants!;
  }

  /// Is registration deadline passed
  bool get isRegistrationDeadlinePassed {
    if (registrationDeadline == null) return false;
    return DateTime.now().isAfter(registrationDeadline!);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        eventType,
        startDate,
        endDate,
        location,
        organizer,
        contactNumber,
        contactEmail,
        status,
        createdAt,
        updatedAt,
        maxParticipants,
        currentParticipants,
        registrationRequired,
        registrationDeadline,
        fee,
        imageUrl,
        requirements,
        benefits,
      ];

  @override
  String toString() {
    return 'CommunityEventEntity(id: $id, title: $title, eventType: $eventType, status: $status)';
  }
}

/// Job posting entity
class JobPostingEntity extends Equatable {
  const JobPostingEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.jobType,
    required this.salaryRange,
    required this.requirements,
    required this.benefits,
    required this.contactEmail,
    required this.contactNumber,
    required this.status,
    required this.postedAt,
    this.updatedAt,
    this.applicationDeadline,
    this.experienceLevel,
    this.educationLevel,
    this.skills,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final String company;
  final String location;
  final JobType jobType;
  final String salaryRange;
  final List<String> requirements;
  final List<String> benefits;
  final String contactEmail;
  final String contactNumber;
  final JobStatus status;
  final DateTime postedAt;
  final DateTime? updatedAt;
  final DateTime? applicationDeadline;
  final ExperienceLevel? experienceLevel;
  final EducationLevel? educationLevel;
  final List<String>? skills;
  final String? imageUrl;

  /// Is job active
  bool get isActive => status == JobStatus.active;

  /// Is job closed
  bool get isClosed => status == JobStatus.closed;

  /// Is application deadline passed
  bool get isApplicationDeadlinePassed {
    if (applicationDeadline == null) return false;
    return DateTime.now().isAfter(applicationDeadline!);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        company,
        location,
        jobType,
        salaryRange,
        requirements,
        benefits,
        contactEmail,
        contactNumber,
        status,
        postedAt,
        updatedAt,
        applicationDeadline,
        experienceLevel,
        educationLevel,
        skills,
        imageUrl,
      ];

  @override
  String toString() {
    return 'JobPostingEntity(id: $id, title: $title, company: $company, status: $status)';
  }
}

/// Marketplace item entity
class MarketplaceItemEntity extends Equatable {
  const MarketplaceItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.sellerName,
    required this.sellerContact,
    required this.location,
    required this.status,
    required this.postedAt,
    this.updatedAt,
    this.images,
    this.condition,
    required this.negotiable,
    required this.deliveryAvailable,
    this.deliveryFee,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final MarketplaceCategory category;
  final String sellerName;
  final String sellerContact;
  final String location;
  final MarketplaceStatus status;
  final DateTime postedAt;
  final DateTime? updatedAt;
  final List<String>? images;
  final ItemCondition? condition;
  final bool negotiable;
  final bool deliveryAvailable;
  final double? deliveryFee;

  /// Is item active
  bool get isActive => status == MarketplaceStatus.active;

  /// Is item sold
  bool get isSold => status == MarketplaceStatus.sold;

  /// Is item reserved
  bool get isReserved => status == MarketplaceStatus.reserved;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        category,
        sellerName,
        sellerContact,
        location,
        status,
        postedAt,
        updatedAt,
        images,
        condition,
        negotiable,
        deliveryAvailable,
        deliveryFee,
      ];

  @override
  String toString() {
    return 'MarketplaceItemEntity(id: $id, title: $title, category: $category, status: $status)';
  }
}

/// Event type enum
enum EventType {
  fiesta,
  communityMeeting,
  training,
  healthCamp,
  sports,
  cultural,
  religious,
  emergency,
  other,
}

/// Event status enum
enum EventStatus {
  active,
  cancelled,
  completed,
  postponed,
}

/// Job type enum
enum JobType {
  fullTime,
  partTime,
  contract,
  freelance,
  internship,
  volunteer,
}

/// Job status enum
enum JobStatus {
  active,
  closed,
  filled,
  expired,
}

/// Experience level enum
enum ExperienceLevel {
  entry,
  mid,
  senior,
  executive,
}

/// Education level enum
enum EducationLevel {
  highSchool,
  vocational,
  college,
  graduate,
  postgraduate,
}

/// Marketplace category enum
enum MarketplaceCategory {
  electronics,
  clothing,
  furniture,
  vehicles,
  books,
  food,
  services,
  realEstate,
  other,
}

/// Marketplace status enum
enum MarketplaceStatus {
  active,
  sold,
  reserved,
  expired,
}

/// Item condition enum
enum ItemCondition {
  new_,
  likeNew,
  good,
  fair,
  poor,
}
