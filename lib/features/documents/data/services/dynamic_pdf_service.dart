import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../shared/models/user.dart';
import '../../domain/entities/document_entity.dart';

/// Dynamic PDF service for generating PDFs based on user details and templates
class DynamicPdfService {
  static final DynamicPdfService _instance = DynamicPdfService._internal();
  factory DynamicPdfService() => _instance;
  DynamicPdfService._internal();

  /// Generate a PDF document based on user details and template
  Future<DocumentEntity> generateUserDocument({
    required User user,
    required PdfTemplate template,
    Map<String, dynamic>? additionalData,
    String? customTitle,
  }) async {
    final pdf = pw.Document();
    
    // Generate QR code data
    final qrCodeData = _generateQrCodeData(user, template);
    
    // Add content based on template
    switch (template) {
      case PdfTemplate.solidWasteForm:
        pdf.addPage(_buildSolidWasteFormPage(user, additionalData, qrCodeData));
        break;
      case PdfTemplate.barangayClearance:
        pdf.addPage(_buildBarangayClearancePage(user, additionalData, qrCodeData));
        break;
      case PdfTemplate.certificateOfResidency:
        pdf.addPage(_buildCertificateOfResidencyPage(user, additionalData, qrCodeData));
        break;
      case PdfTemplate.incomeCertificate:
        pdf.addPage(_buildIncomeCertificatePage(user, additionalData, qrCodeData));
        break;
      case PdfTemplate.goodMoralCertificate:
        pdf.addPage(_buildGoodMoralCertificatePage(user, additionalData, qrCodeData));
        break;
      case PdfTemplate.businessClearance:
        pdf.addPage(_buildBusinessClearancePage(user, additionalData, qrCodeData));
        break;
    }

    // Save PDF to file
    final title = customTitle ?? _getDefaultTitle(template, user);
    final file = await _savePdfToFile(pdf, title);
    
    // Get PDF bytes for web compatibility
    final pdfBytes = await pdf.save();
    
    return DocumentEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      type: _getDocumentType(template),
      content: _getDefaultContent(template, user),
      createdAt: DateTime.now(),
      filePath: file.path,
      fileSize: kIsWeb ? pdfBytes.length : await file.length(),
      qrCode: qrCodeData,
      template: template.name,
      metadata: {
        'user_id': user.id,
        'user_name': user.fullName,
        'template': template.name,
        'generated_at': DateTime.now().toIso8601String(),
        'pdfBytes': pdfBytes, // Store bytes for web compatibility
        ...?additionalData,
      },
    );
  }

  /// Build Solid Waste Form page (based on the provided template)
  pw.Page _buildSolidWasteFormPage(User user, Map<String, dynamic>? additionalData, String qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header with LGU Logo and Title
            _buildSolidWasteHeader(),
            
            pw.SizedBox(height: 20),
            
            // Form Title
            pw.Center(
              child: pw.Text(
                'SOLID WASTE MANAGEMENT FORM',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Personal Information Section
            _buildPersonalInfoSection(user),
            
            pw.SizedBox(height: 15),
            
            // Address Information
            _buildAddressSection(user),
            
            pw.SizedBox(height: 15),
            
            // Waste Management Information
            _buildWasteManagementSection(additionalData),
            
            pw.SizedBox(height: 15),
            
            // Signature Section
            _buildSignatureSection(),
            
            pw.SizedBox(height: 20),
            
            // Footer with QR Code
            _buildFooterWithQrCode(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build Barangay Clearance page
  pw.Page _buildBarangayClearancePage(User user, Map<String, dynamic>? additionalData, String qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader('BARANGAY CLEARANCE', '${user.address.barangay} Barangay Hall'),
            
            pw.SizedBox(height: 20),
            
            pw.Center(
              child: pw.Text(
                'BARANGAY CLEARANCE',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This is to certify that ${user.fullName}, ${user.age} years old, single/married, Filipino citizen, and a resident of ${user.address.street}, ${user.address.barangay}, ${user.address.city}, ${user.address.province}, is known to be of good moral character and has no derogatory record in this barangay.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This certification is issued upon the request of the above-named person for whatever legal purpose it may serve.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 30),
            
            _buildSignatureSection(),
            
            pw.SizedBox(height: 20),
            
            _buildFooterWithQrCode(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build Certificate of Residency page
  pw.Page _buildCertificateOfResidencyPage(User user, Map<String, dynamic>? additionalData, String qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader('CERTIFICATE OF RESIDENCY', '${user.address.barangay} Barangay Hall'),
            
            pw.SizedBox(height: 20),
            
            pw.Center(
              child: pw.Text(
                'CERTIFICATE OF RESIDENCY',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This is to certify that ${user.fullName}, ${user.age} years old, is a bona fide resident of ${user.address.street}, ${user.address.barangay}, ${user.address.city}, ${user.address.province} and has been residing in this barangay for the past ${additionalData?['years_of_residency'] ?? '5'} years.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This certification is issued upon the request of the above-named person for whatever legal purpose it may serve.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 30),
            
            _buildSignatureSection(),
            
            pw.SizedBox(height: 20),
            
            _buildFooterWithQrCode(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build Income Certificate page
  pw.Page _buildIncomeCertificatePage(User user, Map<String, dynamic>? additionalData, String qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader('INCOME CERTIFICATE', '${user.address.barangay} Barangay Hall'),
            
            pw.SizedBox(height: 20),
            
            pw.Center(
              child: pw.Text(
                'INCOME CERTIFICATE',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This is to certify that ${user.fullName}, ${user.age} years old, resident of ${user.address.street}, ${user.address.barangay}, ${user.address.city}, ${user.address.province}, has an estimated monthly income of ₱${additionalData?['monthly_income'] ?? '15,000.00'}.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This certification is issued upon the request of the above-named person for whatever legal purpose it may serve.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 30),
            
            _buildSignatureSection(),
            
            pw.SizedBox(height: 20),
            
            _buildFooterWithQrCode(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build Good Moral Certificate page
  pw.Page _buildGoodMoralCertificatePage(User user, Map<String, dynamic>? additionalData, String qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader('GOOD MORAL CERTIFICATE', '${user.address.barangay} Barangay Hall'),
            
            pw.SizedBox(height: 20),
            
            pw.Center(
              child: pw.Text(
                'GOOD MORAL CERTIFICATE',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This is to certify that ${user.fullName}, ${user.age} years old, resident of ${user.address.street}, ${user.address.barangay}, ${user.address.city}, ${user.address.province}, is known to be of good moral character and has no derogatory record in this barangay.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This certification is issued upon the request of the above-named person for whatever legal purpose it may serve.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 30),
            
            _buildSignatureSection(),
            
            pw.SizedBox(height: 20),
            
            _buildFooterWithQrCode(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build Business Clearance page
  pw.Page _buildBusinessClearancePage(User user, Map<String, dynamic>? additionalData, String qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader('BUSINESS CLEARANCE', '${user.address.barangay} Barangay Hall'),
            
            pw.SizedBox(height: 20),
            
            pw.Center(
              child: pw.Text(
                'BUSINESS CLEARANCE',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            pw.Text(
              'This is to certify that ${user.fullName}, ${user.age} years old, resident of ${user.address.street}, ${user.address.barangay}, ${user.address.city}, ${user.address.province}, is cleared to operate a business in this barangay.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 20),
            
            if (additionalData != null) ...[
              pw.Text('Business Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(additionalData),
              pw.SizedBox(height: 20),
            ],
            
            pw.Text(
              'This certification is issued upon the request of the above-named person for whatever legal purpose it may serve.',
              textAlign: pw.TextAlign.justify,
            ),
            
            pw.SizedBox(height: 30),
            
            _buildSignatureSection(),
            
            pw.SizedBox(height: 20),
            
            _buildFooterWithQrCode(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build Solid Waste Form Header
  pw.Widget _buildSolidWasteHeader() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue.shade(0.1),
        border: pw.Border.all(color: PdfColors.blue),
      ),
      child: pw.Row(
        children: [
          // LGU Logo placeholder
          pw.Container(
            width: 80,
            height: 80,
            decoration: pw.BoxDecoration(
              color: PdfColors.blue.shade(0.2),
              border: pw.Border.all(color: PdfColors.blue),
            ),
            child: pw.Center(
              child: pw.Text(
                'LGU\nLOGO',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue.shade(0.8),
                ),
              ),
            ),
          ),
          
          pw.SizedBox(width: 20),
          
          // LGU Information
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'REPUBLIC OF THE PHILIPPINES',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue.shade(0.8),
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'CITY OF SAMPLE',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue.shade(0.8),
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'BARANGAY SAMPLE',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue.shade(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Personal Information Section
  pw.Widget _buildPersonalInfoSection(User user) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey.shade(0.3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'PERSONAL INFORMATION',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          _buildInfoRow('Full Name:', user.fullName),
          _buildInfoRow('Date of Birth:', _formatDate(user.dateOfBirth)),
          _buildInfoRow('Age:', '${user.age} years old'),
          _buildInfoRow('Contact Number:', user.phoneNumber),
          _buildInfoRow('Email:', user.email),
        ],
      ),
    );
  }

  /// Build Address Section
  pw.Widget _buildAddressSection(User user) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey.shade(0.3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'ADDRESS INFORMATION',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          _buildInfoRow('Street:', user.address.street),
          _buildInfoRow('Barangay:', user.address.barangay),
          _buildInfoRow('City:', user.address.city),
          _buildInfoRow('Province:', user.address.province),
          _buildInfoRow('Postal Code:', user.address.postalCode),
          if (user.address.landmark != null)
            _buildInfoRow('Landmark:', user.address.landmark!),
        ],
      ),
    );
  }

  /// Build Waste Management Section
  pw.Widget _buildWasteManagementSection(Map<String, dynamic>? additionalData) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey.shade(0.3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'WASTE MANAGEMENT INFORMATION',
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          _buildInfoRow('Waste Collection Schedule:', additionalData?['collection_schedule'] ?? 'Every Tuesday and Friday'),
          _buildInfoRow('Waste Segregation:', additionalData?['segregation'] ?? 'Yes, properly segregated'),
          _buildInfoRow('Composting Practice:', additionalData?['composting'] ?? 'Yes, organic waste composting'),
          _buildInfoRow('Recycling Participation:', additionalData?['recycling'] ?? 'Yes, actively participating'),
          _buildInfoRow('Special Waste Disposal:', additionalData?['special_waste'] ?? 'Properly disposed at designated areas'),
        ],
      ),
    );
  }

  /// Build Signature Section
  pw.Widget _buildSignatureSection() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          children: [
            pw.SizedBox(height: 50),
            pw.Container(
              width: 200,
              height: 1,
              color: PdfColors.black,
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              'Applicant\'s Signature',
              style: pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
        pw.Column(
          children: [
            pw.SizedBox(height: 50),
            pw.Container(
              width: 200,
              height: 1,
              color: PdfColors.black,
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              'Barangay Captain',
              style: pw.TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  /// Build Footer with QR Code
  pw.Widget _buildFooterWithQrCode(String qrCodeData) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey.shade(0.1),
        border: pw.Border.all(color: PdfColors.grey.shade(0.3)),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'This is an official document generated by e-LGU',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey.shade(0.6),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Generated on: ${_formatDate(DateTime.now())}',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey.shade(0.6),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Center(
            child: pw.Container(
              width: 80,
              height: 80,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Center(
                child: pw.Text('QR\nCODE', 
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build header section
  pw.Widget _buildHeader(String title, String department) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue.shade(0.1),
        border: pw.Border.all(color: PdfColors.blue),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue.shade(0.8),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            department,
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.blue.shade(0.6),
            ),
          ),
        ],
      ),
    );
  }

  /// Build info row
  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  /// Build data table
  pw.Widget _buildDataTable(Map<String, dynamic> data) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey.shade(0.3)),
      children: data.entries.map((entry) {
        return pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              color: PdfColors.grey.shade(0.1),
              child: pw.Text(
                entry.key,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(entry.value.toString(), style: pw.TextStyle(fontSize: 10)),
            ),
          ],
        );
      }).toList(),
    );
  }

  /// Generate QR code data
  String _generateQrCodeData(User user, PdfTemplate template) {
    return '${template.name.toUpperCase()}-${user.id}-${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Get default title for template
  String _getDefaultTitle(PdfTemplate template, User user) {
    switch (template) {
      case PdfTemplate.solidWasteForm:
        return 'Solid Waste Management Form - ${user.fullName}';
      case PdfTemplate.barangayClearance:
        return 'Barangay Clearance - ${user.fullName}';
      case PdfTemplate.certificateOfResidency:
        return 'Certificate of Residency - ${user.fullName}';
      case PdfTemplate.incomeCertificate:
        return 'Income Certificate - ${user.fullName}';
      case PdfTemplate.goodMoralCertificate:
        return 'Good Moral Certificate - ${user.fullName}';
      case PdfTemplate.businessClearance:
        return 'Business Clearance - ${user.fullName}';
    }
  }

  /// Get document type for template
  DocumentType _getDocumentType(PdfTemplate template) {
    switch (template) {
      case PdfTemplate.solidWasteForm:
        return DocumentType.form;
      case PdfTemplate.barangayClearance:
      case PdfTemplate.certificateOfResidency:
      case PdfTemplate.incomeCertificate:
      case PdfTemplate.goodMoralCertificate:
      case PdfTemplate.businessClearance:
        return DocumentType.certificate;
    }
  }

  /// Get default content for template
  String _getDefaultContent(PdfTemplate template, User user) {
    switch (template) {
      case PdfTemplate.solidWasteForm:
        return 'Solid Waste Management Form for ${user.fullName}';
      case PdfTemplate.barangayClearance:
        return 'Barangay Clearance issued to ${user.fullName}';
      case PdfTemplate.certificateOfResidency:
        return 'Certificate of Residency issued to ${user.fullName}';
      case PdfTemplate.incomeCertificate:
        return 'Income Certificate issued to ${user.fullName}';
      case PdfTemplate.goodMoralCertificate:
        return 'Good Moral Certificate issued to ${user.fullName}';
      case PdfTemplate.businessClearance:
        return 'Business Clearance issued to ${user.fullName}';
    }
  }

  /// Format date
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Save PDF to file
  Future<File> _savePdfToFile(pw.Document pdf, String title) async {
    if (kIsWeb) {
      // For web, we'll create a virtual file path
      // The actual file handling will be done in the UI layer
      final fileName = '${title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final tempPath = '/web_downloads/$fileName';
      final file = File(tempPath);
      // For web, we don't actually write to file system
      // The bytes will be handled by the printing/download functionality
      return file;
    } else {
      // For mobile/desktop
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      final bytes = await pdf.save();
      await file.writeAsBytes(bytes);
      return file;
    }
  }

  /// Print document
  Future<void> printDocument(DocumentEntity document) async {
    if (kIsWeb) {
      // For web, we'll use the printing package directly with the document bytes
      // The document should have the bytes stored in metadata for web
      final bytes = document.metadata?['pdfBytes'] as List<int>?;
      if (bytes != null) {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => Uint8List.fromList(bytes),
          name: document.title,
        );
      }
    } else {
      // For mobile/desktop
      if (document.filePath == null) return;
      final file = File(document.filePath!);
      final bytes = await file.readAsBytes();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: document.title,
      );
    }
  }

  /// Share document
  Future<void> shareDocument(DocumentEntity document) async {
    if (document.filePath == null) return;
    
    // In a real app, this would use a sharing plugin
    // Sharing document: ${document.title}
    // File path: ${document.filePath}
  }
}

/// PDF Template enum
enum PdfTemplate {
  solidWasteForm,
  barangayClearance,
  certificateOfResidency,
  incomeCertificate,
  goodMoralCertificate,
  businessClearance,
}

/// Extension for PDF Template
extension PdfTemplateExtension on PdfTemplate {
  String get displayName {
    switch (this) {
      case PdfTemplate.solidWasteForm:
        return 'Solid Waste Management Form';
      case PdfTemplate.barangayClearance:
        return 'Barangay Clearance';
      case PdfTemplate.certificateOfResidency:
        return 'Certificate of Residency';
      case PdfTemplate.incomeCertificate:
        return 'Income Certificate';
      case PdfTemplate.goodMoralCertificate:
        return 'Good Moral Certificate';
      case PdfTemplate.businessClearance:
        return 'Business Clearance';
    }
  }

  String get description {
    switch (this) {
      case PdfTemplate.solidWasteForm:
        return 'Form for solid waste management compliance';
      case PdfTemplate.barangayClearance:
        return 'Clearance from barangay for various purposes';
      case PdfTemplate.certificateOfResidency:
        return 'Certificate proving residency in the barangay';
      case PdfTemplate.incomeCertificate:
        return 'Certificate of income for various applications';
      case PdfTemplate.goodMoralCertificate:
        return 'Certificate of good moral character';
      case PdfTemplate.businessClearance:
        return 'Clearance to operate business in barangay';
    }
  }

  IconData get icon {
    switch (this) {
      case PdfTemplate.solidWasteForm:
        return Icons.recycling;
      case PdfTemplate.barangayClearance:
        return Icons.verified;
      case PdfTemplate.certificateOfResidency:
        return Icons.home;
      case PdfTemplate.incomeCertificate:
        return Icons.attach_money;
      case PdfTemplate.goodMoralCertificate:
        return Icons.emoji_events;
      case PdfTemplate.businessClearance:
        return Icons.business;
    }
  }
}
