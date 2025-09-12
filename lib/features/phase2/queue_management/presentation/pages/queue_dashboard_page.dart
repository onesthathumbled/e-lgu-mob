import 'package:flutter/material.dart';
import '../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/queue_entity.dart';

/// Queue dashboard page
class QueueDashboardPage extends StatefulWidget {
  const QueueDashboardPage({super.key});

  @override
  State<QueueDashboardPage> createState() => _QueueDashboardPageState();
}

class _QueueDashboardPageState extends State<QueueDashboardPage> {
  // Mock data for queue offices
  List<QueueOfficeEntity> get _offices => [
    QueueOfficeEntity(
      id: 'office_001',
      name: 'Business Permit Office',
      location: 'City Hall, 2nd Floor',
      operatingHours: '8:00 AM - 5:00 PM',
      services: [QueueServiceType.businessPermit, QueueServiceType.healthPermit],
      currentQueue: 8,
      averageWaitTime: 25,
      isOpen: true,
      capacity: 20,
      currentServing: 'A-015',
      nextAvailable: DateTime.now().add(const Duration(minutes: 15)),
    ),
    QueueOfficeEntity(
      id: 'office_002',
      name: 'Property Tax Office',
      location: 'City Hall, 1st Floor',
      operatingHours: '8:00 AM - 5:00 PM',
      services: [QueueServiceType.propertyTax, QueueServiceType.violationPayment],
      currentQueue: 3,
      averageWaitTime: 15,
      isOpen: true,
      capacity: 15,
      currentServing: 'B-008',
      nextAvailable: DateTime.now().add(const Duration(minutes: 8)),
    ),
    QueueOfficeEntity(
      id: 'office_003',
      name: 'Civil Registry Office',
      location: 'City Hall, 3rd Floor',
      operatingHours: '8:00 AM - 5:00 PM',
      services: [QueueServiceType.civilRegistry, QueueServiceType.documentRequest],
      currentQueue: 12,
      averageWaitTime: 35,
      isOpen: true,
      capacity: 25,
      currentServing: 'C-022',
      nextAvailable: DateTime.now().add(const Duration(minutes: 20)),
    ),
    QueueOfficeEntity(
      id: 'office_004',
      name: 'Building & Zoning Office',
      location: 'City Hall, 4th Floor',
      operatingHours: '8:00 AM - 5:00 PM',
      services: [QueueServiceType.buildingPermit, QueueServiceType.generalInquiry],
      currentQueue: 5,
      averageWaitTime: 20,
      isOpen: true,
      capacity: 18,
      currentServing: 'D-012',
      nextAvailable: DateTime.now().add(const Duration(minutes: 12)),
    ),
  ];

  // Mock data for user's active tickets
  List<QueueTicketEntity> get _userTickets => [
    QueueTicketEntity(
      id: 'ticket_001',
      ticketNumber: 'A-016',
      serviceType: QueueServiceType.businessPermit,
      citizenName: 'John Doe',
      citizenContact: '+63 912 345 6789',
      estimatedWaitTime: 30,
      status: QueueStatus.waiting,
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      priority: QueuePriority.normal,
      officeLocation: 'City Hall, 2nd Floor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue Management'),
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
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Queue Management System',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Book your slot remotely and track your queue status in real-time.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // User's Active Tickets
            if (_userTickets.isNotEmpty) ...[
              Text(
                'Your Active Tickets',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._userTickets.map((ticket) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _ActiveTicketCard(ticket: ticket),
              )),
              const SizedBox(height: 24),
            ],
            
            // Office Status
            Text(
              'Office Status',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._offices.map((office) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _OfficeStatusCard(office: office),
            )),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'Book New Ticket',
                    onPressed: () {
                      _showBookTicketDialog();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'View All Tickets',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('View all tickets coming soon')),
                      );
                    },
                    icon: const Icon(Icons.list),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBookTicketDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book New Ticket'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select the service you need:'),
            const SizedBox(height: 16),
            ...QueueServiceType.values.map((service) => ListTile(
              title: Text(_getServiceName(service)),
              onTap: () {
                Navigator.of(context).pop();
                _bookTicket(service);
              },
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _bookTicket(QueueServiceType serviceType) {
    // Mock ticket booking
    final ticketNumber = _generateTicketNumber(serviceType);
    final estimatedWait = _getEstimatedWaitTime(serviceType);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ticket booked! Your number is $ticketNumber. Estimated wait: $estimatedWait minutes.'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  String _generateTicketNumber(QueueServiceType serviceType) {
    final prefix = _getServicePrefix(serviceType);
    final number = (100 + DateTime.now().millisecondsSinceEpoch % 900).toString();
    return '$prefix-$number';
  }

  String _getServicePrefix(QueueServiceType serviceType) {
    switch (serviceType) {
      case QueueServiceType.businessPermit:
        return 'A';
      case QueueServiceType.propertyTax:
        return 'B';
      case QueueServiceType.civilRegistry:
        return 'C';
      case QueueServiceType.buildingPermit:
        return 'D';
      case QueueServiceType.healthPermit:
        return 'E';
      case QueueServiceType.tricycleFranchise:
        return 'F';
      case QueueServiceType.parkingPermit:
        return 'G';
      case QueueServiceType.violationPayment:
        return 'H';
      case QueueServiceType.generalInquiry:
        return 'I';
      case QueueServiceType.documentRequest:
        return 'J';
    }
  }

  int _getEstimatedWaitTime(QueueServiceType serviceType) {
    switch (serviceType) {
      case QueueServiceType.businessPermit:
        return 30;
      case QueueServiceType.propertyTax:
        return 15;
      case QueueServiceType.civilRegistry:
        return 35;
      case QueueServiceType.buildingPermit:
        return 45;
      case QueueServiceType.healthPermit:
        return 20;
      case QueueServiceType.tricycleFranchise:
        return 25;
      case QueueServiceType.parkingPermit:
        return 10;
      case QueueServiceType.violationPayment:
        return 15;
      case QueueServiceType.generalInquiry:
        return 10;
      case QueueServiceType.documentRequest:
        return 20;
    }
  }

  String _getServiceName(QueueServiceType serviceType) {
    switch (serviceType) {
      case QueueServiceType.businessPermit:
        return 'Business Permit';
      case QueueServiceType.propertyTax:
        return 'Property Tax';
      case QueueServiceType.civilRegistry:
        return 'Civil Registry';
      case QueueServiceType.buildingPermit:
        return 'Building Permit';
      case QueueServiceType.healthPermit:
        return 'Health Permit';
      case QueueServiceType.tricycleFranchise:
        return 'Tricycle Franchise';
      case QueueServiceType.parkingPermit:
        return 'Parking Permit';
      case QueueServiceType.violationPayment:
        return 'Violation Payment';
      case QueueServiceType.generalInquiry:
        return 'General Inquiry';
      case QueueServiceType.documentRequest:
        return 'Document Request';
    }
  }
}

class _ActiveTicketCard extends StatelessWidget {
  const _ActiveTicketCard({required this.ticket});

  final QueueTicketEntity ticket;

  Color _getStatusColor() {
    switch (ticket.status) {
      case QueueStatus.waiting:
        return Colors.orange;
      case QueueStatus.serving:
        return Colors.blue;
      case QueueStatus.completed:
        return Colors.green;
      case QueueStatus.cancelled:
        return Colors.red;
      case QueueStatus.noShow:
        return Colors.grey;
    }
  }

  String _getStatusText() {
    switch (ticket.status) {
      case QueueStatus.waiting:
        return 'Waiting';
      case QueueStatus.serving:
        return 'Being Served';
      case QueueStatus.completed:
        return 'Completed';
      case QueueStatus.cancelled:
        return 'Cancelled';
      case QueueStatus.noShow:
        return 'No Show';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getStatusColor().withOpacity(0.3), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with ticket number and status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ticket.ticketNumber,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Service type
            Text(
              _getServiceName(ticket.serviceType),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Time information
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Estimated wait: ${ticket.estimatedWaitTime} minutes',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            
            if (ticket.timeRemaining > 0) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: 16,
                    color: Colors.orange.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Time remaining: ${ticket.timeRemaining} minutes',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.orange.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
            
            const SizedBox(height: 12),
            
            // Progress indicator
            if (ticket.status == QueueStatus.waiting) ...[
              LinearProgressIndicator(
                value: 1.0 - (ticket.timeRemaining / ticket.estimatedWaitTime),
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
              ),
              const SizedBox(height: 8),
              Text(
                'You are in queue. Please wait for your turn.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ] else if (ticket.status == QueueStatus.serving) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Please proceed to the counter',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getServiceName(QueueServiceType serviceType) {
    switch (serviceType) {
      case QueueServiceType.businessPermit:
        return 'Business Permit';
      case QueueServiceType.propertyTax:
        return 'Property Tax';
      case QueueServiceType.civilRegistry:
        return 'Civil Registry';
      case QueueServiceType.buildingPermit:
        return 'Building Permit';
      case QueueServiceType.healthPermit:
        return 'Health Permit';
      case QueueServiceType.tricycleFranchise:
        return 'Tricycle Franchise';
      case QueueServiceType.parkingPermit:
        return 'Parking Permit';
      case QueueServiceType.violationPayment:
        return 'Violation Payment';
      case QueueServiceType.generalInquiry:
        return 'General Inquiry';
      case QueueServiceType.documentRequest:
        return 'Document Request';
    }
  }
}

class _OfficeStatusCard extends StatelessWidget {
  const _OfficeStatusCard({required this.office});

  final QueueOfficeEntity office;

  Color _getQueueStatusColor() {
    if (!office.isOpen) return Colors.grey;
    if (office.isAtCapacity) return Colors.red;
    if (office.currentQueue == 0) return Colors.green;
    if (office.currentQueue <= 5) return Colors.blue;
    if (office.currentQueue <= 15) return Colors.orange;
    return Colors.red;
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
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    office.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getQueueStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    office.queueStatus,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getQueueStatusColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  office.location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Queue information
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  '${office.currentQueue} people in queue',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  '${office.averageWaitTime} min avg',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            
            if (office.currentServing != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 16,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Currently serving: ${office.currentServing}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
            
            const SizedBox(height: 12),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: ShadButton(
                text: office.isOpen ? 'Book Ticket' : 'Office Closed',
                onPressed: office.isOpen ? () {
                  // Navigate to booking for this office
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking for ${office.name} coming soon')),
                  );
                } : null,
                variant: office.isOpen ? ShadButtonVariant.primary : ShadButtonVariant.outline,
                icon: Icon(office.isOpen ? Icons.add : Icons.lock),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
