import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User model representing a citizen/resident
@JsonSerializable()
class User {
  const User({
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
  final Address address;
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    Address? address,
    String? profileImage,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, email: $email, fullName: $fullName)';
  }
}

/// Address model
@JsonSerializable()
class Address {
  const Address({
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

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  Address copyWith({
    String? street,
    String? barangay,
    String? city,
    String? province,
    String? postalCode,
    String? landmark,
  }) {
    return Address(
      street: street ?? this.street,
      barangay: barangay ?? this.barangay,
      city: city ?? this.city,
      province: province ?? this.province,
      postalCode: postalCode ?? this.postalCode,
      landmark: landmark ?? this.landmark,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address &&
        other.street == street &&
        other.barangay == barangay &&
        other.city == city &&
        other.province == province &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode {
    return Object.hash(street, barangay, city, province, postalCode);
  }

  @override
  String toString() {
    return 'Address(fullAddress: $fullAddress)';
  }
}
