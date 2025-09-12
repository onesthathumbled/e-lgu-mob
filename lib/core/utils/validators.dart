/// Utility class for form validation
class Validators {
  /// Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
  
  /// Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (value.length > 128) {
      return 'Password must be less than 128 characters';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }
  
  /// Phone number validation (Philippines)
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return 'Please enter a valid phone number';
    }
    
    // Check if it starts with 09 (mobile) or 02 (landline)
    if (!digitsOnly.startsWith('09') && !digitsOnly.startsWith('02')) {
      return 'Please enter a valid Philippine phone number';
    }
    
    return null;
  }
  
  /// Required field validation
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }
  
  /// Minimum length validation
  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }
    
    return null;
  }
  
  /// Maximum length validation
  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'This field'} must be less than $maxLength characters';
    }
    return null;
  }
  
  /// Numeric validation
  static String? numeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    return null;
  }
  
  /// Positive number validation
  static String? positiveNumber(String? value, [String? fieldName]) {
    final numericError = numeric(value, fieldName);
    if (numericError != null) return numericError;
    
    final num = double.parse(value!);
    if (num <= 0) {
      return '${fieldName ?? 'This field'} must be greater than 0';
    }
    
    return null;
  }
  
  /// Date validation
  static String? date(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Date'} is required';
    }
    
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Please enter a valid date';
    }
  }
  
  /// Future date validation
  static String? futureDate(String? value, [String? fieldName]) {
    final dateError = date(value, fieldName);
    if (dateError != null) return dateError;
    
    final selectedDate = DateTime.parse(value!);
    final now = DateTime.now();
    
    if (selectedDate.isBefore(now)) {
      return '${fieldName ?? 'Date'} must be in the future';
    }
    
    return null;
  }
  
  /// Past date validation
  static String? pastDate(String? value, [String? fieldName]) {
    final dateError = date(value, fieldName);
    if (dateError != null) return dateError;
    
    final selectedDate = DateTime.parse(value!);
    final now = DateTime.now();
    
    if (selectedDate.isAfter(now)) {
      return '${fieldName ?? 'Date'} must be in the past';
    }
    
    return null;
  }
  
  /// Confirm password validation
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  /// Philippine postal code validation
  static String? postalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Postal code is required';
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length != 4) {
      return 'Please enter a valid 4-digit postal code';
    }
    
    return null;
  }
  
  /// Business name validation
  static String? businessName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Business name must be at least 2 characters long';
    }
    
    if (value.trim().length > 100) {
      return 'Business name must be less than 100 characters';
    }
    
    return null;
  }
  
  /// TIN (Tax Identification Number) validation
  static String? tin(String? value) {
    if (value == null || value.isEmpty) {
      return 'TIN is required';
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length != 9 && digitsOnly.length != 12) {
      return 'TIN must be 9 or 12 digits';
    }
    
    return null;
  }
  
  /// SSS number validation
  static String? sssNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'SSS number is required';
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length != 10) {
      return 'SSS number must be 10 digits';
    }
    
    return null;
  }
  
  /// PhilHealth number validation
  static String? philHealthNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'PhilHealth number is required';
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digitsOnly.length != 12) {
      return 'PhilHealth number must be 12 digits';
    }
    
    return null;
  }
}
