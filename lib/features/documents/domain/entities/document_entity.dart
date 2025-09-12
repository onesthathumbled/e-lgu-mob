import 'package:equatable/equatable.dart';

/// Document entity
class DocumentEntity extends Equatable {
  const DocumentEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.filePath,
    this.fileSize,
    this.qrCode,
    this.signature,
    this.template,
    this.metadata,
  });

  final String id;
  final String title;
  final DocumentType type;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? filePath;
  final int? fileSize;
  final String? qrCode;
  final String? signature;
  final String? template;
  final Map<String, dynamic>? metadata;

  /// File size in MB
  double? get fileSizeInMB {
    if (fileSize == null) return null;
    return fileSize! / (1024 * 1024);
  }

  /// Is document signed
  bool get isSigned => signature != null;

  /// Is document generated
  bool get isGenerated => filePath != null;

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        content,
        createdAt,
        updatedAt,
        filePath,
        fileSize,
        qrCode,
        signature,
        template,
        metadata,
      ];

  @override
  String toString() {
    return 'DocumentEntity(id: $id, title: $title, type: $type)';
  }
}

/// Document type enum
enum DocumentType {
  receipt,
  certificate,
  permit,
  id,
  invoice,
  report,
  letter,
  other,
}

/// Document template enum
enum DocumentTemplate {
  businessPermit,
  propertyTaxReceipt,
  digitalId,
  birthCertificate,
  marriageCertificate,
  deathCertificate,
  healthPermit,
  workPermit,
  socialProgramCertificate,
  generalReceipt,
}
