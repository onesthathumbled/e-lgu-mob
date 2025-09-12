import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';

/// New business permit application page
class NewBusinessPermitPage extends ConsumerStatefulWidget {
  const NewBusinessPermitPage({super.key});

  @override
  ConsumerState<NewBusinessPermitPage> createState() => _NewBusinessPermitPageState();
}

class _NewBusinessPermitPageState extends ConsumerState<NewBusinessPermitPage> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _businessTypeController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerAddressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _businessDescriptionController = TextEditingController();
  final _capitalizationController = TextEditingController();
  final _employeesCountController = TextEditingController();
  
  // Business address controllers
  final _streetController = TextEditingController();
  final _barangayController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _landmarkController = TextEditingController();
  
  bool _isLoading = false;
  String _selectedBusinessType = 'Retail';

  final List<String> _businessTypes = [
    'Retail',
    'Wholesale',
    'Service',
    'Manufacturing',
    'Food Service',
    'Professional Services',
    'Construction',
    'Transportation',
    'Other',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessTypeController.dispose();
    _ownerNameController.dispose();
    _ownerAddressController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _businessDescriptionController.dispose();
    _capitalizationController.dispose();
    _employeesCountController.dispose();
    _streetController.dispose();
    _barangayController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    _landmarkController.dispose();
    super.dispose();
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
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Business permit application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Business Permit'),
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
                      'Business Permit Application',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill out the form below to apply for a new business permit. All fields marked with * are required.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
              
              // Business Type
              DropdownButtonFormField<String>(
                value: _selectedBusinessType,
                decoration: const InputDecoration(
                  labelText: 'Business Type *',
                  helperText: 'Select the type of business',
                ),
                items: _businessTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBusinessType = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Business Description
              ShadInput(
                label: 'Business Description *',
                placeholder: 'Describe your business activities',
                controller: _businessDescriptionController,
                maxLines: 3,
                helperText: 'Detailed description of your business activities',
              ),
              
              const SizedBox(height: 16),
              
              // Capitalization
              ShadInput(
                label: 'Capitalization (₱) *',
                placeholder: 'Enter business capitalization',
                controller: _capitalizationController,
                keyboardType: TextInputType.number,
                helperText: 'Total capital investment in Philippine Peso',
              ),
              
              const SizedBox(height: 16),
              
              // Number of Employees
              ShadInput(
                label: 'Number of Employees *',
                placeholder: 'Enter number of employees',
                controller: _employeesCountController,
                keyboardType: TextInputType.number,
                helperText: 'Total number of employees (including owner)',
              ),
              
              const SizedBox(height: 24),
              
              // Business Address Section
              Text(
                'Business Address',
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
              
              const SizedBox(height: 16),
              
              // Landmark
              ShadInput(
                label: 'Landmark',
                placeholder: 'Enter nearby landmark (optional)',
                controller: _landmarkController,
                helperText: 'Optional: Nearby landmark for easier location',
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
              ),
              
              const SizedBox(height: 16),
              
              // Owner Address
              ShadInput(
                label: 'Owner Address *',
                placeholder: 'Enter owner address',
                controller: _ownerAddressController,
                maxLines: 2,
              ),
              
              const SizedBox(height: 16),
              
              // Contact Number
              ShadInput(
                label: 'Contact Number *',
                placeholder: 'Enter contact number',
                controller: _contactNumberController,
                keyboardType: TextInputType.phone,
              ),
              
              const SizedBox(height: 16),
              
              // Email
              ShadInput(
                label: 'Email Address *',
                placeholder: 'Enter email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 32),
              
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
                title: 'Application Processing',
                description: 'Your application will be processed within 5-7 business days. You will receive notifications about the status.',
                variant: ShadBannerVariant.default_,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
