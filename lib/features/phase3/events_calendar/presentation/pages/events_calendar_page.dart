import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/event_entity.dart';

class EventsCalendarPage extends StatefulWidget {
  const EventsCalendarPage({super.key});

  @override
  State<EventsCalendarPage> createState() => _EventsCalendarPageState();
}

class _EventsCalendarPageState extends State<EventsCalendarPage> {
  final List<EventEntity> _events = [
    EventEntity(
      id: '1',
      title: 'Barangay Assembly Meeting',
      description: 'Monthly barangay assembly to discuss community issues and updates',
      type: EventType.lguOfficial,
      status: EventStatus.published,
      organizerId: 'lgu_001',
      organizerName: 'Barangay Council',
      organizerType: 'lgu',
      startDate: DateTime.now().add(const Duration(days: 3)),
      endDate: DateTime.now().add(const Duration(days: 3, hours: 2)),
      location: 'Barangay Hall Main',
      isPublic: true,
      maxAttendees: 100,
      registrationRequired: false,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      contactEmail: 'barangay@lgu.gov.ph',
      contactPhone: '+63 912 345 6789',
      tags: ['meeting', 'community', 'official'],
    ),
    EventEntity(
      id: '2',
      title: 'Community Clean-up Drive',
      description: 'Join us for a community clean-up drive to keep our barangay clean and green',
      type: EventType.community,
      status: EventStatus.published,
      organizerId: 'citizen_001',
      organizerName: 'Green Community Group',
      organizerType: 'citizen',
      startDate: DateTime.now().add(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 7, hours: 4)),
      location: 'Main Street to Park',
      isPublic: true,
      maxAttendees: 50,
      registrationRequired: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      registrationDeadline: DateTime.now().add(const Duration(days: 5)),
      contactEmail: 'greencommunity@email.com',
      contactPhone: '+63 912 345 6790',
      tags: ['environment', 'volunteer', 'community'],
    ),
    EventEntity(
      id: '3',
      title: 'Basketball Tournament',
      description: 'Annual barangay basketball tournament for all ages',
      type: EventType.sports,
      status: EventStatus.published,
      organizerId: 'lgu_002',
      organizerName: 'Sports Committee',
      organizerType: 'lgu',
      startDate: DateTime.now().add(const Duration(days: 14)),
      endDate: DateTime.now().add(const Duration(days: 16)),
      location: 'Community Gymnasium',
      isPublic: true,
      maxAttendees: 200,
      registrationRequired: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      registrationDeadline: DateTime.now().add(const Duration(days: 10)),
      registrationFee: 100.0,
      contactEmail: 'sports@lgu.gov.ph',
      contactPhone: '+63 912 345 6791',
      tags: ['sports', 'tournament', 'basketball'],
    ),
  ];

  final List<EventRegistrationEntity> _myRegistrations = [
    EventRegistrationEntity(
      id: '1',
      eventId: '2',
      userId: 'user_001',
      userName: 'John Doe',
      userEmail: 'john.doe@email.com',
      userPhone: '+63 912 345 6789',
      registrationDate: DateTime(2024, 1, 15),
      status: RsvpStatus.attending,
      notes: 'Looking forward to helping clean up the community',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Calendar'),
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
            // Header
            Text(
              'Community Events',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover and join community events, meetings, and activities',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // My Registrations Section
            if (_myRegistrations.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Events',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to all registrations
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ..._myRegistrations.map((registration) {
                final event = _events.firstWhere((e) => e.id == registration.eventId);
                return _buildRegistrationCard(event, registration);
              }),
              const SizedBox(height: 24),
            ],
            
            // Upcoming Events
            Text(
              'Upcoming Events',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Events List
            ..._events.map((event) => _buildEventCard(event)),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationCard(EventEntity event, EventRegistrationEntity registration) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ShadCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getEventTypeColor(event.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getEventTypeIcon(event.type),
                  color: _getEventTypeColor(event.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${event.startDate.day}/${event.startDate.month}/${event.startDate.year} at ${event.startDate.hour.toString().padLeft(2, '0')}:${event.startDate.minute.toString().padLeft(2, '0')}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRsvpStatusColor(registration.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  registration.status.name.toUpperCase(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getRsvpStatusColor(registration.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  event.location,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(EventEntity event) {
    final theme = Theme.of(context);
    final isRegistered = _myRegistrations.any((r) => r.eventId == event.id);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ShadCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Header
            Row(
              children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getEventTypeColor(event.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getEventTypeIcon(event.type),
                  color: _getEventTypeColor(event.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      event.organizerName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (event.isLguOfficial)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'OFFICIAL',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Event Description
          Text(
            event.description,
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          // Event Details
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                '${event.startDate.day}/${event.startDate.month}/${event.startDate.year}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                '${event.startDate.hour.toString().padLeft(2, '0')}:${event.startDate.minute.toString().padLeft(2, '0')} - ${event.endDate.hour.toString().padLeft(2, '0')}:${event.endDate.minute.toString().padLeft(2, '0')}',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  event.location,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          
          if (event.maxAttendees != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Max ${event.maxAttendees} attendees',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
          
          if (event.registrationFee != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Registration Fee: ₱${event.registrationFee!.toStringAsFixed(0)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Tags
          if (event.tags != null && event.tags!.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: event.tags!.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                labelStyle: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
          ],
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ShadButton(
                  text: isRegistered ? 'View Details' : 'View Details',
                  variant: ShadButtonVariant.outline,
                  onPressed: () {
                    _showEventDetails(event);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShadButton(
                  text: isRegistered ? 'Registered' : 'Register',
                  onPressed: isRegistered ? null : () {
                    _showRegistrationForm(event);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getEventTypeIcon(EventType type) {
    switch (type) {
      case EventType.lguOfficial:
        return Icons.account_balance;
      case EventType.citizenLed:
        return Icons.people;
      case EventType.community:
        return Icons.groups;
      case EventType.cultural:
        return Icons.theater_comedy;
      case EventType.sports:
        return Icons.sports;
      case EventType.educational:
        return Icons.school;
      case EventType.religious:
        return Icons.church;
      case EventType.social:
        return Icons.celebration;
      case EventType.emergency:
        return Icons.warning;
    }
  }

  Color _getEventTypeColor(EventType type) {
    switch (type) {
      case EventType.lguOfficial:
        return Colors.blue;
      case EventType.citizenLed:
        return Colors.green;
      case EventType.community:
        return Colors.purple;
      case EventType.cultural:
        return Colors.orange;
      case EventType.sports:
        return Colors.red;
      case EventType.educational:
        return Colors.teal;
      case EventType.religious:
        return Colors.brown;
      case EventType.social:
        return Colors.pink;
      case EventType.emergency:
        return Colors.red;
    }
  }

  Color _getRsvpStatusColor(RsvpStatus status) {
    switch (status) {
      case RsvpStatus.attending:
        return Colors.green;
      case RsvpStatus.notAttending:
        return Colors.red;
      case RsvpStatus.maybe:
        return Colors.orange;
      case RsvpStatus.notResponded:
        return Colors.grey;
    }
  }

  void _showEventDetails(EventEntity event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Event Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getEventTypeColor(event.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getEventTypeIcon(event.type),
                      size: 32,
                      color: _getEventTypeColor(event.type),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'by ${event.organizerName}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Details
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildDetailRow('Date', '${event.startDate.day}/${event.startDate.month}/${event.startDate.year}'),
                      _buildDetailRow('Time', '${event.startDate.hour.toString().padLeft(2, '0')}:${event.startDate.minute.toString().padLeft(2, '0')} - ${event.endDate.hour.toString().padLeft(2, '0')}:${event.endDate.minute.toString().padLeft(2, '0')}'),
                      _buildDetailRow('Location', event.location),
                      if (event.maxAttendees != null)
                        _buildDetailRow('Capacity', '${event.maxAttendees} attendees'),
                      if (event.registrationFee != null)
                        _buildDetailRow('Fee', '₱${event.registrationFee!.toStringAsFixed(0)}'),
                      if (event.contactEmail != null)
                        _buildDetailRow('Contact', event.contactEmail!),
                      
                      if (event.tags != null && event.tags!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Tags',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: event.tags!.map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                            ),
                          )).toList(),
                        ),
                      ],
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ShadButton(
                              text: 'Register',
                              onPressed: () {
                                Navigator.pop(context);
                                _showRegistrationForm(event);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ShadButton(
                              text: 'Add to Calendar',
                              variant: ShadButtonVariant.outline,
                              onPressed: () {
                                // Add to calendar functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Added to calendar')),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _showRegistrationForm(EventEntity event) {
    // This would show a registration form
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration form for ${event.title} would open here'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
