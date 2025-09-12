import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';

/// Digital ID registration page
class DigitalIdRegistrationPage extends ConsumerStatefulWidget {
  const DigitalIdRegistrationPage({super.key});

  @override
  ConsumerState<DigitalIdRegistrationPage> createState() => _DigitalIdRegistrationPageState();
}

class _DigitalIdRegistrationPageState extends ConsumerState<DigitalIdRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _placeOfBirthController = TextEditingController();
  final _civilStatusController = TextEditingController();
  final _occupationController = TextEditingController();
  final _tinController = TextEditingController();
  final _sssController = TextEditingController();
  final _philHealthController = TextEditingController();
  
  // Address controllers
  final _streetController = TextEditingController();
  final _barangayController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  
  bool _isLoading = false;
  bool _isRegistered = false;
  String _selectedCivilStatus = 'Single';
  DateTime? _selectedBirthDate;
  
  final List<String> _civilStatusOptions = [
    'Single',
    'Married',
    'Widowed',
    'Divorced',
    'Separated',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _birthDateController.dispose();
    _placeOfBirthController.dispose();
    _civilStatusController.dispose();
    _occupationController.dispose();
    _tinController.dispose();
    _sssController.dispose();
    _philHealthController.dispose();
    _streetController.dispose();
    _barangayController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isRegistered = true;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digital ID registration submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isRegistered) {
      return _buildSuccessPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital ID Registration'),
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
                      'Local Digital ID Registration',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Register for your official LGU digital identification card. This will serve as your digital identity within the local government.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Personal Information Section
              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Name fields
              Row(
                children: [
                  Expanded(
                    child: ShadInput(
                      label: 'First Name *',
                      placeholder: 'Enter first name',
                      controller: _firstNameController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ShadInput(
                      label: 'Last Name *',
                      placeholder: 'Enter last name',
                      controller: _lastNameController,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Middle Name
              ShadInput(
                label: 'Middle Name',
                placeholder: 'Enter middle name (optional)',
                controller: _middleNameController,
              ),
              
              const SizedBox(height: 16),
              
              // Birth Date
              GestureDetector(
                onTap: _selectBirthDate,
                child: ShadInput(
                  label: 'Date of Birth *',
                  placeholder: 'Select date of birth',
                  controller: _birthDateController,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Place of Birth
              ShadInput(
                label: 'Place of Birth *',
                placeholder: 'Enter place of birth',
                controller: _placeOfBirthController,
              ),
              
              const SizedBox(height: 16),
              
              // Civil Status
              DropdownButtonFormField<String>(
                value: _selectedCivilStatus,
                decoration: const InputDecoration(
                  labelText: 'Civil Status *',
                ),
                items: _civilStatusOptions.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCivilStatus = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Occupation
              ShadInput(
                label: 'Occupation *',
                placeholder: 'Enter occupation',
                controller: _occupationController,
              ),
              
              const SizedBox(height: 24),
              
              // Government IDs Section
              Text(
                'Government IDs',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // TIN
              ShadInput(
                label: 'TIN (Tax Identification Number)',
                placeholder: 'Enter TIN (optional)',
                controller: _tinController,
                keyboardType: TextInputType.number,
                helperText: 'Format: XXX-XXX-XXX or XXXX-XXX-XXX',
              ),
              
              const SizedBox(height: 16),
              
              // SSS
              ShadInput(
                label: 'SSS Number',
                placeholder: 'Enter SSS number (optional)',
                controller: _sssController,
                keyboardType: TextInputType.number,
                helperText: 'Format: XX-XXXXXXX-X',
              ),
              
              const SizedBox(height: 16),
              
              // PhilHealth
              ShadInput(
                label: 'PhilHealth Number',
                placeholder: 'Enter PhilHealth number (optional)',
                controller: _philHealthController,
                keyboardType: TextInputType.number,
                helperText: 'Format: XX-XXXXXXXXX-X',
              ),
              
              const SizedBox(height: 24),
              
              // Address Section
              Text(
                'Current Address',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Street Address
              ShadInput(
                label: 'Street Address *',
                placeholder: 'Enter street address',
                controller: _streetController,
              ),
              
              const SizedBox(height: 16),
              
              // Barangay
              ShadInput(
                label: 'Barangay *',
                placeholder: 'Enter barangay',
                controller: _barangayController,
              ),
              
              const SizedBox(height: 16),
              
              // City
              ShadInput(
                label: 'City *',
                placeholder: 'Enter city',
                controller: _cityController,
              ),
              
              const SizedBox(height: 16),
              
              // Province
              ShadInput(
                label: 'Province *',
                placeholder: 'Enter province',
                controller: _provinceController,
              ),
              
              const SizedBox(height: 16),
              
              // Postal Code
              ShadInput(
                label: 'Postal Code *',
                placeholder: 'Enter postal code',
                controller: _postalCodeController,
                keyboardType: TextInputType.number,
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              ShadButton(
                text: 'Submit Registration',
                onPressed: _submitRegistration,
                isLoading: _isLoading,
                fullWidth: true,
                icon: const Icon(Icons.credit_card),
              ),
              
              const SizedBox(height: 16),
              
              // Information Banner
              ShadBanner(
                title: 'Registration Process',
                description: 'Your digital ID will be processed within 7-10 business days. You will receive notifications about the status and can view your digital ID once approved.',
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
        title: const Text('Digital ID Registration'),
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
                'Registration Submitted!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Your digital ID registration has been submitted successfully. You will receive updates via email and SMS.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Mock QR Code
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Digital ID QR Code',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    QrImageView(
                      data: 'LGU-DIGITAL-ID-${DateTime.now().millisecondsSinceEpoch}',
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ID: LGU-${DateTime.now().millisecondsSinceEpoch}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
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
                      text: 'Download QR',
                      variant: ShadButtonVariant.outline,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR code download feature coming soon'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download),
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
