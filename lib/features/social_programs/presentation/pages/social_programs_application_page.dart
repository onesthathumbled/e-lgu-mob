import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/social_program_entity.dart';

/// Social programs application page
class SocialProgramsApplicationPage extends ConsumerStatefulWidget {
  final SocialProgramEntity program;
  
  const SocialProgramsApplicationPage({
    super.key,
    required this.program,
  });

  @override
  ConsumerState<SocialProgramsApplicationPage> createState() => _SocialProgramsApplicationPageState();
}

class _SocialProgramsApplicationPageState extends ConsumerState<SocialProgramsApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _applicantNameController = TextEditingController();
  final _applicantAddressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _reasonController = TextEditingController();
  final _notesController = TextEditingController();
  
  bool _isLoading = false;
  bool _isSubmitted = false;
  DateTime? _selectedInterviewDate;
  
  @override
  void dispose() {
    _applicantNameController.dispose();
    _applicantAddressController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _reasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectInterviewDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedInterviewDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    
    if (picked != null && picked != _selectedInterviewDate) {
      setState(() {
        _selectedInterviewDate = picked;
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
          content: Text('Application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _getProgramTypeName() {
    switch (widget.program.type) {
      case SocialProgramType.financialAid:
        return 'Financial Aid';
      case SocialProgramType.scholarship:
        return 'Scholarship';
      case SocialProgramType.training:
        return 'Training Program';
      case SocialProgramType.medical:
        return 'Medical Assistance';
      case SocialProgramType.housing:
        return 'Housing Program';
      case SocialProgramType.livelihood:
        return 'Livelihood Program';
      case SocialProgramType.emergency:
        return 'Emergency Assistance';
      case SocialProgramType.other:
        return 'Other Program';
    }
  }

  String _getProgramCategoryName() {
    switch (widget.program.category) {
      case SocialProgramCategory.education:
        return 'Education';
      case SocialProgramCategory.health:
        return 'Health';
      case SocialProgramCategory.livelihood:
        return 'Livelihood';
      case SocialProgramCategory.housing:
        return 'Housing';
      case SocialProgramCategory.emergency:
        return 'Emergency';
      case SocialProgramCategory.seniorCitizen:
        return 'Senior Citizen';
      case SocialProgramCategory.pwd:
        return 'PWD';
      case SocialProgramCategory.women:
        return 'Women';
      case SocialProgramCategory.youth:
        return 'Youth';
      case SocialProgramCategory.other:
        return 'Other';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return _buildSuccessPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for ${widget.program.title}'),
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
              // Program Information
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getProgramTypeName(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getProgramCategoryName(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.program.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.program.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.schedule, color: Colors.orange, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Application Deadline: ${widget.program.applicationDeadline.day}/${widget.program.applicationDeadline.month}/${widget.program.applicationDeadline.year}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.orange.shade700,
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
              
              // Eligibility Requirements
              Text(
                'Eligibility Requirements',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To be eligible for this program, you must meet the following requirements:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.program.eligibilityRequirements.map((requirement) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              requirement,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Program Benefits
              Text(
                'Program Benefits',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Benefits you will receive from this program:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.program.benefits.map((benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star_outline,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Application Form
              Text(
                'Application Form',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Applicant Name
              ShadInput(
                label: 'Full Name *',
                placeholder: 'Enter your full name',
                controller: _applicantNameController,
                helperText: 'Name as it appears on your ID',
              ),
              
              const SizedBox(height: 16),
              
              // Applicant Address
              ShadInput(
                label: 'Address *',
                placeholder: 'Enter your complete address',
                controller: _applicantAddressController,
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
              
              const SizedBox(height: 16),
              
              // Reason for Application
              ShadInput(
                label: 'Reason for Application *',
                placeholder: 'Explain why you need this assistance',
                controller: _reasonController,
                maxLines: 4,
                helperText: 'Please provide a detailed explanation of your situation',
              ),
              
              const SizedBox(height: 16),
              
              // Preferred Interview Date
              GestureDetector(
                onTap: _selectInterviewDate,
                child: ShadInput(
                  label: 'Preferred Interview Date',
                  placeholder: 'Select interview date (optional)',
                  controller: TextEditingController(
                    text: _selectedInterviewDate != null
                        ? '${_selectedInterviewDate!.day}/${_selectedInterviewDate!.month}/${_selectedInterviewDate!.year}'
                        : '',
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                  helperText: 'Optional: Select your preferred interview date',
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Additional Notes
              ShadInput(
                label: 'Additional Information',
                placeholder: 'Any additional information you would like to share',
                controller: _notesController,
                maxLines: 3,
                helperText: 'Optional: Additional information or special circumstances',
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
                title: 'Application Process',
                description: 'Your application will be reviewed within 5-7 business days. You will be contacted for an interview if required.',
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
        title: Text('Apply for ${widget.program.title}'),
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
                'Your application for ${widget.program.title} has been submitted successfully. You will receive updates via SMS and email.',
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
                      label: 'Program',
                      value: widget.program.title,
                    ),
                    _DetailRow(
                      label: 'Type',
                      value: _getProgramTypeName(),
                    ),
                    _DetailRow(
                      label: 'Applicant',
                      value: _applicantNameController.text,
                    ),
                    _DetailRow(
                      label: 'Contact',
                      value: _contactNumberController.text,
                    ),
                    _DetailRow(
                      label: 'Interview Date',
                      value: _selectedInterviewDate != null
                          ? '${_selectedInterviewDate!.day}/${_selectedInterviewDate!.month}/${_selectedInterviewDate!.year}'
                          : 'Not selected',
                    ),
                    _DetailRow(
                      label: 'Application Date',
                      value: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
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
                          _applicantNameController.clear();
                          _applicantAddressController.clear();
                          _contactNumberController.clear();
                          _emailController.clear();
                          _reasonController.clear();
                          _notesController.clear();
                          _selectedInterviewDate = null;
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
