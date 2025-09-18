import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../../../shared/models/user.dart';
import '../../data/services/dynamic_pdf_service.dart';
import '../../domain/entities/document_entity.dart';

/// PDF Generation page for creating documents based on user details
class PdfGenerationPage extends ConsumerStatefulWidget {
  const PdfGenerationPage({super.key});

  @override
  ConsumerState<PdfGenerationPage> createState() => _PdfGenerationPageState();
}

class _PdfGenerationPageState extends ConsumerState<PdfGenerationPage> {
  final DynamicPdfService _pdfService = DynamicPdfService();
  
  bool _isGenerating = false;
  DocumentEntity? _generatedDocument;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      // Create mock user data for demonstration
      final user = User.fromJson({
        'id': 'user_001',
        'email': 'john.doe@email.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'middleName': 'Michael',
        'phoneNumber': '+63 912 345 6789',
        'dateOfBirth': '1990-05-15',
        'address': {
          'street': '123 Main Street',
          'barangay': 'Barangay 1',
          'city': 'Sample City',
          'province': 'Sample Province',
          'postalCode': '1234',
          'landmark': 'Near City Hall',
        },
        'profileImage': null,
        'isVerified': true,
        'createdAt': '2024-01-01T00:00:00Z',
        'updatedAt': '2024-01-15T10:30:00Z',
      });
      
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading user data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Generator'),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Generator'),
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
            // Header
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dynamic PDF Generator',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Generate official documents using your profile information. All documents will be automatically populated with your details.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // User Info Card
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'Name', value: _currentUser!.fullName),
                  _InfoRow(label: 'Email', value: _currentUser!.email),
                  _InfoRow(label: 'Phone', value: _currentUser!.phoneNumber),
                  _InfoRow(label: 'Address', value: '${_currentUser!.address.street}, ${_currentUser!.address.barangay}, ${_currentUser!.address.city}'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'Available Templates',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Template Cards
            ...PdfTemplate.values.map((template) => _buildTemplateCard(template)),
            
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
                      value: '${_generatedDocument!.fileSizeInMB?.toStringAsFixed(2) ?? 'Unknown'} MB',
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
                            text: kIsWeb ? 'Download PDF' : 'Print Document',
                            onPressed: () {
                              if (kIsWeb) {
                                _downloadPdfForWeb(_generatedDocument!);
                              } else {
                                _pdfService.printDocument(_generatedDocument!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Print dialog opened'),
                                  ),
                                );
                              }
                            },
                            icon: Icon(kIsWeb ? Icons.download : Icons.print),
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

  Widget _buildTemplateCard(PdfTemplate template) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
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
                  color: _getTemplateColor(template).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  template.icon,
                  color: _getTemplateColor(template),
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.displayName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              ShadButton(
                text: 'Generate',
                onPressed: _isGenerating ? null : () => _generateDocument(template),
                isLoading: _isGenerating,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTemplateColor(PdfTemplate template) {
    switch (template) {
      case PdfTemplate.solidWasteForm:
        return Colors.green;
      case PdfTemplate.barangayClearance:
        return Colors.blue;
      case PdfTemplate.certificateOfResidency:
        return Colors.orange;
      case PdfTemplate.incomeCertificate:
        return Colors.purple;
      case PdfTemplate.goodMoralCertificate:
        return Colors.teal;
      case PdfTemplate.businessClearance:
        return Colors.indigo;
    }
  }

  Future<void> _generateDocument(PdfTemplate template) async {
    setState(() {
      _isGenerating = true;
    });

    try {
      // Prepare additional data based on template
      final additionalData = _prepareAdditionalData(template);
      
      final document = await _pdfService.generateUserDocument(
        user: _currentUser!,
        template: template,
        additionalData: additionalData,
      );

      setState(() {
        _generatedDocument = document;
        _isGenerating = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${template.displayName} generated successfully!'),
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

  Map<String, dynamic> _prepareAdditionalData(PdfTemplate template) {
    switch (template) {
      case PdfTemplate.solidWasteForm:
        return {
          'collection_schedule': 'Every Tuesday and Friday',
          'segregation': 'Yes, properly segregated',
          'composting': 'Yes, organic waste composting',
          'recycling': 'Yes, actively participating',
          'special_waste': 'Properly disposed at designated areas',
        };
      case PdfTemplate.certificateOfResidency:
        return {
          'years_of_residency': '5',
        };
      case PdfTemplate.incomeCertificate:
        return {
          'monthly_income': '15,000.00',
        };
      case PdfTemplate.businessClearance:
        return {
          'business_name': 'Sample Business',
          'business_type': 'Retail',
          'business_address': _currentUser!.address.street,
        };
      default:
        return {};
    }
  }

  void _downloadPdfForWeb(DocumentEntity document) {
    if (kIsWeb) {
      final bytes = document.metadata?['pdfBytes'] as List<int>?;
      if (bytes != null) {
        // For web, we'll trigger the print dialog which allows saving
        _pdfService.printDocument(document);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF ready for download/printing'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF data not available'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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
