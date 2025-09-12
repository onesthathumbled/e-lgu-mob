import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../shared/models/user.dart';

/// Abstract local data source for authentication
abstract class AuthLocalDataSource {
  Future<User?> getCurrentUser();
  Future<void> saveUser(User user);
  Future<void> clearUser();
  
  Future<String?> getAuthToken();
  Future<void> saveAuthToken(String token);
  Future<void> clearAuthToken();
  
  Future<bool> isFirstTime();
  Future<void> setFirstTime(bool isFirstTime);
  
  Future<String?> getOnboardingCompleted();
  Future<void> setOnboardingCompleted();
}

/// Implementation of AuthLocalDataSource using SharedPreferences
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userJson = sharedPreferences.getString(AppConstants.userProfileKey);
      if (userJson == null) return null;
      
      // In a real app, you would parse the JSON
      // For now, return mock user data
      return User.fromJson({
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
      });
    } catch (e) {
      throw CacheException('Failed to get current user: $e');
    }
  }

  @override
  Future<void> saveUser(User user) async {
    try {
      final userJson = user.toJson();
      await sharedPreferences.setString(
        AppConstants.userProfileKey,
        userJson.toString(),
      );
    } catch (e) {
      throw CacheException('Failed to save user: $e');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await sharedPreferences.remove(AppConstants.userProfileKey);
    } catch (e) {
      throw CacheException('Failed to clear user: $e');
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      return sharedPreferences.getString(AppConstants.userTokenKey);
    } catch (e) {
      throw CacheException('Failed to get auth token: $e');
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.userTokenKey, token);
    } catch (e) {
      throw CacheException('Failed to save auth token: $e');
    }
  }

  @override
  Future<void> clearAuthToken() async {
    try {
      await sharedPreferences.remove(AppConstants.userTokenKey);
    } catch (e) {
      throw CacheException('Failed to clear auth token: $e');
    }
  }

  @override
  Future<bool> isFirstTime() async {
    try {
      return !sharedPreferences.containsKey(AppConstants.onboardingKey);
    } catch (e) {
      throw CacheException('Failed to check first time: $e');
    }
  }

  @override
  Future<void> setFirstTime(bool isFirstTime) async {
    try {
      if (isFirstTime) {
        await sharedPreferences.remove(AppConstants.onboardingKey);
      } else {
        await sharedPreferences.setBool(AppConstants.onboardingKey, true);
      }
    } catch (e) {
      throw CacheException('Failed to set first time: $e');
    }
  }

  @override
  Future<String?> getOnboardingCompleted() async {
    try {
      final completed = sharedPreferences.getBool(AppConstants.onboardingKey);
      return completed == true ? 'completed' : null;
    } catch (e) {
      throw CacheException('Failed to get onboarding status: $e');
    }
  }

  @override
  Future<void> setOnboardingCompleted() async {
    try {
      await sharedPreferences.setBool(AppConstants.onboardingKey, true);
    } catch (e) {
      throw CacheException('Failed to set onboarding completed: $e');
    }
  }
}
