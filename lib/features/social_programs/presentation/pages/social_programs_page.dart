import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/social_program_entity.dart';
import 'social_programs_application_page.dart';

class SocialProgramsPage extends StatelessWidget {
  const SocialProgramsPage({super.key});

  // Mock data for available programs
  List<SocialProgramEntity> get _availablePrograms => [
    SocialProgramEntity(
      id: 'prog_001',
      title: 'Medical Assistance Program',
      description: 'Financial assistance for medical expenses, hospitalization, and emergency medical needs.',
      type: SocialProgramType.medical,
      category: SocialProgramCategory.health,
      eligibilityRequirements: [
        'Must be a resident of the municipality',
        'Must have valid ID and proof of residence',
        'Must provide medical certificate or hospital bill',
        'Family income must not exceed ₱15,000 per month',
      ],
      benefits: [
        'Up to ₱10,000 medical assistance',
        'Priority in government hospitals',
        'Free medical consultation',
        'Medicine assistance program',
      ],
      applicationDeadline: DateTime.now().add(const Duration(days: 30)),
      status: SocialProgramStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      maxParticipants: 100,
      currentParticipants: 45,
      contactPerson: 'Dr. Maria Santos',
      contactNumber: '+63 912 345 6789',
      contactEmail: 'medical.assistance@lgu.gov.ph',
    ),
    SocialProgramEntity(
      id: 'prog_002',
      title: 'Educational Scholarship Program',
      description: 'Full scholarship program for deserving students from low-income families.',
      type: SocialProgramType.scholarship,
      category: SocialProgramCategory.education,
      eligibilityRequirements: [
        'Must be a resident of the municipality',
        'Must be enrolled in public school',
        'Family income must not exceed ₱12,000 per month',
        'Must maintain good academic standing',
      ],
      benefits: [
        'Full tuition fee coverage',
        'Monthly allowance of ₱2,000',
        'Free school supplies and uniform',
        'Priority in college admission',
      ],
      applicationDeadline: DateTime.now().add(const Duration(days: 45)),
      status: SocialProgramStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      maxParticipants: 50,
      currentParticipants: 23,
      contactPerson: 'Ms. Ana Cruz',
      contactNumber: '+63 912 345 6790',
      contactEmail: 'scholarship@lgu.gov.ph',
    ),
    SocialProgramEntity(
      id: 'prog_003',
      title: 'Livelihood Training Program',
      description: 'Free skills training for various livelihood opportunities including cooking, sewing, and handicrafts.',
      type: SocialProgramType.training,
      category: SocialProgramCategory.livelihood,
      eligibilityRequirements: [
        'Must be a resident of the municipality',
        'Must be 18 years old and above',
        'Must be unemployed or underemployed',
        'Must complete the training program',
      ],
      benefits: [
        'Free skills training',
        'Certificate of completion',
        'Start-up capital assistance',
        'Market linkage support',
      ],
      applicationDeadline: DateTime.now().add(const Duration(days: 20)),
      status: SocialProgramStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      maxParticipants: 30,
      currentParticipants: 18,
      contactPerson: 'Mr. Juan Dela Cruz',
      contactNumber: '+63 912 345 6791',
      contactEmail: 'livelihood@lgu.gov.ph',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Programs'),
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
                    'Citizen Assistance & Social Programs',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Access various assistance programs, scholarships, training opportunities, and social services provided by the LGU.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Available Programs',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._availablePrograms.map((program) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProgramCard(
                program: program,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SocialProgramsApplicationPage(
                        program: program,
                      ),
                    ),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({
    required this.program,
    required this.onTap,
  });

  final SocialProgramEntity program;
  final VoidCallback onTap;

  String _getProgramTypeName() {
    switch (program.type) {
      case SocialProgramType.financialAid:
        return 'Financial Aid';
      case SocialProgramType.scholarship:
        return 'Scholarship';
      case SocialProgramType.training:
        return 'Training';
      case SocialProgramType.medical:
        return 'Medical';
      case SocialProgramType.housing:
        return 'Housing';
      case SocialProgramType.livelihood:
        return 'Livelihood';
      case SocialProgramType.emergency:
        return 'Emergency';
      case SocialProgramType.other:
        return 'Other';
    }
  }

  String _getProgramCategoryName() {
    switch (program.category) {
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

  Color _getCategoryColor() {
    switch (program.category) {
      case SocialProgramCategory.education:
        return Colors.blue;
      case SocialProgramCategory.health:
        return Colors.red;
      case SocialProgramCategory.livelihood:
        return Colors.green;
      case SocialProgramCategory.housing:
        return Colors.orange;
      case SocialProgramCategory.emergency:
        return Colors.purple;
      case SocialProgramCategory.seniorCitizen:
        return Colors.teal;
      case SocialProgramCategory.pwd:
        return Colors.indigo;
      case SocialProgramCategory.women:
        return Colors.pink;
      case SocialProgramCategory.youth:
        return Colors.amber;
      case SocialProgramCategory.other:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with badges
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getProgramTypeName(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getCategoryColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getProgramCategoryName(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (program.isFull)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Full',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Title
              Text(
                program.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Description
              Text(
                program.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 12),
              
              // Program details
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${program.currentParticipants}/${program.maxParticipants} participants',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Deadline: ${program.applicationDeadline.day}/${program.applicationDeadline.month}/${program.applicationDeadline.year}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Benefits preview
              Text(
                'Benefits: ${program.benefits.take(2).join(', ')}${program.benefits.length > 2 ? '...' : ''}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}