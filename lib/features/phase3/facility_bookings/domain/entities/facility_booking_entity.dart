import 'package:equatable/equatable.dart';

/// Facility types available for booking
enum FacilityType {
  barangayHall,
  gymnasium,
  basketballCourt,
  functionRoom,
  meetingRoom,
  playground,
  multipurposeHall,
  auditorium,
}

/// Booking status
enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed,
  rejected,
}

/// Facility booking entity
class FacilityBookingEntity extends Equatable {
  const FacilityBookingEntity({
    required this.id,
    required this.facilityId,
    required this.facilityName,
    required this.facilityType,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
    required this.purpose,
    required this.expectedAttendees,
    required this.status,
    required this.createdAt,
    this.confirmedAt,
    this.cancelledAt,
    this.notes,
    this.totalCost,
    this.paymentStatus,
    this.bookingReference,
  });

  final String id;
  final String facilityId;
  final String facilityName;
  final FacilityType facilityType;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final DateTime bookingDate;
  final DateTime startTime;
  final DateTime endTime;
  final String purpose;
  final int expectedAttendees;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? cancelledAt;
  final String? notes;
  final double? totalCost;
  final String? paymentStatus;
  final String? bookingReference;

  /// Duration of booking in hours
  double get durationHours {
    return endTime.difference(startTime).inHours.toDouble();
  }

  /// Check if booking is active (confirmed and not completed)
  bool get isActive {
    return status == BookingStatus.confirmed &&
        DateTime.now().isBefore(endTime);
  }

  /// Check if booking is upcoming
  bool get isUpcoming {
    return status == BookingStatus.confirmed &&
        DateTime.now().isBefore(startTime);
  }

  @override
  List<Object?> get props => [
        id,
        facilityId,
        facilityName,
        facilityType,
        userId,
        userName,
        userEmail,
        userPhone,
        bookingDate,
        startTime,
        endTime,
        purpose,
        expectedAttendees,
        status,
        createdAt,
        confirmedAt,
        cancelledAt,
        notes,
        totalCost,
        paymentStatus,
        bookingReference,
      ];
}

/// Facility entity
class FacilityEntity extends Equatable {
  const FacilityEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.capacity,
    required this.location,
    required this.amenities,
    required this.hourlyRate,
    required this.isAvailable,
    required this.operatingHours,
    this.images,
    this.contactPerson,
    this.contactPhone,
    this.contactEmail,
    this.rules,
    this.bookingAdvanceDays,
  });

  final String id;
  final String name;
  final FacilityType type;
  final String description;
  final int capacity;
  final String location;
  final List<String> amenities;
  final double hourlyRate;
  final bool isAvailable;
  final Map<String, String> operatingHours; // day -> hours
  final List<String>? images;
  final String? contactPerson;
  final String? contactPhone;
  final String? contactEmail;
  final List<String>? rules;
  final int? bookingAdvanceDays;

  /// Get operating hours for a specific day
  String? getOperatingHours(String day) {
    return operatingHours[day.toLowerCase()];
  }

  /// Check if facility is open on a specific day
  bool isOpenOnDay(String day) {
    final hours = getOperatingHours(day);
    return hours != null && hours.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        description,
        capacity,
        location,
        amenities,
        hourlyRate,
        isAvailable,
        operatingHours,
        images,
        contactPerson,
        contactPhone,
        contactEmail,
        rules,
        bookingAdvanceDays,
      ];
}

/// Time slot for facility availability
class TimeSlotEntity extends Equatable {
  const TimeSlotEntity({
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    this.bookingId,
    this.bookingReference,
  });

  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
  final String? bookingId;
  final String? bookingReference;

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        isAvailable,
        bookingId,
        bookingReference,
      ];
}
