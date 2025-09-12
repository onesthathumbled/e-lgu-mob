import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_providers.dart';

/// Auth state providers

/// Current user provider
final currentUserProvider = FutureProvider<UserEntity?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.getCurrentUser();
});

/// Auth state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(authRepository);
});

/// Auth state notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this._authRepository) : super(const AuthState.initial());

  final AuthRepository _authRepository;

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    
    try {
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Register new user
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required AddressEntity address,
  }) async {
    state = const AuthState.loading();
    
    try {
      final user = await _authRepository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        address: address,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Login with eGovPH SSO
  Future<void> loginWithEgovPh({
    required String ssoToken,
  }) async {
    state = const AuthState.loading();
    
    try {
      final user = await _authRepository.loginWithEgovPh(
        ssoToken: ssoToken,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    state = const AuthState.loading();
    
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
      state = const AuthState.passwordResetEmailSent();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Reset password
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    state = const AuthState.loading();
    
    try {
      await _authRepository.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      state = const AuthState.passwordResetSuccess();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    state = const AuthState.loading();
    
    try {
      await _authRepository.logout();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Update profile
  Future<void> updateProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? phoneNumber,
    AddressEntity? address,
    String? profileImage,
  }) async {
    state = const AuthState.loading();
    
    try {
      final user = await _authRepository.updateProfile(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        phoneNumber: phoneNumber,
        address: address,
        profileImage: profileImage,
      );
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Change password
  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const AuthState.loading();
    
    try {
      await _authRepository.changePassword(
        userId: userId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      state = const AuthState.passwordChanged();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Verify email
  Future<void> verifyEmail({
    required String userId,
    required String verificationCode,
  }) async {
    state = const AuthState.loading();
    
    try {
      await _authRepository.verifyEmail(
        userId: userId,
        verificationCode: verificationCode,
      );
      state = const AuthState.emailVerified();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Resend verification email
  Future<void> resendVerificationEmail({
    required String userId,
  }) async {
    state = const AuthState.loading();
    
    try {
      await _authRepository.resendVerificationEmail(userId: userId);
      state = const AuthState.verificationEmailSent();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Check if user is logged in
  Future<void> checkAuthStatus() async {
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          state = AuthState.authenticated(user);
        } else {
          state = const AuthState.unauthenticated();
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Clear error state
  void clearError() {
    if (state is AuthError) {
      state = const AuthState.unauthenticated();
    }
  }
}

/// Auth state sealed class
sealed class AuthState {
  const AuthState();

  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(UserEntity user) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.error(String message) = AuthError;
  const factory AuthState.passwordResetEmailSent() = AuthPasswordResetEmailSent;
  const factory AuthState.passwordResetSuccess() = AuthPasswordResetSuccess;
  const factory AuthState.passwordChanged() = AuthPasswordChanged;
  const factory AuthState.emailVerified() = AuthEmailVerified;
  const factory AuthState.verificationEmailSent() = AuthVerificationEmailSent;
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final UserEntity user;
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
}

class AuthPasswordResetEmailSent extends AuthState {
  const AuthPasswordResetEmailSent();
}

class AuthPasswordResetSuccess extends AuthState {
  const AuthPasswordResetSuccess();
}

class AuthPasswordChanged extends AuthState {
  const AuthPasswordChanged();
}

class AuthEmailVerified extends AuthState {
  const AuthEmailVerified();
}

class AuthVerificationEmailSent extends AuthState {
  const AuthVerificationEmailSent();
}
