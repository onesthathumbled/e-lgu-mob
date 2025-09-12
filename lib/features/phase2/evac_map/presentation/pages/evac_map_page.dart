import 'package:flutter/material.dart';
import '../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/evac_entity.dart';

/// EVAC Map page
class EvacMapPage extends StatefulWidget {
  const EvacMapPage({super.key});

  @override
  State<EvacMapPage> createState() => _EvacMapPageState();
}

class _EvacMapPageState extends State<EvacMapPage> {
  // Mock data for evacuation centers
  List<EvacuationCenterEntity> get _evacuationCenters => [
    EvacuationCenterEntity(
      id: 'evac_001',
      name: 'Sample City Elementary School',
      address: '123 Education St, Barangay 1',
      latitude: 14.5995,
      longitude: 120.9842,
      capacity: 500,
      currentOccupancy: 120,
      status: EvacCenterStatus.available,
      category: EvacCenterCategory.school,
      facilities: [EvacFacility.electricity, EvacFacility.water, EvacFacility.toilets, EvacFacility.kitchen],
      contactNumber: '+63 912 345 6789',
      contactPerson: 'Principal Maria Santos',
      operatingHours: '24/7 during emergencies',
    ),
    EvacuationCenterEntity(
      id: 'evac_002',
      name: 'St. Mary\'s Church',
      address: '456 Faith Ave, Barangay 2',
      latitude: 14.6005,
      longitude: 120.9852,
      capacity: 300,
      currentOccupancy: 45,
      status: EvacCenterStatus.available,
      category: EvacCenterCategory.church,
      facilities: [EvacFacility.electricity, EvacFacility.water, EvacFacility.toilets],
      contactNumber: '+63 912 345 6790',
      contactPerson: 'Father Juan Cruz',
      operatingHours: '24/7 during emergencies',
    ),
    EvacuationCenterEntity(
      id: 'evac_003',
      name: 'Community Center',
      address: '789 Community Blvd, Barangay 3',
      latitude: 14.6015,
      longitude: 120.9862,
      capacity: 200,
      currentOccupancy: 180,
      status: EvacCenterStatus.partial,
      category: EvacCenterCategory.communityCenter,
      facilities: [EvacFacility.electricity, EvacFacility.water, EvacFacility.toilets, EvacFacility.kitchen, EvacFacility.medical],
      contactNumber: '+63 912 345 6791',
      contactPerson: 'Barangay Captain Pedro Reyes',
      operatingHours: '24/7 during emergencies',
    ),
  ];

  // Mock data for disaster alerts
  List<DisasterAlertEntity> get _disasterAlerts => [
    DisasterAlertEntity(
      id: 'alert_001',
      title: 'Typhoon Warning',
      description: 'Typhoon "Bagyo" is approaching with sustained winds of 120 km/h. Heavy rainfall expected.',
      alertType: DisasterType.typhoon,
      severity: AlertSeverity.high,
      affectedAreas: ['Barangay 1', 'Barangay 2', 'Barangay 3'],
      issuedAt: DateTime.now().subtract(const Duration(hours: 2)),
      validUntil: DateTime.now().add(const Duration(hours: 24)),
      status: AlertStatus.active,
      instructions: [
        'Stay indoors and avoid going out',
        'Secure loose objects around your house',
        'Prepare emergency supplies',
        'Monitor weather updates',
      ],
      contactInfo: 'Emergency Hotline: 911',
      evacuationCenters: ['Sample City Elementary School', 'St. Mary\'s Church'],
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EVAC Map'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const ServicesDrawer(),
      body: Column(
        children: [
          // Map placeholder
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Interactive Map',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Evacuation centers, flood zones, and disaster alerts',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          // Information panel
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active alerts
                  if (_disasterAlerts.any((alert) => alert.isActive)) ...[
                    Text(
                      'Active Alerts',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._disasterAlerts.where((alert) => alert.isActive).map((alert) => 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _AlertCard(alert: alert),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Evacuation centers
                  Text(
                    'Evacuation Centers',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _evacuationCenters.length,
                      itemBuilder: (context, index) {
                        final center = _evacuationCenters[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _EvacCenterCard(center: center),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});

  final DisasterAlertEntity alert;

  Color _getSeverityColor() {
    switch (alert.severity) {
      case AlertSeverity.low:
        return Colors.green;
      case AlertSeverity.medium:
        return Colors.yellow;
      case AlertSeverity.high:
        return Colors.orange;
      case AlertSeverity.critical:
        return Colors.red;
    }
  }

  IconData _getDisasterIcon() {
    switch (alert.alertType) {
      case DisasterType.typhoon:
        return Icons.storm;
      case DisasterType.flood:
        return Icons.water;
      case DisasterType.earthquake:
        return Icons.vibration;
      case DisasterType.fire:
        return Icons.local_fire_department;
      case DisasterType.landslide:
        return Icons.terrain;
      case DisasterType.volcanic:
        return Icons.volcano;
      case DisasterType.tsunami:
        return Icons.waves;
      case DisasterType.other:
        return Icons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getSeverityColor().withValues(alpha: 0.3), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getSeverityColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getDisasterIcon(),
                    color: _getSeverityColor(),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        alert.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getSeverityColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    alert.severity.name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getSeverityColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            if (alert.instructions != null) ...[
              const SizedBox(height: 8),
              Text(
                'Instructions:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...alert.instructions!.take(2).map((instruction) => Padding(
                padding: const EdgeInsets.only(left: 8, top: 2),
                child: Text(
                  '• $instruction',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}

class _EvacCenterCard extends StatelessWidget {
  const _EvacCenterCard({required this.center});

  final EvacuationCenterEntity center;

  Color _getStatusColor() {
    switch (center.status) {
      case EvacCenterStatus.available:
        return Colors.green;
      case EvacCenterStatus.partial:
        return Colors.orange;
      case EvacCenterStatus.full:
        return Colors.red;
      case EvacCenterStatus.closed:
        return Colors.grey;
      case EvacCenterStatus.maintenance:
        return Colors.blue;
    }
  }

  String _getStatusText() {
    switch (center.status) {
      case EvacCenterStatus.available:
        return 'Available';
      case EvacCenterStatus.partial:
        return 'Partial';
      case EvacCenterStatus.full:
        return 'Full';
      case EvacCenterStatus.closed:
        return 'Closed';
      case EvacCenterStatus.maintenance:
        return 'Maintenance';
    }
  }

  IconData _getCategoryIcon() {
    switch (center.category) {
      case EvacCenterCategory.school:
        return Icons.school;
      case EvacCenterCategory.church:
        return Icons.church;
      case EvacCenterCategory.communityCenter:
        return Icons.home_work;
      case EvacCenterCategory.gymnasium:
        return Icons.sports;
      case EvacCenterCategory.hospital:
        return Icons.local_hospital;
      case EvacCenterCategory.governmentBuilding:
        return Icons.account_balance;
      case EvacCenterCategory.other:
        return Icons.location_on;
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: _getStatusColor(),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        center.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        center.address,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Capacity information
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  '${center.currentOccupancy}/${center.capacity} people',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${center.availableCapacity} available',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: center.availableCapacity > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            
            // Progress bar
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: center.occupancyPercentage / 100,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
            ),
          ],
        ),
      ),
    );
  }
}
