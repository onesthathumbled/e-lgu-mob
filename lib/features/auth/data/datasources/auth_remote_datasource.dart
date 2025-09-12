import '../../../../core/errors/exceptions.dart';
import '../../../../shared/models/user.dart';
import '../../domain/entities/user_entity.dart';
// Mock data will be imported from shared models

/// Abstract remote data source for authentication
abstract class AuthRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required AddressEntity address,
  });

  Future<User> loginWithEgovPh({
    required String ssoToken,
  });

  Future<void> sendPasswordResetEmail({
    required String email,
  });

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<User> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phoneNumber,
    AddressEntity? address,
    String? profileImage,
  });

  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  });

  Future<void> verifyEmail({
    required String userId,
    required String verificationCode,
  });

  Future<void> resendVerificationEmail({
    required String userId,
  });
}

/// Implementation of AuthRemoteDataSource with mock data
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      throw const ValidationException('Email and password are required');
    }

    if (email != 'john.doe@email.com' || password != 'password123') {
      throw const AuthException('Invalid email or password');
    }

    // Return mock user data
    final userData = {
      'id': 'user_001',
      'email': 'john.doe@email.com',
      'firstName': 'John',
      'lastName': 'Doe',
      'middleName': 'Michael',
      'phoneNumber': '+63 912 345 6789',
      'dateOfBirth': '1990-05-15',
      'address': {
        'street': '123 Main Street',
        'barangay': 'Barangay 1',
        'city': 'Sample City',
        'province': 'Sample Province',
        'postalCode': '1234',
        'landmark': 'Near City Hall',
      },
      'profileImage': null,
      'isVerified': true,
      'createdAt': '2024-01-01T00:00:00Z',
      'updatedAt': '2024-01-15T10:30:00Z',
    };
    return User.fromJson(userData);
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required AddressEntity address,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock validation
    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      throw const ValidationException('All required fields must be filled');
    }

    if (password.length < 8) {
      throw const ValidationException('Password must be at least 8 characters long');
    }

    // Check if email already exists (mock)
    if (email == 'john.doe@email.com') {
      throw const ValidationException('Email already exists');
    }

    // Create new user
    final userData = {
      'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'address': {
        'street': address.street,
        'barangay': address.barangay,
        'city': address.city,
        'province': address.province,
        'postalCode': address.postalCode,
        'landmark': address.landmark,
      },
      'profileImage': null,
      'isVerified': false,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    return User.fromJson(userData);
  }

  @override
  Future<User> loginWithEgovPh({
    required String ssoToken,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock eGovPH SSO validation
    if (ssoToken.isEmpty) {
      throw const AuthException('Invalid SSO token');
    }

    // Return mock user data
    final userData = {
      'id': 'user_001',
      'email': 'john.doe@email.com',
      'firstName': 'John',
      'lastName': 'Doe',
      'middleName': 'Michael',
      'phoneNumber': '+63 912 345 6789',
      'dateOfBirth': '1990-05-15',
      'address': {
        'street': '123 Main Street',
        'barangay': 'Barangay 1',
        'city': 'Sample City',
        'province': 'Sample Province',
        'postalCode': '1234',
        'landmark': 'Near City Hall',
      },
      'profileImage': null,
      'isVerified': true,
      'createdAt': '2024-01-01T00:00:00Z',
      'updatedAt': '2024-01-15T10:30:00Z',
    };
    return User.fromJson(userData);
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (email.isEmpty) {
      throw const ValidationException('Email is required');
    }

    // Mock email sending
    if (email != 'john.doe@email.com') {
      throw const ServerException('Email not found');
    }

    // In real implementation, this would send an email
    // For now, we just simulate success
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (token.isEmpty || newPassword.isEmpty) {
      throw const ValidationException('Token and new password are required');
    }

    if (newPassword.length < 8) {
      throw const ValidationException('Password must be at least 8 characters long');
    }

    // Mock token validation
    if (token != 'valid_reset_token') {
      throw const AuthException('Invalid or expired reset token');
    }

    // In real implementation, this would update the password
    // For now, we just simulate success
  }

  @override
  Future<User> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phoneNumber,
    AddressEntity? address,
    String? profileImage,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Get current user data
    final userData = {
      'id': 'user_001',
      'email': 'john.doe@email.com',
      'firstName': 'John',
      'lastName': 'Doe',
      'middleName': 'Michael',
      'phoneNumber': '+63 912 345 6789',
      'dateOfBirth': '1990-05-15',
      'address': {
        'street': '123 Main Street',
        'barangay': 'Barangay 1',
        'city': 'Sample City',
        'province': 'Sample Province',
        'postalCode': '1234',
        'landmark': 'Near City Hall',
      },
      'profileImage': null,
      'isVerified': true,
      'createdAt': '2024-01-01T00:00:00Z',
      'updatedAt': '2024-01-15T10:30:00Z',
    };
    
    // Update fields if provided
    if (firstName != null) userData['firstName'] = firstName;
    if (lastName != null) userData['lastName'] = lastName;
    if (middleName != null) userData['middleName'] = middleName;
    if (phoneNumber != null) userData['phoneNumber'] = phoneNumber;
    if (profileImage != null) userData['profileImage'] = profileImage;
    if (address != null) {
      userData['address'] = {
        'street': address.street,
        'barangay': address.barangay,
        'city': address.city,
        'province': address.province,
        'postalCode': address.postalCode,
        'landmark': address.landmark,
      };
    }
    
    userData['updatedAt'] = DateTime.now().toIso8601String();

    return User.fromJson(userData);
  }

  @override
  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (currentPassword.isEmpty || newPassword.isEmpty) {
      throw const ValidationException('Current and new passwords are required');
    }

    if (newPassword.length < 8) {
      throw const ValidationException('New password must be at least 8 characters long');
    }

    // Mock current password validation
    if (currentPassword != 'password123') {
      throw const AuthException('Current password is incorrect');
    }

    // In real implementation, this would update the password
    // For now, we just simulate success
  }

  @override
  Future<void> verifyEmail({
    required String userId,
    required String verificationCode,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (verificationCode.isEmpty) {
      throw const ValidationException('Verification code is required');
    }

    // Mock verification code validation
    if (verificationCode != '123456') {
      throw const AuthException('Invalid verification code');
    }

    // In real implementation, this would verify the email
    // For now, we just simulate success
  }

  @override
  Future<void> resendVerificationEmail({
    required String userId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // In real implementation, this would resend verification email
    // For now, we just simulate success
  }
}
