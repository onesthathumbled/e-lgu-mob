import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/permit_entity.dart';

/// Permits application page
class PermitsApplicationPage extends ConsumerStatefulWidget {
  final PermitType permitType;
  
  const PermitsApplicationPage({
    super.key,
    required this.permitType,
  });

  @override
  ConsumerState<PermitsApplicationPage> createState() => _PermitsApplicationPageState();
}

class _PermitsApplicationPageState extends ConsumerState<PermitsApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _businessDescriptionController = TextEditingController();
  final _notesController = TextEditingController();
  
  bool _isLoading = false;
  bool _isSubmitted = false;
  DateTime? _selectedInspectionDate;
  
  @override
  void dispose() {
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _ownerNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _businessDescriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectInspectionDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedInspectionDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    
    if (picked != null && picked != _selectedInspectionDate) {
      setState(() {
        _selectedInspectionDate = picked;
      });
    }
  }

  void _submitApplication() async {
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
          content: Text('Permit application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _getPermitTypeName() {
    switch (widget.permitType) {
      case PermitType.healthPermit:
        return 'Health Permit';
      case PermitType.workPermit:
        return 'Work Permit';
      case PermitType.sanitationPermit:
        return 'Sanitation Permit';
      case PermitType.buildingPermit:
        return 'Building Permit';
      case PermitType.businessPermit:
        return 'Business Permit';
      case PermitType.other:
        return 'Other Permit';
    }
  }

  String _getPermitDescription() {
    switch (widget.permitType) {
      case PermitType.healthPermit:
        return 'Required for food establishments, health facilities, and other health-related businesses.';
      case PermitType.workPermit:
        return 'Required for construction work, electrical work, and other professional services.';
      case PermitType.sanitationPermit:
        return 'Required for waste management, water systems, and sanitation services.';
      case PermitType.buildingPermit:
        return 'Required for construction, renovation, and building modifications.';
      case PermitType.businessPermit:
        return 'Required for operating various types of businesses.';
      case PermitType.other:
        return 'For other types of permits and licenses.';
    }
  }

  double _getPermitFee() {
    switch (widget.permitType) {
      case PermitType.healthPermit:
        return 500.0;
      case PermitType.workPermit:
        return 300.0;
      case PermitType.sanitationPermit:
        return 400.0;
      case PermitType.buildingPermit:
        return 1000.0;
      case PermitType.businessPermit:
        return 200.0;
      case PermitType.other:
        return 250.0;
    }
  }

  int _getProcessingTime() {
    switch (widget.permitType) {
      case PermitType.healthPermit:
        return 7;
      case PermitType.workPermit:
        return 5;
      case PermitType.sanitationPermit:
        return 6;
      case PermitType.buildingPermit:
        return 14;
      case PermitType.businessPermit:
        return 3;
      case PermitType.other:
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return _buildSuccessPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for ${_getPermitTypeName()}'),
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
                      'Apply for ${_getPermitTypeName()}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getPermitDescription(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info_outline, color: Colors.blue, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Processing Time: ${_getProcessingTime()} business days',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, color: Colors.blue, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Application Fee: ${AppConstants.currencySymbol}${_getPermitFee().toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Business Information Section
              Text(
                'Business Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Business Name
              ShadInput(
                label: 'Business Name *',
                placeholder: 'Enter business name',
                controller: _businessNameController,
                helperText: 'Official name of your business',
              ),
              
              const SizedBox(height: 16),
              
              // Business Address
              ShadInput(
                label: 'Business Address *',
                placeholder: 'Enter complete business address',
                controller: _businessAddressController,
                maxLines: 3,
                helperText: 'Include street, barangay, city, province',
              ),
              
              const SizedBox(height: 16),
              
              // Business Description
              ShadInput(
                label: 'Business Description *',
                placeholder: 'Describe your business activities',
                controller: _businessDescriptionController,
                maxLines: 3,
                helperText: 'Detailed description of your business operations',
              ),
              
              const SizedBox(height: 24),
              
              // Owner Information Section
              Text(
                'Owner Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Owner Name
              ShadInput(
                label: 'Owner Name *',
                placeholder: 'Enter owner full name',
                controller: _ownerNameController,
                helperText: 'Name as it appears on your ID',
              ),
              
              const SizedBox(height: 16),
              
              // Contact Number
              ShadInput(
                label: 'Contact Number *',
                placeholder: 'Enter contact number',
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
                helperText: 'Format: +63 XXX XXX XXXX',
              ),
              
              const SizedBox(height: 16),
              
              // Email
              ShadInput(
                label: 'Email Address *',
                placeholder: 'Enter email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                helperText: 'For notifications and updates',
              ),
              
              const SizedBox(height: 24),
              
              // Inspection Scheduling Section
              Text(
                'Inspection Scheduling',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Inspection Date
              GestureDetector(
                onTap: _selectInspectionDate,
                child: ShadInput(
                  label: 'Preferred Inspection Date *',
                  placeholder: 'Select inspection date',
                  controller: TextEditingController(
                    text: _selectedInspectionDate != null
                        ? '${_selectedInspectionDate!.day}/${_selectedInspectionDate!.month}/${_selectedInspectionDate!.year}'
                        : '',
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                  helperText: 'Select your preferred date for inspection',
                ),
              ),
              
              const SizedBox(height: 16),
              
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
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
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
                          'Application Fee:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${AppConstants.currencySymbol}${_getPermitFee().toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
                          '${AppConstants.currencySymbol}${_getPermitFee().toStringAsFixed(2)}',
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
                text: 'Submit Application',
                onPressed: _submitApplication,
                isLoading: _isLoading,
                fullWidth: true,
                icon: const Icon(Icons.send),
              ),
              
              const SizedBox(height: 16),
              
              // Information Banner
              ShadBanner(
                title: 'Application Process',
                description: 'Your application will be reviewed within ${_getProcessingTime()} business days. An inspection will be scheduled based on your preferred date.',
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
        title: Text('Apply for ${_getPermitTypeName()}'),
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
                  color: Colors.green.withValues(alpha: 0.1),
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
                'Application Submitted!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Your ${_getPermitTypeName().toLowerCase()} application has been submitted successfully. You will receive updates via SMS and email.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Application Details
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Application Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Permit Type',
                      value: _getPermitTypeName(),
                    ),
                    _DetailRow(
                      label: 'Business Name',
                      value: _businessNameController.text,
                    ),
                    _DetailRow(
                      label: 'Owner',
                      value: _ownerNameController.text,
                    ),
                    _DetailRow(
                      label: 'Contact',
                      value: _contactNumberController.text,
                    ),
                    _DetailRow(
                      label: 'Inspection Date',
                      value: _selectedInspectionDate != null
                          ? '${_selectedInspectionDate!.day}/${_selectedInspectionDate!.month}/${_selectedInspectionDate!.year}'
                          : 'Not selected',
                    ),
                    _DetailRow(
                      label: 'Application Fee',
                      value: '${AppConstants.currencySymbol}${_getPermitFee().toStringAsFixed(2)}',
                    ),
                    _DetailRow(
                      label: 'Processing Time',
                      value: '${_getProcessingTime()} business days',
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
                      text: 'New Application',
                      variant: ShadButtonVariant.outline,
                      onPressed: () {
                        setState(() {
                          _isSubmitted = false;
                          _formKey.currentState?.reset();
                          _businessNameController.clear();
                          _businessAddressController.clear();
                          _ownerNameController.clear();
                          _contactNumberController.clear();
                          _emailController.clear();
                          _businessDescriptionController.clear();
                          _notesController.clear();
                          _selectedInspectionDate = null;
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
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
