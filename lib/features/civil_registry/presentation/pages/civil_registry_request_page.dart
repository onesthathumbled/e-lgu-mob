import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/civil_registry_entity.dart';

/// Civil registry document request page
class CivilRegistryRequestPage extends ConsumerStatefulWidget {
  final CivilRegistryDocumentType documentType;
  
  const CivilRegistryRequestPage({
    super.key,
    required this.documentType,
  });

  @override
  ConsumerState<CivilRegistryRequestPage> createState() => _CivilRegistryRequestPageState();
}

class _CivilRegistryRequestPageState extends ConsumerState<CivilRegistryRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _requestorNameController = TextEditingController();
  final _requestorAddressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _purposeController = TextEditingController();
  final _deliveryAddressController = TextEditingController();
  final _notesController = TextEditingController();
  
  bool _isLoading = false;
  bool _isSubmitted = false;
  DeliveryMethod _selectedDeliveryMethod = DeliveryMethod.pickup;
  DateTime? _selectedPickupDate;
  
  final List<DeliveryMethod> _deliveryMethods = [
    DeliveryMethod.pickup,
    DeliveryMethod.delivery,
    DeliveryMethod.courier,
  ];

  @override
  void dispose() {
    _requestorNameController.dispose();
    _requestorAddressController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _purposeController.dispose();
    _deliveryAddressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectPickupDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedPickupDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    
    if (picked != null && picked != _selectedPickupDate) {
      setState(() {
        _selectedPickupDate = picked;
      });
    }
  }

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isSubmitted = true;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document request submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _getDocumentTypeName() {
    switch (widget.documentType) {
      case CivilRegistryDocumentType.birthCertificate:
        return 'Birth Certificate';
      case CivilRegistryDocumentType.marriageCertificate:
        return 'Marriage Certificate';
      case CivilRegistryDocumentType.deathCertificate:
        return 'Death Certificate';
      case CivilRegistryDocumentType.certificateOfNoMarriage:
        return 'Certificate of No Marriage';
      case CivilRegistryDocumentType.certificateOfLiveBirth:
        return 'Certificate of Live Birth';
      case CivilRegistryDocumentType.certificateOfMarriage:
        return 'Certificate of Marriage';
      case CivilRegistryDocumentType.certificateOfDeath:
        return 'Certificate of Death';
      case CivilRegistryDocumentType.other:
        return 'Other Document';
    }
  }

  double _getDocumentFee() {
    switch (widget.documentType) {
      case CivilRegistryDocumentType.birthCertificate:
        return 155.0;
      case CivilRegistryDocumentType.marriageCertificate:
        return 155.0;
      case CivilRegistryDocumentType.deathCertificate:
        return 155.0;
      case CivilRegistryDocumentType.certificateOfNoMarriage:
        return 155.0;
      case CivilRegistryDocumentType.certificateOfLiveBirth:
        return 155.0;
      case CivilRegistryDocumentType.certificateOfMarriage:
        return 155.0;
      case CivilRegistryDocumentType.certificateOfDeath:
        return 155.0;
      case CivilRegistryDocumentType.other:
        return 155.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return _buildSuccessPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Request ${_getDocumentTypeName()}'),
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request ${_getDocumentTypeName()}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill out the form below to request your civil registry document. Processing time is 3-5 business days.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.blue, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Fee: ${AppConstants.currencySymbol}${_getDocumentFee().toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Requestor Information Section
              Text(
                'Requestor Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Requestor Name
              ShadInput(
                label: 'Full Name *',
                placeholder: 'Enter your full name',
                controller: _requestorNameController,
                helperText: 'Name as it appears on your ID',
              ),
              
              const SizedBox(height: 16),
              
              // Requestor Address
              ShadInput(
                label: 'Address *',
                placeholder: 'Enter your complete address',
                controller: _requestorAddressController,
                maxLines: 3,
                helperText: 'Include street, barangay, city, province',
              ),
              
              const SizedBox(height: 16),
              
              // Contact Number
              ShadInput(
                label: 'Contact Number *',
                placeholder: 'Enter your contact number',
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                helperText: 'Format: +63 XXX XXX XXXX',
              ),
              
              const SizedBox(height: 16),
              
              // Email
              ShadInput(
                label: 'Email Address *',
                placeholder: 'Enter your email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                helperText: 'For notifications and updates',
              ),
              
              const SizedBox(height: 24),
              
              // Document Information Section
              Text(
                'Document Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Purpose
              ShadInput(
                label: 'Purpose of Request *',
                placeholder: 'Enter the purpose for requesting this document',
                controller: _purposeController,
                maxLines: 3,
                helperText: 'e.g., Employment, Passport application, etc.',
              ),
              
              const SizedBox(height: 24),
              
              // Delivery Information Section
              Text(
                'Delivery Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Delivery Method
              DropdownButtonFormField<DeliveryMethod>(
                value: _selectedDeliveryMethod,
                decoration: const InputDecoration(
                  labelText: 'Delivery Method *',
                  helperText: 'Choose how you want to receive the document',
                ),
                items: _deliveryMethods.map((method) {
                  String label;
                  switch (method) {
                    case DeliveryMethod.pickup:
                      label = 'Pickup at Civil Registry Office';
                      break;
                    case DeliveryMethod.delivery:
                      label = 'Home Delivery';
                      break;
                    case DeliveryMethod.courier:
                      label = 'Courier Service';
                      break;
                  }
                  return DropdownMenuItem(
                    value: method,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDeliveryMethod = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Pickup Date (if pickup selected)
              if (_selectedDeliveryMethod == DeliveryMethod.pickup) ...[
                GestureDetector(
                  onTap: _selectPickupDate,
                  child: ShadInput(
                    label: 'Preferred Pickup Date *',
                    placeholder: 'Select pickup date',
                    controller: TextEditingController(
                      text: _selectedPickupDate != null
                          ? '${_selectedPickupDate!.day}/${_selectedPickupDate!.month}/${_selectedPickupDate!.year}'
                          : '',
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              
              // Delivery Address (if delivery selected)
              if (_selectedDeliveryMethod == DeliveryMethod.delivery || _selectedDeliveryMethod == DeliveryMethod.courier) ...[
                ShadInput(
                  label: 'Delivery Address *',
                  placeholder: 'Enter delivery address',
                  controller: _deliveryAddressController,
                  maxLines: 3,
                  helperText: 'Complete address for delivery',
                ),
                const SizedBox(height: 16),
              ],
              
              // Notes
              ShadInput(
                label: 'Additional Notes',
                placeholder: 'Any additional information or special instructions',
                controller: _notesController,
                maxLines: 3,
                helperText: 'Optional: Special instructions or additional information',
              ),
              
              const SizedBox(height: 32),
              
              // Fee Information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fee Summary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Document Fee:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${AppConstants.currencySymbol}${_getDocumentFee().toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (_selectedDeliveryMethod == DeliveryMethod.delivery) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '${AppConstants.currencySymbol}50.00',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (_selectedDeliveryMethod == DeliveryMethod.courier) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Courier Fee:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '${AppConstants.currencySymbol}100.00',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${AppConstants.currencySymbol}${(_getDocumentFee() + (_selectedDeliveryMethod == DeliveryMethod.delivery ? 50.0 : _selectedDeliveryMethod == DeliveryMethod.courier ? 100.0 : 0.0)).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Submit Button
              ShadButton(
                text: 'Submit Request',
                onPressed: _submitRequest,
                isLoading: _isLoading,
                fullWidth: true,
                icon: const Icon(Icons.send),
              ),
              
              const SizedBox(height: 16),
              
              // Information Banner
              ShadBanner(
                title: 'Processing Information',
                description: 'Your request will be processed within 3-5 business days. You will receive notifications via SMS and email about the status.',
                variant: ShadBannerVariant.default_,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request ${_getDocumentTypeName()}'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.green,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Success Message
              Text(
                'Request Submitted!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Your ${_getDocumentTypeName().toLowerCase()} request has been submitted successfully. You will receive updates via SMS and email.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Request Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Document Type',
                      value: _getDocumentTypeName(),
                    ),
                    _DetailRow(
                      label: 'Requestor',
                      value: _requestorNameController.text,
                    ),
                    _DetailRow(
                      label: 'Contact',
                      value: _contactNumberController.text,
                    ),
                    _DetailRow(
                      label: 'Delivery Method',
                      value: _selectedDeliveryMethod == DeliveryMethod.pickup
                          ? 'Pickup at Office'
                          : _selectedDeliveryMethod == DeliveryMethod.delivery
                              ? 'Home Delivery'
                              : 'Courier Service',
                    ),
                    _DetailRow(
                      label: 'Total Fee',
                      value: '${AppConstants.currencySymbol}${(_getDocumentFee() + (_selectedDeliveryMethod == DeliveryMethod.delivery ? 50.0 : _selectedDeliveryMethod == DeliveryMethod.courier ? 100.0 : 0.0)).toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ShadButton(
                      text: 'New Request',
                      variant: ShadButtonVariant.outline,
                      onPressed: () {
                        setState(() {
                          _isSubmitted = false;
                          _formKey.currentState?.reset();
                          _requestorNameController.clear();
                          _requestorAddressController.clear();
                          _contactNumberController.clear();
                          _emailController.clear();
                          _purposeController.clear();
                          _deliveryAddressController.clear();
                          _notesController.clear();
                          _selectedPickupDate = null;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ShadButton(
                      text: 'Done',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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
