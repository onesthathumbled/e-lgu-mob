import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/community_entity.dart';

/// Community jobs page
class CommunityJobsPage extends StatelessWidget {
  const CommunityJobsPage({super.key});

  // Mock data for job postings
  List<JobPostingEntity> get _jobs => [
    JobPostingEntity(
      id: 'job_001',
      title: 'Administrative Assistant',
      description: 'Looking for a detail-oriented administrative assistant to support our office operations. Must have good communication skills and computer literacy.',
      company: 'Sample City Hall',
      location: 'Sample City, Philippines',
      jobType: JobType.fullTime,
      salaryRange: '₱15,000 - ₱20,000',
      requirements: [
        'Bachelor\'s degree in any field',
        'At least 1 year experience in administrative work',
        'Proficient in Microsoft Office',
        'Good communication skills',
        'Can work under pressure',
      ],
      benefits: [
        'Government benefits',
        'Health insurance',
        '13th month pay',
        'Vacation leave',
        'Sick leave',
      ],
      contactEmail: 'hr@samplecity.gov.ph',
      contactNumber: '+63 912 345 6789',
      status: JobStatus.active,
      postedAt: DateTime.now().subtract(const Duration(days: 2)),
      applicationDeadline: DateTime.now().add(const Duration(days: 28)),
      experienceLevel: ExperienceLevel.entry,
      educationLevel: EducationLevel.college,
      skills: ['Microsoft Office', 'Communication', 'Organization', 'Time Management'],
    ),
    JobPostingEntity(
      id: 'job_002',
      title: 'Community Health Worker',
      description: 'Join our health team to provide basic health services and health education to the community. Training will be provided.',
      company: 'Sample City Health Office',
      location: 'Sample City, Philippines',
      jobType: JobType.fullTime,
      salaryRange: '₱18,000 - ₱22,000',
      requirements: [
        'High school graduate or equivalent',
        'Willing to undergo training',
        'Good interpersonal skills',
        'Physically fit',
        'Can work in the field',
      ],
      benefits: [
        'Government benefits',
        'Health insurance',
        'Training opportunities',
        '13th month pay',
        'Transportation allowance',
      ],
      contactEmail: 'health@samplecity.gov.ph',
      contactNumber: '+63 912 345 6790',
      status: JobStatus.active,
      postedAt: DateTime.now().subtract(const Duration(days: 5)),
      applicationDeadline: DateTime.now().add(const Duration(days: 25)),
      experienceLevel: ExperienceLevel.entry,
      educationLevel: EducationLevel.highSchool,
      skills: ['Communication', 'Health Education', 'Community Service', 'First Aid'],
    ),
    JobPostingEntity(
      id: 'job_003',
      title: 'IT Support Specialist',
      description: 'Provide technical support for computer systems and networks. Maintain and troubleshoot hardware and software issues.',
      company: 'Sample City IT Department',
      location: 'Sample City, Philippines',
      jobType: JobType.fullTime,
      salaryRange: '₱25,000 - ₱30,000',
      requirements: [
        'Bachelor\'s degree in IT, Computer Science, or related field',
        'At least 2 years experience in IT support',
        'Knowledge of Windows and Linux systems',
        'Network troubleshooting skills',
        'Good problem-solving abilities',
      ],
      benefits: [
        'Government benefits',
        'Health insurance',
        'Professional development',
        '13th month pay',
        'Performance bonus',
      ],
      contactEmail: 'it@samplecity.gov.ph',
      contactNumber: '+63 912 345 6791',
      status: JobStatus.active,
      postedAt: DateTime.now().subtract(const Duration(days: 1)),
      applicationDeadline: DateTime.now().add(const Duration(days: 29)),
      experienceLevel: ExperienceLevel.mid,
      educationLevel: EducationLevel.college,
      skills: ['Windows', 'Linux', 'Networking', 'Hardware', 'Software', 'Troubleshooting'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Opportunities'),
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
                    'Job Opportunities',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find employment opportunities within the LGU and local businesses. Apply for positions that match your skills and experience.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Available Positions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._jobs.map((job) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _JobCard(job: job),
            )),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job});

  final JobPostingEntity job;

  String _getJobTypeName() {
    switch (job.jobType) {
      case JobType.fullTime:
        return 'Full Time';
      case JobType.partTime:
        return 'Part Time';
      case JobType.contract:
        return 'Contract';
      case JobType.freelance:
        return 'Freelance';
      case JobType.internship:
        return 'Internship';
      case JobType.volunteer:
        return 'Volunteer';
    }
  }

  Color _getJobTypeColor() {
    switch (job.jobType) {
      case JobType.fullTime:
        return Colors.green;
      case JobType.partTime:
        return Colors.blue;
      case JobType.contract:
        return Colors.orange;
      case JobType.freelance:
        return Colors.purple;
      case JobType.internship:
        return Colors.teal;
      case JobType.volunteer:
        return Colors.red;
    }
  }

  String _getExperienceLevelName() {
    switch (job.experienceLevel) {
      case ExperienceLevel.entry:
        return 'Entry Level';
      case ExperienceLevel.mid:
        return 'Mid Level';
      case ExperienceLevel.senior:
        return 'Senior Level';
      case ExperienceLevel.executive:
        return 'Executive';
      case null:
        return 'Any Level';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with job type badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getJobTypeColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getJobTypeName(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getJobTypeColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getExperienceLevelName(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Job title
            Text(
              job.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Company name
            Text(
              job.company,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Job description
            Text(
              job.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Job details
            _JobDetailRow(
              icon: Icons.location_on,
              label: 'Location',
              value: job.location,
            ),
            _JobDetailRow(
              icon: Icons.attach_money,
              label: 'Salary',
              value: job.salaryRange,
            ),
            _JobDetailRow(
              icon: Icons.schedule,
              label: 'Posted',
              value: '${job.postedAt.day}/${job.postedAt.month}/${job.postedAt.year}',
            ),
            if (job.applicationDeadline != null)
              _JobDetailRow(
                icon: Icons.event_available,
                label: 'Deadline',
                value: '${job.applicationDeadline!.day}/${job.applicationDeadline!.month}/${job.applicationDeadline!.year}',
              ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'View Details',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      _showJobDetails(context, job);
                    },
                    icon: const Icon(Icons.info_outline),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'Apply Now',
                    onPressed: () {
                      _showApplicationDialog(context, job);
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showJobDetails(BuildContext context, JobPostingEntity job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(job.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Company: ${job.company}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                job.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Requirements:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...job.requirements.map((req) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        req,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 16),
              Text(
                'Benefits:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...job.benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.star_outline, color: Colors.amber, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              )),
              if (job.skills != null && job.skills!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Skills:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: job.skills!.map((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      skill,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue.shade700,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showApplicationDialog(BuildContext context, JobPostingEntity job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apply for ${job.title}'),
        content: const Text('Job application form will be implemented here. For now, this is a mock application.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Application submitted successfully!')),
              );
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

class _JobDetailRow extends StatelessWidget {
  const _JobDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
