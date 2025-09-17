/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = '🇵🇭 e-LGU';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Local Government Unit Mobile Application - Serbisyong Pilipino';
  
  // Filipino Cultural Elements
  static const String filipinoGreeting = 'Mabuhay!';
  static const String filipinoTagline = 'Serbisyong Pilipino, Serbisyong Tapat';
  static const String filipinoMotto = 'Para sa Bayan, Para sa Mamamayan';
  
  // API Configuration
  static const String baseUrl = 'https://api.lgu-mobile.ph';
  static const String mockBaseUrl = 'https://mock-api.lgu-mobile.ph';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userProfileKey = 'user_profile';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String onboardingKey = 'onboarding_completed';
  static const String announcementBannerKey = 'announcement_banner_seen';
  
  // LGU Service Categories
  static const List<String> serviceCategories = [
    'Business',
    'Property',
    'Civil Registry',
    'Identification',
    'Health',
    'Social Services',
    'Community',
  ];
  
  // Business Permit Types
  static const List<String> businessPermitTypes = [
    'New Business Permit',
    'Business Permit Renewal',
    'Business Permit Amendment',
    'Business Closure',
  ];
  
  // Civil Registry Document Types
  static const List<String> civilRegistryTypes = [
    'Birth Certificate',
    'Marriage Certificate',
    'Death Certificate',
    'Certificate of No Marriage (CENOMAR)',
  ];
  
  // Property Tax Types
  static const List<String> propertyTaxTypes = [
    'Real Property Tax',
    'Business Tax',
    'Professional Tax',
    'Amusement Tax',
  ];
  
  // Permit Types
  static const List<String> permitTypes = [
    'Health Permit',
    'Sanitation Permit',
    'Work Permit',
    'Building Permit',
    'Occupancy Permit',
  ];
  
  // Social Program Types
  static const List<String> socialProgramTypes = [
    'Financial Assistance',
    'Scholarship Program',
    'Medical Assistance',
    'Training Program',
    'Livelihood Program',
  ];
  
  // Notification Types
  static const List<String> notificationTypes = [
    'Application Status',
    'Payment Reminder',
    'Document Ready',
    'Appointment',
    'Announcement',
    'Emergency Alert',
  ];
  
  // File Upload Limits
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'pdf'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];
  
  // QR Code Configuration
  static const int qrCodeSize = 200;
  static const String qrCodeErrorCorrectionLevel = 'M';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';
  
  // Currency
  static const String currencySymbol = '₱';
  static const String currencyCode = 'PHP';
  
  // Error Messages
  static const String networkErrorMessage = 'Network connection error. Please check your internet connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String unknownErrorMessage = 'An unexpected error occurred. Please try again.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  
  // Success Messages
  static const String applicationSubmittedMessage = 'Your application has been submitted successfully.';
  static const String paymentSuccessMessage = 'Payment completed successfully.';
  static const String documentReadyMessage = 'Your document is ready for pickup.';
  
  // LGU Information
  static const String lguName = 'Lungsod ng Pilipinas';
  static const String lguAddress = '123 Kalye Rizal, Lungsod ng Pilipinas, Pilipinas';
  static const String lguPhone = '+63 2 1234 5678';
  static const String lguEmail = 'info@lungsodpilipinas.gov.ph';
  static const String lguWebsite = 'https://www.lungsodpilipinas.gov.ph';
  
  // Office Hours
  static const String officeHours = 'Lunes hanggang Biyernes, 8:00 AM - 5:00 PM';
  static const String emergencyContact = '+63 2 1234 5678';
  static const String filipinoOfficeHours = 'Lunes hanggang Biyernes, 8:00 AM - 5:00 PM';
  
  // Privacy and Terms
  static const String privacyPolicyUrl = 'https://www.samplelgu.gov.ph/privacy';
  static const String termsOfServiceUrl = 'https://www.samplelgu.gov.ph/terms';
  static const String dataPrivacyUrl = 'https://www.samplelgu.gov.ph/data-privacy';
}
