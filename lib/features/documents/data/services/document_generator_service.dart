import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../domain/entities/document_entity.dart';

/// Document generator service for creating PDFs
class DocumentGeneratorService {
  static final DocumentGeneratorService _instance = DocumentGeneratorService._internal();
  factory DocumentGeneratorService() => _instance;
  DocumentGeneratorService._internal();

  /// Generate a PDF document
  Future<DocumentEntity> generateDocument({
    required String title,
    required DocumentType type,
    required String content,
    required DocumentTemplate template,
    Map<String, dynamic>? data,
    String? qrCodeData,
  }) async {
    final pdf = pw.Document();
    
    // Add content based on template
    switch (template) {
      case DocumentTemplate.businessPermit:
        pdf.addPage(_buildBusinessPermitPage(title, content, data, qrCodeData));
        break;
      case DocumentTemplate.propertyTaxReceipt:
        pdf.addPage(_buildPropertyTaxReceiptPage(title, content, data, qrCodeData));
        break;
      case DocumentTemplate.digitalId:
        pdf.addPage(_buildDigitalIdPage(title, content, data, qrCodeData));
        break;
      case DocumentTemplate.birthCertificate:
        pdf.addPage(_buildBirthCertificatePage(title, content, data, qrCodeData));
        break;
      case DocumentTemplate.healthPermit:
        pdf.addPage(_buildHealthPermitPage(title, content, data, qrCodeData));
        break;
      case DocumentTemplate.socialProgramCertificate:
        pdf.addPage(_buildSocialProgramCertificatePage(title, content, data, qrCodeData));
        break;
      default:
        pdf.addPage(_buildGeneralDocumentPage(title, content, data, qrCodeData));
    }

    // Save PDF to file
    final file = await _savePdfToFile(pdf, title);
    
    return DocumentEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      type: type,
      content: content,
      createdAt: DateTime.now(),
      filePath: file.path,
      fileSize: await file.length(),
      qrCode: qrCodeData,
      template: template.name,
      metadata: data,
    );
  }

  /// Build business permit page
  pw.Page _buildBusinessPermitPage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('BUSINESS PERMIT', 'Sample City LGU'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Business details
            if (data != null) ...[
              pw.Text('Business Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // Footer with QR code
            _buildFooter(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build property tax receipt page
  pw.Page _buildPropertyTaxReceiptPage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('PROPERTY TAX RECEIPT', 'Sample City LGU'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Payment details
            if (data != null) ...[
              pw.Text('Payment Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // Footer with QR code
            _buildFooter(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build digital ID page
  pw.Page _buildDigitalIdPage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('DIGITAL ID', 'Sample City LGU'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Personal details
            if (data != null) ...[
              pw.Text('Personal Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // QR Code section
            if (qrCodeData != null) ...[
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('Digital ID QR Code:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      width: 150,
                      height: 150,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      child: pw.Center(
                        child: pw.Text('QR CODE\nPLACEHOLDER', 
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            pw.SizedBox(height: 20),
            
            // Footer
            _buildFooter(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build birth certificate page
  pw.Page _buildBirthCertificatePage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('BIRTH CERTIFICATE', 'Sample City Civil Registry'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Birth details
            if (data != null) ...[
              pw.Text('Birth Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // Footer with QR code
            _buildFooter(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build health permit page
  pw.Page _buildHealthPermitPage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('HEALTH PERMIT', 'Sample City Health Office'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Permit details
            if (data != null) ...[
              pw.Text('Permit Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // Footer with QR code
            _buildFooter(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build social program certificate page
  pw.Page _buildSocialProgramCertificatePage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('SOCIAL PROGRAM CERTIFICATE', 'Sample City Social Services'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Program details
            if (data != null) ...[
              pw.Text('Program Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // Footer with QR code
            _buildFooter(qrCodeData),
          ],
        );
      },
    );
  }

  /// Build general document page
  pw.Page _buildGeneralDocumentPage(String title, String content, Map<String, dynamic>? data, String? qrCodeData) {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader('OFFICIAL DOCUMENT', 'Sample City LGU'),
            
            pw.SizedBox(height: 20),
            
            // Title
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Content
            pw.Text(content),
            
            pw.SizedBox(height: 20),
            
            // Additional data
            if (data != null) ...[
              pw.Text('Document Details:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              _buildDataTable(data),
            ],
            
            pw.Spacer(),
            
            // Footer with QR code
            _buildFooter(qrCodeData),
          ],
        );
      },
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
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(entry.value.toString()),
            ),
          ],
        );
      }).toList(),
    );
  }

  /// Build footer section
  pw.Widget _buildFooter(String? qrCodeData) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
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
            'Generated on: ${DateTime.now().toString().split(' ')[0]}',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey.shade(0.6),
            ),
          ),
          if (qrCodeData != null) ...[
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Container(
                width: 100,
                height: 100,
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
        ],
      ),
    );
  }

  /// Save PDF to file
  Future<File> _savePdfToFile(pw.Document pdf, String title) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '${title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${directory.path}/$fileName');
    
    final bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    
    return file;
  }

  /// Print document
  Future<void> printDocument(DocumentEntity document) async {
    if (document.filePath == null) return;
    
    final file = File(document.filePath!);
    final bytes = await file.readAsBytes();
    
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
      name: document.title,
    );
  }

  /// Share document
  Future<void> shareDocument(DocumentEntity document) async {
    if (document.filePath == null) return;
    
    final file = File(document.filePath!);
    
    // In a real app, this would use a sharing plugin
    print('Sharing document: ${document.title}');
    print('File path: ${document.filePath}');
  }
}
