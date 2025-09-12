import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/community_entity.dart';

/// Community events page
class CommunityEventsPage extends StatelessWidget {
  const CommunityEventsPage({super.key});

  // Mock data for community events
  List<CommunityEventEntity> get _events => [
    CommunityEventEntity(
      id: 'event_001',
      title: 'Annual Fiesta Celebration',
      description: 'Join us for the annual fiesta celebration with food, games, and cultural performances.',
      eventType: EventType.fiesta,
      startDate: DateTime.now().add(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 7, hours: 8)),
      location: 'Town Plaza, Sample City',
      organizer: 'Sample City Tourism Office',
      contactNumber: '+63 912 345 6789',
      contactEmail: 'tourism@samplecity.gov.ph',
      status: EventStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      maxParticipants: 500,
      currentParticipants: 234,
      registrationRequired: false,
      fee: 0.0,
      imageUrl: null,
      requirements: ['Bring your own food containers', 'Wear comfortable clothes'],
      benefits: ['Free entrance', 'Cultural performances', 'Local food tasting', 'Games and prizes'],
    ),
    CommunityEventEntity(
      id: 'event_002',
      title: 'Health and Wellness Camp',
      description: 'Free health check-ups, medical consultations, and wellness activities for all residents.',
      eventType: EventType.healthCamp,
      startDate: DateTime.now().add(const Duration(days: 14)),
      endDate: DateTime.now().add(const Duration(days: 14, hours: 6)),
      location: 'Sample City Health Center',
      organizer: 'Sample City Health Office',
      contactNumber: '+63 912 345 6790',
      contactEmail: 'health@samplecity.gov.ph',
      status: EventStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      maxParticipants: 200,
      currentParticipants: 89,
      registrationRequired: true,
      registrationDeadline: DateTime.now().add(const Duration(days: 10)),
      fee: 0.0,
      imageUrl: null,
      requirements: ['Valid ID', 'Medical records (if any)', 'Face mask'],
      benefits: ['Free health check-up', 'Medical consultation', 'Free medicines', 'Health education'],
    ),
    CommunityEventEntity(
      id: 'event_003',
      title: 'Skills Training Workshop',
      description: 'Learn new skills in cooking, sewing, and handicrafts. Certificate of completion provided.',
      eventType: EventType.training,
      startDate: DateTime.now().add(const Duration(days: 21)),
      endDate: DateTime.now().add(const Duration(days: 28)),
      location: 'Sample City Training Center',
      organizer: 'Sample City Livelihood Office',
      contactNumber: '+63 912 345 6791',
      contactEmail: 'livelihood@samplecity.gov.ph',
      status: EventStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      maxParticipants: 30,
      currentParticipants: 18,
      registrationRequired: true,
      registrationDeadline: DateTime.now().add(const Duration(days: 15)),
      fee: 500.0,
      imageUrl: null,
      requirements: ['18 years old and above', 'Valid ID', 'Proof of residence'],
      benefits: ['Skills training', 'Certificate of completion', 'Materials provided', 'Job placement assistance'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Events'),
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
                    'Community Events',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stay updated with local events, fiestas, training programs, and community activities.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Upcoming Events',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._events.map((event) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _EventCard(event: event),
            )),
          ],
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final CommunityEventEntity event;

  String _getEventTypeName() {
    switch (event.eventType) {
      case EventType.fiesta:
        return 'Fiesta';
      case EventType.communityMeeting:
        return 'Community Meeting';
      case EventType.training:
        return 'Training';
      case EventType.healthCamp:
        return 'Health Camp';
      case EventType.sports:
        return 'Sports';
      case EventType.cultural:
        return 'Cultural';
      case EventType.religious:
        return 'Religious';
      case EventType.emergency:
        return 'Emergency';
      case EventType.other:
        return 'Other';
    }
  }

  Color _getEventTypeColor() {
    switch (event.eventType) {
      case EventType.fiesta:
        return Colors.orange;
      case EventType.communityMeeting:
        return Colors.blue;
      case EventType.training:
        return Colors.green;
      case EventType.healthCamp:
        return Colors.red;
      case EventType.sports:
        return Colors.purple;
      case EventType.cultural:
        return Colors.teal;
      case EventType.religious:
        return Colors.indigo;
      case EventType.emergency:
        return Colors.red.shade800;
      case EventType.other:
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with event type badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getEventTypeColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getEventTypeName(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getEventTypeColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                if (event.isFull)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
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
            
            // Event title
            Text(
              event.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Event description
            Text(
              event.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Event details
            _EventDetailRow(
              icon: Icons.calendar_today,
              label: 'Date',
              value: '${event.startDate.day}/${event.startDate.month}/${event.startDate.year}',
            ),
            _EventDetailRow(
              icon: Icons.access_time,
              label: 'Time',
              value: '${event.startDate.hour.toString().padLeft(2, '0')}:${event.startDate.minute.toString().padLeft(2, '0')} - ${event.endDate.hour.toString().padLeft(2, '0')}:${event.endDate.minute.toString().padLeft(2, '0')}',
            ),
            _EventDetailRow(
              icon: Icons.location_on,
              label: 'Location',
              value: event.location,
            ),
            _EventDetailRow(
              icon: Icons.people,
              label: 'Participants',
              value: event.maxParticipants != null 
                  ? '${event.currentParticipants}/${event.maxParticipants}'
                  : 'Unlimited',
            ),
            if (event.fee != null && event.fee! > 0)
              _EventDetailRow(
                icon: Icons.attach_money,
                label: 'Fee',
                value: '₱${event.fee!.toStringAsFixed(2)}',
              ),
            if (event.registrationRequired)
              _EventDetailRow(
                icon: Icons.event_available,
                label: 'Registration',
                value: event.registrationDeadline != null
                    ? 'Required (Deadline: ${event.registrationDeadline!.day}/${event.registrationDeadline!.month}/${event.registrationDeadline!.year})'
                    : 'Required',
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
                      _showEventDetails(context, event);
                    },
                    icon: const Icon(Icons.info_outline),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: event.registrationRequired ? 'Register' : 'Attend',
                    onPressed: () {
                      if (event.registrationRequired) {
                        _showRegistrationDialog(context, event);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No registration required. Just attend the event!')),
                        );
                      }
                    },
                    icon: const Icon(Icons.event_available),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, CommunityEventEntity event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (event.requirements != null && event.requirements!.isNotEmpty) ...[
                Text(
                  'Requirements:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...event.requirements!.map((req) => Padding(
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
              ],
              if (event.benefits != null && event.benefits!.isNotEmpty) ...[
                Text(
                  'Benefits:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...event.benefits!.map((benefit) => Padding(
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

  void _showRegistrationDialog(BuildContext context, CommunityEventEntity event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Register for ${event.title}'),
        content: const Text('Registration form will be implemented here. For now, this is a mock registration.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration submitted successfully!')),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

class _EventDetailRow extends StatelessWidget {
  const _EventDetailRow({
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
