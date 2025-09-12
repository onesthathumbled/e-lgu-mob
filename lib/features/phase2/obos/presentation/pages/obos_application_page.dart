import 'package:flutter/material.dart';
import '../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/obos_entity.dart';

/// OBOS application page
class ObosApplicationPage extends StatefulWidget {
  const ObosApplicationPage({super.key});

  @override
  State<ObosApplicationPage> createState() => _ObosApplicationPageState();
}

class _ObosApplicationPageState extends State<ObosApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _applicantNameController = TextEditingController();
  final _applicantContactController = TextEditingController();
  final _propertyAddressController = TextEditingController();
  final _totalFloorAreaController = TextEditingController();
  final _numberOfFloorsController = TextEditingController();
  final _estimatedCostController = TextEditingController();

  BuildingType _selectedBuildingType = BuildingType.residential;
  ConstructionType _selectedConstructionType = ConstructionType.newConstruction;
  DateTime? _selectedInspectionDate;

  @override
  void dispose() {
    _applicantNameController.dispose();
    _applicantContactController.dispose();
    _propertyAddressController.dispose();
    _totalFloorAreaController.dispose();
    _numberOfFloorsController.dispose();
    _estimatedCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Building Permit Application'),
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
                      'Building Permit Application',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Apply for building permits, occupancy permits, and zoning clearances.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Applicant Information
              Text(
                'Applicant Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ShadCard(
                child: Column(
                  children: [
                    ShadInput(
                      controller: _applicantNameController,
                      label: 'Full Name *',
                      placeholder: 'Enter your full name',
                    ),
                    const SizedBox(height: 16),
                    ShadInput(
                      controller: _applicantContactController,
                      label: 'Contact Number *',
                      placeholder: 'Enter your contact number',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Property Information
              Text(
                'Property Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ShadCard(
                child: Column(
                  children: [
                    ShadInput(
                      controller: _propertyAddressController,
                      label: 'Property Address *',
                      placeholder: 'Enter complete property address',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Building Type *',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<BuildingType>(
                          value: _selectedBuildingType,
                          items: BuildingType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(_getBuildingTypeName(type)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedBuildingType = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Construction Type *',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<ConstructionType>(
                          value: _selectedConstructionType,
                          items: ConstructionType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(_getConstructionTypeName(type)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedConstructionType = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Building Details
              Text(
                'Building Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ShadCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ShadInput(
                            controller: _totalFloorAreaController,
                            label: 'Total Floor Area (sqm) *',
                            placeholder: 'Enter floor area',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ShadInput(
                            controller: _numberOfFloorsController,
                            label: 'Number of Floors *',
                            placeholder: 'Enter number of floors',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ShadInput(
                      controller: _estimatedCostController,
                      label: 'Estimated Construction Cost (₱) *',
                      placeholder: 'Enter estimated cost',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Inspection Schedule
              Text(
                'Inspection Schedule',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ShadCard(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 7)),
                          firstDate: DateTime.now().add(const Duration(days: 7)),
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedInspectionDate = date;
                          });
                        }
                      },
                      child: ShadInput(
                        label: 'Preferred Inspection Date *',
                        placeholder: _selectedInspectionDate != null
                            ? '${_selectedInspectionDate!.day}/${_selectedInspectionDate!.month}/${_selectedInspectionDate!.year}'
                            : 'Select inspection date',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Inspection will be scheduled within 7-14 days of application approval.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.blue.shade700,
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
              
              // Fee Calculator
              Text(
                'Estimated Fees',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ShadCard(
                child: Column(
                  children: [
                    _FeeRow(
                      label: 'Application Fee',
                      amount: 500.0,
                    ),
                    _FeeRow(
                      label: 'Processing Fee',
                      amount: 1000.0,
                    ),
                    _FeeRow(
                      label: 'Inspection Fee',
                      amount: 800.0,
                    ),
                    _FeeRow(
                      label: 'Permit Fee',
                      amount: _calculatePermitFee(),
                    ),
                    const Divider(),
                    _FeeRow(
                      label: 'Total Fees',
                      amount: _calculateTotalFees(),
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ShadButton(
                  text: 'Submit Application',
                  onPressed: _submitApplication,
                  icon: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculatePermitFee() {
    final floorArea = double.tryParse(_totalFloorAreaController.text) ?? 0;
    final cost = double.tryParse(_estimatedCostController.text) ?? 0;
    
    // Permit fee calculation based on floor area and construction cost
    final areaFee = floorArea * 50; // ₱50 per sqm
    final costFee = cost * 0.001; // 0.1% of construction cost
    
    return areaFee + costFee;
  }

  double _calculateTotalFees() {
    return 500.0 + 1000.0 + 800.0 + _calculatePermitFee();
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate()) {
      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Submit Application'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please confirm your application details:'),
              const SizedBox(height: 16),
              _ApplicationSummary(
                applicantName: _applicantNameController.text,
                propertyAddress: _propertyAddressController.text,
                buildingType: _selectedBuildingType,
                constructionType: _selectedConstructionType,
                totalFees: _calculateTotalFees(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processSubmission();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    }
  }

  void _processSubmission() {
    // Mock submission processing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted successfully! You will receive updates via SMS.'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Navigate back or to status page
    Navigator.of(context).pop();
  }

  String _getBuildingTypeName(BuildingType type) {
    switch (type) {
      case BuildingType.residential:
        return 'Residential';
      case BuildingType.commercial:
        return 'Commercial';
      case BuildingType.industrial:
        return 'Industrial';
      case BuildingType.institutional:
        return 'Institutional';
      case BuildingType.agricultural:
        return 'Agricultural';
      case BuildingType.mixedUse:
        return 'Mixed Use';
    }
  }

  String _getConstructionTypeName(ConstructionType type) {
    switch (type) {
      case ConstructionType.newConstruction:
        return 'New Construction';
      case ConstructionType.renovation:
        return 'Renovation';
      case ConstructionType.addition:
        return 'Addition';
      case ConstructionType.demolition:
        return 'Demolition';
      case ConstructionType.repair:
        return 'Repair';
    }
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow({
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  final String label;
  final double amount;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            '₱${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Theme.of(context).colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplicationSummary extends StatelessWidget {
  const _ApplicationSummary({
    required this.applicantName,
    required this.propertyAddress,
    required this.buildingType,
    required this.constructionType,
    required this.totalFees,
  });

  final String applicantName;
  final String propertyAddress;
  final BuildingType buildingType;
  final ConstructionType constructionType;
  final double totalFees;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SummaryRow(label: 'Applicant', value: applicantName),
        _SummaryRow(label: 'Property', value: propertyAddress),
        _SummaryRow(label: 'Building Type', value: _getBuildingTypeName(buildingType)),
        _SummaryRow(label: 'Construction Type', value: _getConstructionTypeName(constructionType)),
        _SummaryRow(label: 'Total Fees', value: '₱${totalFees.toStringAsFixed(2)}'),
      ],
    );
  }

  String _getBuildingTypeName(BuildingType type) {
    switch (type) {
      case BuildingType.residential:
        return 'Residential';
      case BuildingType.commercial:
        return 'Commercial';
      case BuildingType.industrial:
        return 'Industrial';
      case BuildingType.institutional:
        return 'Institutional';
      case BuildingType.agricultural:
        return 'Agricultural';
      case BuildingType.mixedUse:
        return 'Mixed Use';
    }
  }

  String _getConstructionTypeName(ConstructionType type) {
    switch (type) {
      case ConstructionType.newConstruction:
        return 'New Construction';
      case ConstructionType.renovation:
        return 'Renovation';
      case ConstructionType.addition:
        return 'Addition';
      case ConstructionType.demolition:
        return 'Demolition';
      case ConstructionType.repair:
        return 'Repair';
    }
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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
