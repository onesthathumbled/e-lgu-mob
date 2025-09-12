import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/models/user.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      
      // Save user to local storage
      await localDataSource.saveUser(userModel);
      await localDataSource.saveAuthToken(userModel.id);
      
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Login failed: $e');
    }
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required AddressEntity address,
  }) async {
    try {
      final userModel = await remoteDataSource.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        address: address,
      );
      
      // Save user to local storage
      await localDataSource.saveUser(userModel);
      await localDataSource.saveAuthToken(userModel.id);
      
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Registration failed: $e');
    }
  }

  @override
  Future<UserEntity> loginWithEgovPh({
    required String ssoToken,
  }) async {
    try {
      final userModel = await remoteDataSource.loginWithEgovPh(
        ssoToken: ssoToken,
      );
      
      // Save user to local storage
      await localDataSource.saveUser(userModel);
      await localDataSource.saveAuthToken(userModel.id);
      
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw UnknownFailure('eGovPH login failed: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email: email);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Password reset email failed: $e');
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Password reset failed: $e');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getCurrentUser();
      return userModel?.toEntity();
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Get current user failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.clearUser();
      await localDataSource.clearAuthToken();
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Logout failed: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await localDataSource.getAuthToken();
      return token != null;
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Check login status failed: $e');
    }
  }

  @override
  Future<UserEntity> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phoneNumber,
    AddressEntity? address,
    String? profileImage,
  }) async {
    try {
      final userModel = await remoteDataSource.updateProfile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        phoneNumber: phoneNumber,
        address: address,
        profileImage: profileImage,
      );
      
      // Update local storage
      await localDataSource.saveUser(userModel);
      
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Update profile failed: $e');
    }
  }

  @override
  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.changePassword(
        userId: userId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Change password failed: $e');
    }
  }

  @override
  Future<void> verifyEmail({
    required String userId,
    required String verificationCode,
  }) async {
    try {
      await remoteDataSource.verifyEmail(
        userId: userId,
        verificationCode: verificationCode,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Email verification failed: $e');
    }
  }

  @override
  Future<void> resendVerificationEmail({
    required String userId,
  }) async {
    try {
      await remoteDataSource.resendVerificationEmail(userId: userId);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (e) {
      throw UnknownFailure('Resend verification email failed: $e');
    }
  }
}

/// Extension to convert User model to UserEntity
extension UserModelExtension on User {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      address: address.toEntity(),
      profileImage: profileImage,
      isVerified: isVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Extension to convert Address model to AddressEntity
extension AddressModelExtension on Address {
  AddressEntity toEntity() {
    return AddressEntity(
      street: street,
      barangay: barangay,
      city: city,
      province: province,
      postalCode: postalCode,
      landmark: landmark,
    );
  }
}
