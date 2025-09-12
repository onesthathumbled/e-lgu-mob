import 'package:equatable/equatable.dart';

/// Pet types
enum PetType {
  dog,
  cat,
  bird,
  fish,
  rabbit,
  hamster,
  guineaPig,
  reptile,
  other,
}

/// Pet gender
enum PetGender {
  male,
  female,
  unknown,
}

/// Pet size
enum PetSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Registration status
enum PetRegistrationStatus {
  pending,
  approved,
  rejected,
  expired,
  renewed,
}

/// Pet entity
class PetEntity extends Equatable {
  const PetEntity({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.ownerAddress,
    required this.name,
    required this.type,
    required this.breed,
    required this.gender,
    required this.size,
    required this.birthDate,
    required this.color,
    required this.microchipId,
    required this.registrationNumber,
    required this.registrationDate,
    required this.expiryDate,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.description,
    this.specialNeeds,
    this.medicalConditions,
    this.emergencyContact,
    this.photoUrl,
    this.qrCodeData,
    this.vaccinationRecords,
    this.sterilizationStatus,
    this.sterilizationDate,
    this.notes,
  });

  final String id;
  final String ownerId;
  final String ownerName;
  final String ownerEmail;
  final String ownerPhone;
  final String ownerAddress;
  final String name;
  final PetType type;
  final String breed;
  final PetGender gender;
  final PetSize size;
  final DateTime birthDate;
  final String color;
  final String microchipId;
  final String registrationNumber;
  final DateTime registrationDate;
  final DateTime expiryDate;
  final PetRegistrationStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? description;
  final String? specialNeeds;
  final String? medicalConditions;
  final String? emergencyContact;
  final String? photoUrl;
  final String? qrCodeData;
  final List<VaccinationRecordEntity>? vaccinationRecords;
  final bool? sterilizationStatus;
  final DateTime? sterilizationDate;
  final String? notes;

  /// Pet age in years
  double get ageInYears {
    final now = DateTime.now();
    final age = now.difference(birthDate).inDays / 365.25;
    return age;
  }

  /// Check if registration is expired
  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }

  /// Check if registration is expiring soon (within 30 days)
  bool get isExpiringSoon {
    final thirtyDaysFromNow = DateTime.now().add(const Duration(days: 30));
    return expiryDate.isBefore(thirtyDaysFromNow) && !isExpired;
  }

  /// Check if pet is up to date on vaccinations
  bool get isUpToDateOnVaccinations {
    if (vaccinationRecords == null || vaccinationRecords!.isEmpty) {
      return false;
    }
    
    final now = DateTime.now();
    return vaccinationRecords!.any((record) => 
      record.isRequired && 
      record.nextDueDate.isAfter(now)
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        ownerName,
        ownerEmail,
        ownerPhone,
        ownerAddress,
        name,
        type,
        breed,
        gender,
        size,
        birthDate,
        color,
        microchipId,
        registrationNumber,
        registrationDate,
        expiryDate,
        status,
        createdAt,
        updatedAt,
        description,
        specialNeeds,
        medicalConditions,
        emergencyContact,
        photoUrl,
        qrCodeData,
        vaccinationRecords,
        sterilizationStatus,
        sterilizationDate,
        notes,
      ];
}

/// Vaccination record entity
class VaccinationRecordEntity extends Equatable {
  const VaccinationRecordEntity({
    required this.id,
    required this.petId,
    required this.vaccineName,
    required this.vaccineType,
    required this.administeredDate,
    required this.nextDueDate,
    required this.isRequired,
    required this.veterinarianName,
    required this.veterinarianLicense,
    required this.clinicName,
    required this.clinicAddress,
    this.batchNumber,
    this.notes,
    this.certificateUrl,
  });

  final String id;
  final String petId;
  final String vaccineName;
  final String vaccineType;
  final DateTime administeredDate;
  final DateTime nextDueDate;
  final bool isRequired;
  final String veterinarianName;
  final String veterinarianLicense;
  final String clinicName;
  final String clinicAddress;
  final String? batchNumber;
  final String? notes;
  final String? certificateUrl;

  /// Check if vaccination is due
  bool get isDue {
    return DateTime.now().isAfter(nextDueDate);
  }

  /// Check if vaccination is due soon (within 30 days)
  bool get isDueSoon {
    final thirtyDaysFromNow = DateTime.now().add(const Duration(days: 30));
    return nextDueDate.isBefore(thirtyDaysFromNow) && !isDue;
  }

  @override
  List<Object?> get props => [
        id,
        petId,
        vaccineName,
        vaccineType,
        administeredDate,
        nextDueDate,
        isRequired,
        veterinarianName,
        veterinarianLicense,
        clinicName,
        clinicAddress,
        batchNumber,
        notes,
        certificateUrl,
      ];
}

/// Lost pet report entity
class LostPetReportEntity extends Equatable {
  const LostPetReportEntity({
    required this.id,
    required this.petId,
    required this.ownerId,
    required this.reportDate,
    required this.lastSeenDate,
    required this.lastSeenLocation,
    required this.description,
    required this.contactPhone,
    required this.contactEmail,
    required this.isResolved,
    this.resolvedDate,
    this.foundLocation,
    this.finderContact,
    this.reward,
    this.images,
  });

  final String id;
  final String petId;
  final String ownerId;
  final DateTime reportDate;
  final DateTime lastSeenDate;
  final String lastSeenLocation;
  final String description;
  final String contactPhone;
  final String contactEmail;
  final bool isResolved;
  final DateTime? resolvedDate;
  final String? foundLocation;
  final String? finderContact;
  final double? reward;
  final List<String>? images;

  /// Days since pet was lost
  int get daysLost {
    return DateTime.now().difference(lastSeenDate).inDays;
  }

  @override
  List<Object?> get props => [
        id,
        petId,
        ownerId,
        reportDate,
        lastSeenDate,
        lastSeenLocation,
        description,
        contactPhone,
        contactEmail,
        isResolved,
        resolvedDate,
        foundLocation,
        finderContact,
        reward,
        images,
      ];
}
