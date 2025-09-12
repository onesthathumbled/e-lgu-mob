import 'package:flutter/material.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/waste_schedule_entity.dart';

class WasteSchedulePage extends StatefulWidget {
  const WasteSchedulePage({super.key});

  @override
  State<WasteSchedulePage> createState() => _WasteSchedulePageState();
}

class _WasteSchedulePageState extends State<WasteSchedulePage> {
  final List<WasteScheduleEntity> _upcomingSchedules = [
    WasteScheduleEntity(
      id: '1',
      barangayId: 'brgy_001',
      barangayName: 'Barangay 1',
      zone: 'Zone A',
      wasteType: WasteType.general,
      collectionDate: DateTime.now().add(const Duration(days: 1)),
      collectionTime: '08:00',
      status: CollectionStatus.scheduled,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      residentsNotified: true,
    ),
    WasteScheduleEntity(
      id: '2',
      barangayId: 'brgy_001',
      barangayName: 'Barangay 1',
      zone: 'Zone A',
      wasteType: WasteType.recyclable,
      collectionDate: DateTime.now().add(const Duration(days: 3)),
      collectionTime: '09:00',
      status: CollectionStatus.scheduled,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      residentsNotified: true,
    ),
    WasteScheduleEntity(
      id: '3',
      barangayId: 'brgy_001',
      barangayName: 'Barangay 1',
      zone: 'Zone A',
      wasteType: WasteType.biodegradable,
      collectionDate: DateTime.now().add(const Duration(days: 5)),
      collectionTime: '10:00',
      status: CollectionStatus.scheduled,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      residentsNotified: true,
    ),
  ];

  final BarangayWasteInfoEntity _barangayInfo = const BarangayWasteInfoEntity(
    barangayId: 'brgy_001',
    barangayName: 'Barangay 1',
    zones: ['Zone A', 'Zone B', 'Zone C'],
    collectionSchedule: {
      WasteType.general: ['monday', 'wednesday', 'friday'],
      WasteType.recyclable: ['tuesday', 'thursday'],
      WasteType.biodegradable: ['monday', 'wednesday', 'friday'],
      WasteType.hazardous: ['saturday'],
      WasteType.electronic: ['saturday'],
      WasteType.bulky: ['saturday'],
    },
    contactInfo: {
      'phone': '+63 912 345 6789',
      'email': 'waste@lgu.gov.ph',
      'office': 'Environmental Services Office',
    },
    specialInstructions: [
      'Separate waste into appropriate categories',
      'Place waste bins outside by 7:00 AM on collection day',
      'Do not mix hazardous waste with regular waste',
      'Contact office for bulky waste collection',
    ],
    recyclingCenter: 'Community Recycling Center, Main Street',
    hazardousWasteDropOff: 'Environmental Services Office, Barangay Hall',
    bulkyWasteCollection: 'Call +63 912 345 6789 to schedule',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Schedule'),
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
              'Waste Collection Schedule',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Stay informed about garbage collection schedules and waste management guidelines',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Today's Collection
            _buildTodaysCollection(),
            
            const SizedBox(height: 24),
            
            // Upcoming Collections
            Text(
              'Upcoming Collections',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            ..._upcomingSchedules.map((schedule) => _buildScheduleCard(schedule)),
            
            const SizedBox(height: 24),
            
            // Collection Schedule
            _buildCollectionSchedule(),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildQuickActionCard(
                  'Set Reminder',
                  Icons.notifications,
                  Colors.blue,
                  () {
                    _setReminder();
                  },
                ),
                _buildQuickActionCard(
                  'Report Missed Collection',
                  Icons.report_problem,
                  Colors.red,
                  () {
                    _reportMissedCollection();
                  },
                ),
                _buildQuickActionCard(
                  'Waste Guidelines',
                  Icons.info,
                  Colors.green,
                  () {
                    _showWasteGuidelines();
                  },
                ),
                _buildQuickActionCard(
                  'Contact Office',
                  Icons.phone,
                  Colors.purple,
                  () {
                    _contactOffice();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodaysCollection() {
    final todaysSchedules = _upcomingSchedules.where((schedule) => schedule.isToday).toList();
    
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.today,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Today\'s Collection',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          if (todaysSchedules.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No collection scheduled for today',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )
          else
            ...todaysSchedules.map((schedule) => _buildTodayScheduleItem(schedule)),
        ],
      ),
    );
  }

  Widget _buildTodayScheduleItem(WasteScheduleEntity schedule) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getWasteTypeColor(schedule.wasteType).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getWasteTypeColor(schedule.wasteType).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getWasteTypeColor(schedule.wasteType),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getWasteTypeIcon(schedule.wasteType),
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getWasteTypeName(schedule.wasteType),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${schedule.zone} • ${schedule.collectionTime}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'TODAY',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(WasteScheduleEntity schedule) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ShadCard(
        child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getWasteTypeColor(schedule.wasteType).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getWasteTypeIcon(schedule.wasteType),
              color: _getWasteTypeColor(schedule.wasteType),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getWasteTypeName(schedule.wasteType),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${schedule.barangayName} • ${schedule.zone}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${schedule.collectionDate.day}/${schedule.collectionDate.month}/${schedule.collectionDate.year}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      schedule.collectionTime,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(schedule.status).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              schedule.status.name.toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: _getStatusColor(schedule.status),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildCollectionSchedule() {
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Collection Schedule',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Schedule Table
          ...WasteType.values.map((wasteType) => _buildScheduleRow(wasteType)),
          
          const SizedBox(height: 16),
          
          // Special Instructions
          Text(
            'Special Instructions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ..._barangayInfo.specialInstructions.map((instruction) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Expanded(
                  child: Text(
                    instruction,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(WasteType wasteType) {
    final days = _barangayInfo.getCollectionDays(wasteType);
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getWasteTypeColor(wasteType).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              _getWasteTypeIcon(wasteType),
              color: _getWasteTypeColor(wasteType),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _getWasteTypeName(wasteType),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            days.isEmpty ? 'As needed' : days.join(', '),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return ShadCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWasteTypeIcon(WasteType type) {
    switch (type) {
      case WasteType.general:
        return Icons.delete;
      case WasteType.recyclable:
        return Icons.recycling;
      case WasteType.biodegradable:
        return Icons.eco;
      case WasteType.hazardous:
        return Icons.warning;
      case WasteType.electronic:
        return Icons.devices;
      case WasteType.bulky:
        return Icons.chair;
    }
  }

  Color _getWasteTypeColor(WasteType type) {
    switch (type) {
      case WasteType.general:
        return Colors.grey;
      case WasteType.recyclable:
        return Colors.blue;
      case WasteType.biodegradable:
        return Colors.green;
      case WasteType.hazardous:
        return Colors.red;
      case WasteType.electronic:
        return Colors.purple;
      case WasteType.bulky:
        return Colors.brown;
    }
  }

  String _getWasteTypeName(WasteType type) {
    switch (type) {
      case WasteType.general:
        return 'General Waste';
      case WasteType.recyclable:
        return 'Recyclable';
      case WasteType.biodegradable:
        return 'Biodegradable';
      case WasteType.hazardous:
        return 'Hazardous';
      case WasteType.electronic:
        return 'Electronic';
      case WasteType.bulky:
        return 'Bulky';
    }
  }

  Color _getStatusColor(CollectionStatus status) {
    switch (status) {
      case CollectionStatus.scheduled:
        return Colors.blue;
      case CollectionStatus.inProgress:
        return Colors.orange;
      case CollectionStatus.completed:
        return Colors.green;
      case CollectionStatus.missed:
        return Colors.red;
      case CollectionStatus.rescheduled:
        return Colors.purple;
      case CollectionStatus.cancelled:
        return Colors.grey;
    }
  }

  void _setReminder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reminder settings would open here'),
      ),
    );
  }

  void _reportMissedCollection() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Missed collection report form would open here'),
      ),
    );
  }

  void _showWasteGuidelines() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Waste Management Guidelines'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('General Waste:'),
              Text('• Food scraps, non-recyclable materials'),
              Text('• Place in black bags'),
              SizedBox(height: 8),
              Text('Recyclable:'),
              Text('• Paper, plastic bottles, cans, glass'),
              Text('• Clean and dry before placing in blue bags'),
              SizedBox(height: 8),
              Text('Biodegradable:'),
              Text('• Food waste, garden trimmings'),
              Text('• Place in green bags or compost bins'),
              SizedBox(height: 8),
              Text('Hazardous:'),
              Text('• Batteries, chemicals, paint'),
              Text('• Bring to designated drop-off points'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _contactOffice() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Office: ${_barangayInfo.contactInfo['office']}'),
            Text('Phone: ${_barangayInfo.contactInfo['phone']}'),
            Text('Email: ${_barangayInfo.contactInfo['email']}'),
            const SizedBox(height: 16),
            if (_barangayInfo.recyclingCenter != null)
              Text('Recycling Center: ${_barangayInfo.recyclingCenter}'),
            if (_barangayInfo.hazardousWasteDropOff != null)
              Text('Hazardous Waste Drop-off: ${_barangayInfo.hazardousWasteDropOff}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
