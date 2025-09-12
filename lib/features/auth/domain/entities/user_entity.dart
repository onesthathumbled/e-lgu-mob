import 'package:equatable/equatable.dart';

/// User entity for authentication
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
    this.profileImage,
    this.isVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final AddressEntity address;
  final String? profileImage;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Full name getter
  String get fullName {
    if (middleName != null && middleName!.isNotEmpty) {
      return '$firstName $middleName $lastName';
    }
    return '$firstName $lastName';
  }

  /// Age getter
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        middleName,
        phoneNumber,
        dateOfBirth,
        address,
        profileImage,
        isVerified,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, fullName: $fullName)';
  }
}

/// Address entity
class AddressEntity extends Equatable {
  const AddressEntity({
    required this.street,
    required this.barangay,
    required this.city,
    required this.province,
    required this.postalCode,
    this.landmark,
  });

  final String street;
  final String barangay;
  final String city;
  final String province;
  final String postalCode;
  final String? landmark;

  /// Full address getter
  String get fullAddress {
    final parts = [street, barangay, city, province, postalCode];
    if (landmark != null && landmark!.isNotEmpty) {
      parts.insert(1, 'Near $landmark');
    }
    return parts.join(', ');
  }

  @override
  List<Object?> get props => [street, barangay, city, province, postalCode, landmark];

  @override
  String toString() {
    return 'AddressEntity(fullAddress: $fullAddress)';
  }
}
