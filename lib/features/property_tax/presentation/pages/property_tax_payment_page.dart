import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';

/// Property tax payment page
class PropertyTaxPaymentPage extends ConsumerStatefulWidget {
  const PropertyTaxPaymentPage({super.key});

  @override
  ConsumerState<PropertyTaxPaymentPage> createState() => _PropertyTaxPaymentPageState();
}

class _PropertyTaxPaymentPageState extends ConsumerState<PropertyTaxPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _tdNumberController = TextEditingController();
  final _pinController = TextEditingController();
  
  bool _isLoading = false;
  bool _isSearching = false;
  bool _propertyFound = false;
  String _selectedPaymentMethod = 'GCash';
  
  // Mock property data
  Map<String, dynamic>? _propertyData;
  
  final List<String> _paymentMethods = [
    'GCash',
    'PayMaya',
    'LANDBANK',
    'BPI',
    'BDO',
    'Metrobank',
    'Cash on Pickup',
  ];

  @override
  void dispose() {
    _tdNumberController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _searchProperty() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSearching = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSearching = false;
        _propertyFound = true;
        _propertyData = {
          'tdNumber': _tdNumberController.text,
          'pin': _pinController.text,
          'propertyAddress': '123 Main Street, Barangay 1, Sample City',
          'assessedValue': 500000.0,
          'taxAmount': 5000.0,
          'penaltyAmount': 0.0,
          'totalAmount': 5000.0,
          'dueDate': '2024-12-31',
          'status': 'unpaid',
        };
      });
    }
  }

  void _processPayment() async {
    if (_propertyData == null) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment processed successfully! Receipt will be sent to your email.'),
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
        title: const Text('Property Tax Payment'),
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
                      'Property Tax Payment',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Search for your property and pay your real property tax online.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Property Search Section
              Text(
                'Property Search',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // TD Number
              ShadInput(
                label: 'Tax Declaration Number (TD No.) *',
                placeholder: 'Enter TD number',
                controller: _tdNumberController,
                helperText: 'Use TD-2024-001 for demo',
              ),
              
              const SizedBox(height: 16),
              
              // PIN
              ShadInput(
                label: 'Property Identification Number (PIN) *',
                placeholder: 'Enter PIN',
                controller: _pinController,
                helperText: 'Use PIN-123456789 for demo',
              ),
              
              const SizedBox(height: 16),
              
              // Search Button
              ShadButton(
                text: 'Search Property',
                onPressed: _searchProperty,
                isLoading: _isSearching,
                fullWidth: true,
                icon: const Icon(Icons.search),
              ),
              
              if (_propertyFound && _propertyData != null) ...[
                const SizedBox(height: 24),
                
                // Property Details Section
                Text(
                  'Property Details',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                ShadCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PropertyDetailRow(
                        label: 'TD Number',
                        value: _propertyData!['tdNumber'],
                      ),
                      _PropertyDetailRow(
                        label: 'PIN',
                        value: _propertyData!['pin'],
                      ),
                      _PropertyDetailRow(
                        label: 'Property Address',
                        value: _propertyData!['propertyAddress'],
                      ),
                      _PropertyDetailRow(
                        label: 'Assessed Value',
                        value: '${AppConstants.currencySymbol}${_propertyData!['assessedValue'].toStringAsFixed(2)}',
                      ),
                      _PropertyDetailRow(
                        label: 'Tax Amount',
                        value: '${AppConstants.currencySymbol}${_propertyData!['taxAmount'].toStringAsFixed(2)}',
                      ),
                      _PropertyDetailRow(
                        label: 'Penalty Amount',
                        value: '${AppConstants.currencySymbol}${_propertyData!['penaltyAmount'].toStringAsFixed(2)}',
                      ),
                      const Divider(),
                      _PropertyDetailRow(
                        label: 'Total Amount',
                        value: '${AppConstants.currencySymbol}${_propertyData!['totalAmount'].toStringAsFixed(2)}',
                        isTotal: true,
                      ),
                      _PropertyDetailRow(
                        label: 'Due Date',
                        value: _propertyData!['dueDate'],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Payment Method Section
                Text(
                  'Payment Method',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod,
                  decoration: const InputDecoration(
                    labelText: 'Select Payment Method *',
                    helperText: 'Choose your preferred payment method',
                  ),
                  items: _paymentMethods.map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Payment Button
                ShadButton(
                  text: 'Pay ${AppConstants.currencySymbol}${_propertyData!['totalAmount'].toStringAsFixed(2)}',
                  onPressed: _processPayment,
                  isLoading: _isLoading,
                  fullWidth: true,
                  icon: const Icon(Icons.payment),
                ),
                
                const SizedBox(height: 16),
                
                // Payment Information Banner
                ShadBanner(
                  title: 'Payment Information',
                  description: 'Your payment will be processed securely. A receipt will be sent to your registered email address.',
                  variant: ShadBannerVariant.success,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyDetailRow extends StatelessWidget {
  const _PropertyDetailRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                color: isTotal ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
