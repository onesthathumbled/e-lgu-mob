/// Base class for all exceptions in the application
abstract class AppException implements Exception {
  const AppException([this.message]);
  
  final String? message;
  
  @override
  String toString() => message ?? 'An unexpected error occurred';
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException([super.message]);
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException([super.message]);
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException([super.message]);
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException([super.message]);
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException([super.message]);
}

/// Permission-related exceptions
class PermissionException extends AppException {
  const PermissionException([super.message]);
}

/// File-related exceptions
class FileException extends AppException {
  const FileException([super.message]);
}

/// Payment-related exceptions
class PaymentException extends AppException {
  const PaymentException([super.message]);
}

/// Document-related exceptions
class DocumentException extends AppException {
  const DocumentException([super.message]);
}

/// Generic exception for unexpected errors
class UnknownException extends AppException {
  const UnknownException([super.message]);
}
