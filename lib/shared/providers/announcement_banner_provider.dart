import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

/// Announcement banner state
class AnnouncementBannerState {
  final bool isVisible;
  final String title;
  final String description;
  final String? actionText;
  final String? actionUrl;

  const AnnouncementBannerState({
    required this.isVisible,
    required this.title,
    required this.description,
    this.actionText,
    this.actionUrl,
  });

  AnnouncementBannerState copyWith({
    bool? isVisible,
    String? title,
    String? description,
    String? actionText,
    String? actionUrl,
  }) {
    return AnnouncementBannerState(
      isVisible: isVisible ?? this.isVisible,
      title: title ?? this.title,
      description: description ?? this.description,
      actionText: actionText ?? this.actionText,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }
}

/// Announcement banner notifier
class AnnouncementBannerNotifier extends StateNotifier<AnnouncementBannerState> {
  final SharedPreferences _sharedPreferences;

  AnnouncementBannerNotifier(this._sharedPreferences)
      : super(
          const AnnouncementBannerState(
            isVisible: true,
            title: '🎉 Welcome to e-LGU!',
            description: 'Discover new features and services available in your local government unit. Stay connected with your community!',
            actionText: 'Learn More',
            actionUrl: '/services',
          ),
        ) {
    _loadBannerState();
  }

  /// Load banner state from SharedPreferences
  Future<void> _loadBannerState() async {
    final hasSeenBanner = _sharedPreferences.getBool(AppConstants.announcementBannerKey) ?? false;
    
    if (hasSeenBanner) {
      state = state.copyWith(isVisible: false);
    }
  }

  /// Dismiss the banner (mark as seen)
  Future<void> dismissBanner() async {
    await _sharedPreferences.setBool(AppConstants.announcementBannerKey, true);
    state = state.copyWith(isVisible: false);
  }

  /// Reset the banner to show again
  Future<void> resetBanner() async {
    await _sharedPreferences.setBool(AppConstants.announcementBannerKey, false);
    state = state.copyWith(isVisible: true);
  }

  /// Update banner content
  void updateBannerContent({
    required String title,
    required String description,
    String? actionText,
    String? actionUrl,
  }) {
    state = state.copyWith(
      title: title,
      description: description,
      actionText: actionText,
      actionUrl: actionUrl,
    );
  }

  /// Show banner with custom content
  Future<void> showCustomBanner({
    required String title,
    required String description,
    String? actionText,
    String? actionUrl,
  }) async {
    await _sharedPreferences.setBool(AppConstants.announcementBannerKey, false);
    state = state.copyWith(
      isVisible: true,
      title: title,
      description: description,
      actionText: actionText,
      actionUrl: actionUrl,
    );
  }
}

/// Announcement banner provider
final announcementBannerProvider = StateNotifierProvider<AnnouncementBannerNotifier, AnnouncementBannerState>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return AnnouncementBannerNotifier(sharedPreferences);
});
