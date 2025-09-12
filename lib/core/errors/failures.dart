import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure([this.message]);
  
  final String? message;
  
  @override
  List<Object?> get props => [message];
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure([super.message]);
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure([super.message]);
}

/// Permission-related failures
class PermissionFailure extends Failure {
  const PermissionFailure([super.message]);
}

/// File-related failures
class FileFailure extends Failure {
  const FileFailure([super.message]);
}

/// Payment-related failures
class PaymentFailure extends Failure {
  const PaymentFailure([super.message]);
}

/// Document-related failures
class DocumentFailure extends Failure {
  const DocumentFailure([super.message]);
}

/// Generic failure for unexpected errors
class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
