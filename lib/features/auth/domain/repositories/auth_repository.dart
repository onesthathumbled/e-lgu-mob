import '../entities/user_entity.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<UserEntity> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required AddressEntity address,
  });

  /// Login with eGovPH SSO
  Future<UserEntity> loginWithEgovPh({
    required String ssoToken,
  });

  /// Send password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  });

  /// Reset password with token
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Get current user
  Future<UserEntity?> getCurrentUser();

  /// Logout current user
  Future<void> logout();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Update user profile
  Future<UserEntity> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phoneNumber,
    AddressEntity? address,
    String? profileImage,
  });

  /// Change password
  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  });

  /// Verify email
  Future<void> verifyEmail({
    required String userId,
    required String verificationCode,
  });

  /// Resend verification email
  Future<void> resendVerificationEmail({
    required String userId,
  });
}
