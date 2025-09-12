import 'package:equatable/equatable.dart';

/// Social program entity
class SocialProgramEntity extends Equatable {
  const SocialProgramEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.eligibilityRequirements,
    required this.benefits,
    required this.applicationDeadline,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.maxParticipants,
    this.currentParticipants,
    this.contactPerson,
    this.contactNumber,
    this.contactEmail,
    this.documents,
    this.requirements,
  });

  final String id;
  final String title;
  final String description;
  final SocialProgramType type;
  final SocialProgramCategory category;
  final List<String> eligibilityRequirements;
  final List<String> benefits;
  final DateTime applicationDeadline;
  final SocialProgramStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? maxParticipants;
  final int? currentParticipants;
  final String? contactPerson;
  final String? contactNumber;
  final String? contactEmail;
  final List<ProgramDocumentEntity>? documents;
  final List<String>? requirements;

  /// Is program active
  bool get isActive => status == SocialProgramStatus.active;

  /// Is program closed
  bool get isClosed => status == SocialProgramStatus.closed;

  /// Is program full
  bool get isFull {
    if (maxParticipants == null || currentParticipants == null) return false;
    return currentParticipants! >= maxParticipants!;
  }

  /// Remaining slots
  int? get remainingSlots {
    if (maxParticipants == null || currentParticipants == null) return null;
    return maxParticipants! - currentParticipants!;
  }

  /// Is application deadline passed
  bool get isDeadlinePassed => DateTime.now().isAfter(applicationDeadline);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        type,
        category,
        eligibilityRequirements,
        benefits,
        applicationDeadline,
        status,
        createdAt,
        updatedAt,
        maxParticipants,
        currentParticipants,
        contactPerson,
        contactNumber,
        contactEmail,
        documents,
        requirements,
      ];

  @override
  String toString() {
    return 'SocialProgramEntity(id: $id, title: $title, type: $type, status: $status)';
  }
}

/// Social program application entity
class SocialProgramApplicationEntity extends Equatable {
  const SocialProgramApplicationEntity({
    required this.id,
    required this.userId,
    required this.programId,
    required this.applicantName,
    required this.applicantAddress,
    required this.contactNumber,
    required this.email,
    required this.reasonForApplication,
    required this.status,
    required this.submittedAt,
    this.processedAt,
    this.approvedAt,
    this.rejectedAt,
    this.notes,
    this.documents,
    this.interviewDate,
    this.interviewNotes,
  });

  final String id;
  final String userId;
  final String programId;
  final String applicantName;
  final String applicantAddress;
  final String contactNumber;
  final String email;
  final String reasonForApplication;
  final ApplicationStatus status;
  final DateTime submittedAt;
  final DateTime? processedAt;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final String? notes;
  final List<ApplicationDocumentEntity>? documents;
  final DateTime? interviewDate;
  final String? interviewNotes;

  /// Is application pending
  bool get isPending => status == ApplicationStatus.pending;

  /// Is application approved
  bool get isApproved => status == ApplicationStatus.approved;

  /// Is application rejected
  bool get isRejected => status == ApplicationStatus.rejected;

  /// Is application under review
  bool get isUnderReview => status == ApplicationStatus.underReview;

  /// Processing time in days
  int? get processingTimeInDays {
    if (processedAt == null || (approvedAt ?? rejectedAt) == null) return null;
    final endDate = approvedAt ?? rejectedAt!;
    return endDate.difference(processedAt!).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        programId,
        applicantName,
        applicantAddress,
        contactNumber,
        email,
        reasonForApplication,
        status,
        submittedAt,
        processedAt,
        approvedAt,
        rejectedAt,
        notes,
        documents,
        interviewDate,
        interviewNotes,
      ];

  @override
  String toString() {
    return 'SocialProgramApplicationEntity(id: $id, programId: $programId, status: $status)';
  }
}

/// Social program type enum
enum SocialProgramType {
  financialAid,
  scholarship,
  training,
  medical,
  housing,
  livelihood,
  emergency,
  other,
}

/// Social program category enum
enum SocialProgramCategory {
  education,
  health,
  livelihood,
  housing,
  emergency,
  seniorCitizen,
  pwd,
  women,
  youth,
  other,
}

/// Social program status enum
enum SocialProgramStatus {
  active,
  closed,
  suspended,
  completed,
}

/// Application status enum
enum ApplicationStatus {
  pending,
  underReview,
  approved,
  rejected,
  cancelled,
}

/// Program document entity
class ProgramDocumentEntity extends Equatable {
  const ProgramDocumentEntity({
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
    return 'ProgramDocumentEntity(id: $id, name: $name, type: $type)';
  }
}

/// Application document entity
class ApplicationDocumentEntity extends Equatable {
  const ApplicationDocumentEntity({
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
    return 'ApplicationDocumentEntity(id: $id, name: $name, type: $type)';
  }
}
