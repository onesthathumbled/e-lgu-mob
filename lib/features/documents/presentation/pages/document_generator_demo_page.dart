import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/document_entity.dart';
import '../../data/services/document_generator_service.dart';

/// Document generator demo page
class DocumentGeneratorDemoPage extends StatefulWidget {
  const DocumentGeneratorDemoPage({super.key});

  @override
  State<DocumentGeneratorDemoPage> createState() => _DocumentGeneratorDemoPageState();
}

class _DocumentGeneratorDemoPageState extends State<DocumentGeneratorDemoPage> {
  final DocumentGeneratorService _documentService = DocumentGeneratorService();
  bool _isGenerating = false;
  DocumentEntity? _generatedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Generator'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const ServicesDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document Generator Demo',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Generate official documents like receipts, certificates, and permits with QR codes.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'Generate Sample Documents',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Business Permit Document
            _buildDocumentCard(
              title: 'Business Permit',
              description: 'Generate a sample business permit document',
              icon: Icons.business,
              color: Colors.blue,
              onGenerate: () => _generateDocument(
                title: 'Business Permit - Sample Business',
                type: DocumentType.permit,
                template: DocumentTemplate.businessPermit,
                content: 'This is to certify that Sample Business has been granted a business permit to operate in Sample City.',
                data: {
                  'Business Name': 'Sample Business',
                  'Business Type': 'Retail',
                  'Owner': 'John Doe',
                  'Address': '123 Business St, Sample City',
                  'Permit Number': 'BP-2024-001',
                  'Valid Until': 'December 31, 2024',
                },
                qrCodeData: 'BP-2024-001-Sample-Business',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Property Tax Receipt
            _buildDocumentCard(
              title: 'Property Tax Receipt',
              description: 'Generate a sample property tax payment receipt',
              icon: Icons.receipt,
              color: Colors.green,
              onGenerate: () => _generateDocument(
                title: 'Property Tax Receipt',
                type: DocumentType.receipt,
                template: DocumentTemplate.propertyTaxReceipt,
                content: 'Payment received for Real Property Tax for the year 2024.',
                data: {
                  'Property Owner': 'John Doe',
                  'Property Address': '123 Main St, Sample City',
                  'TD Number': 'TD-2024-001',
                  'Amount Paid': '₱5,000.00',
                  'Payment Date': DateTime.now().toString().split(' ')[0],
                  'Receipt Number': 'RPT-2024-001',
                },
                qrCodeData: 'RPT-2024-001-5000.00',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Digital ID
            _buildDocumentCard(
              title: 'Digital ID',
              description: 'Generate a sample digital ID document',
              icon: Icons.credit_card,
              color: Colors.orange,
              onGenerate: () => _generateDocument(
                title: 'Digital ID - John Doe',
                type: DocumentType.id,
                template: DocumentTemplate.digitalId,
                content: 'This is an official Digital ID issued by Sample City LGU.',
                data: {
                  'Full Name': 'John Michael Doe',
                  'Date of Birth': 'January 15, 1990',
                  'Address': '123 Main St, Barangay 1, Sample City',
                  'ID Number': 'DID-2024-001',
                  'Issue Date': DateTime.now().toString().split(' ')[0],
                  'Valid Until': DateTime.now().add(const Duration(days: 365)).toString().split(' ')[0],
                },
                qrCodeData: 'DID-2024-001-John-Doe',
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Birth Certificate
            _buildDocumentCard(
              title: 'Birth Certificate',
              description: 'Generate a sample birth certificate',
              icon: Icons.description,
              color: Colors.purple,
              onGenerate: () => _generateDocument(
                title: 'Birth Certificate - John Doe',
                type: DocumentType.certificate,
                template: DocumentTemplate.birthCertificate,
                content: 'This is to certify the birth of John Michael Doe as recorded in the Civil Registry.',
                data: {
                  'Child\'s Name': 'John Michael Doe',
                  'Date of Birth': 'January 15, 1990',
                  'Place of Birth': 'Sample City Hospital',
                  'Father': 'Robert Doe',
                  'Mother': 'Maria Doe',
                  'Certificate Number': 'BC-2024-001',
                  'Issue Date': DateTime.now().toString().split(' ')[0],
                },
                qrCodeData: 'BC-2024-001-John-Doe',
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Generated Document Display
            if (_generatedDocument != null) ...[
              Text(
                'Generated Document',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: Colors.green,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _generatedDocument!.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    _DetailRow(
                      label: 'Type',
                      value: _generatedDocument!.type.name.toUpperCase(),
                    ),
                    _DetailRow(
                      label: 'File Size',
                      value: _generatedDocument!.fileSizeInMB?.toStringAsFixed(2) ?? 'Unknown',
                    ),
                    _DetailRow(
                      label: 'Generated',
                      value: _generatedDocument!.createdAt.toString().split(' ')[0],
                    ),
                    if (_generatedDocument!.qrCode != null)
                      _DetailRow(
                        label: 'QR Code',
                        value: 'Included',
                      ),
                    
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ShadButton(
                            text: 'View Document',
                            variant: ShadButtonVariant.outline,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Document viewer would open here'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.visibility),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ShadButton(
                            text: 'Print Document',
                            onPressed: () {
                              _documentService.printDocument(_generatedDocument!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Print dialog would open here'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.print),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onGenerate,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            ShadButton(
              text: 'Generate',
              onPressed: _isGenerating ? null : onGenerate,
              isLoading: _isGenerating,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateDocument({
    required String title,
    required DocumentType type,
    required DocumentTemplate template,
    required String content,
    required Map<String, dynamic> data,
    required String qrCodeData,
  }) async {
    setState(() {
      _isGenerating = true;
    });

    try {
      final document = await _documentService.generateDocument(
        title: title,
        type: type,
        content: content,
        template: template,
        data: data,
        qrCodeData: qrCodeData,
      );

      setState(() {
        _generatedDocument = document;
        _isGenerating = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isGenerating = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating document: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
