import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/hazard_report_entity.dart';

class HazardReportingPage extends StatefulWidget {
  const HazardReportingPage({super.key});

  @override
  State<HazardReportingPage> createState() => _HazardReportingPageState();
}

class _HazardReportingPageState extends State<HazardReportingPage> {
  final List<HazardReportEntity> _myReports = [
    HazardReportEntity(
      id: '1',
      reporterId: 'user_001',
      reporterName: 'John Doe',
      reporterEmail: 'john.doe@email.com',
      reporterPhone: '+63 912 345 6789',
      hazardType: HazardType.roadDamage,
      severity: HazardSeverity.medium,
      title: 'Pothole on Main Street',
      description: 'Large pothole near the intersection causing traffic issues',
      location: 'Main Street, near Barangay Hall',
      latitude: 14.5995,
      longitude: 120.9842,
      status: HazardReportStatus.assigned,
      reportDate: DateTime.now().subtract(const Duration(days: 3)),
      isAnonymous: false,
      assignedTo: 'Public Works Department',
      assignedDate: DateTime.now().subtract(const Duration(days: 2)),
      estimatedResolutionDate: DateTime.now().add(const Duration(days: 7)),
      images: ['image1.jpg', 'image2.jpg'],
      priority: 2,
    ),
    HazardReportEntity(
      id: '2',
      reporterId: 'user_001',
      reporterName: 'John Doe',
      reporterEmail: 'john.doe@email.com',
      reporterPhone: '+63 912 345 6789',
      hazardType: HazardType.brokenStreetlight,
      severity: HazardSeverity.low,
      title: 'Broken Streetlight',
      description: 'Streetlight not working on residential street',
      location: 'Residential Street, Zone A',
      latitude: 14.6000,
      longitude: 120.9850,
      status: HazardReportStatus.resolved,
      reportDate: DateTime.now().subtract(const Duration(days: 10)),
      isAnonymous: false,
      assignedTo: 'Electrical Department',
      assignedDate: DateTime.now().subtract(const Duration(days: 9)),
      actualResolutionDate: DateTime.now().subtract(const Duration(days: 2)),
      resolutionNotes: 'Streetlight repaired and tested working',
      images: ['image3.jpg'],
      priority: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hazard Reporting'),
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
              'Report Hazards',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Report road damage, electrical issues, flooding, and other hazards in your community',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Emergency Notice
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency?',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'For life-threatening emergencies, call 911 immediately',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // My Reports Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Reports',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ShadButton(
                  text: 'New Report',
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    _showReportForm();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (_myReports.isEmpty)
              ShadCard(
                child: Column(
                  children: [
                    Icon(
                      Icons.report_problem,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No reports submitted yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Report hazards in your community to help keep everyone safe',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ShadButton(
                      text: 'Submit Report',
                      onPressed: () {
                        _showReportForm();
                      },
                    ),
                  ],
                ),
              )
            else
              ..._myReports.map((report) => _buildReportCard(report)),
            
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
                  'Road Damage',
                  Icons.construction,
                  Colors.orange,
                  () {
                    _showQuickReport(HazardType.roadDamage);
                  },
                ),
                _buildQuickActionCard(
                  'Electrical Issue',
                  Icons.electrical_services,
                  Colors.yellow,
                  () {
                    _showQuickReport(HazardType.electricalPost);
                  },
                ),
                _buildQuickActionCard(
                  'Flooding',
                  Icons.water,
                  Colors.blue,
                  () {
                    _showQuickReport(HazardType.flooding);
                  },
                ),
                _buildQuickActionCard(
                  'Other Hazard',
                  Icons.warning,
                  Colors.red,
                  () {
                    _showQuickReport(HazardType.other);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(HazardReportEntity report) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ShadCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getHazardTypeColor(report.hazardType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getHazardTypeIcon(report.hazardType),
                    color: _getHazardTypeColor(report.hazardType),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${report.reportDate.day}/${report.reportDate.month}/${report.reportDate.year}',
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
                    color: _getStatusColor(report.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    report.status.name.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(report.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
            const SizedBox(height: 12),
            
            // Report Details
            Text(
              report.description,
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Location and Severity
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
                    report.location,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          
            const SizedBox(height: 8),
            
            Row(
              children: [
                Icon(
                  Icons.priority_high,
                  size: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Severity: ${report.severity.name.toUpperCase()}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _getSeverityColor(report.severity),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          
            if (report.assignedTo != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.assignment,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Assigned to: ${report.assignedTo}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          
            if (report.estimatedResolutionDate != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Expected: ${report.estimatedResolutionDate!.day}/${report.estimatedResolutionDate!.month}/${report.estimatedResolutionDate!.year}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          
            const SizedBox(height: 16),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'View Details',
                    variant: ShadButtonVariant.outline,
                    size: ShadButtonSize.sm,
                    onPressed: () {
                      _showReportDetails(report);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'Update',
                    size: ShadButtonSize.sm,
                    onPressed: () {
                      _updateReport(report);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
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
                color: color.withOpacity(0.1),
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

  IconData _getHazardTypeIcon(HazardType type) {
    switch (type) {
      case HazardType.roadDamage:
        return Icons.construction;
      case HazardType.electricalPost:
        return Icons.electrical_services;
      case HazardType.flooding:
        return Icons.water;
      case HazardType.fallenTree:
        return Icons.park;
      case HazardType.brokenStreetlight:
        return Icons.lightbulb;
      case HazardType.damagedSidewalk:
        return Icons.directions_walk;
      case HazardType.blockedDrainage:
        return Icons.water_drop;
      case HazardType.looseWires:
        return Icons.cable;
      case HazardType.damagedBridge:
        return Icons.construction;
      case HazardType.landslide:
        return Icons.terrain;
      case HazardType.fireHazard:
        return Icons.local_fire_department;
      case HazardType.waterLeak:
        return Icons.water_damage;
      case HazardType.gasLeak:
        return Icons.gas_meter;
      case HazardType.structuralDamage:
        return Icons.home_repair_service;
      case HazardType.other:
        return Icons.warning;
    }
  }

  Color _getHazardTypeColor(HazardType type) {
    switch (type) {
      case HazardType.roadDamage:
        return Colors.orange;
      case HazardType.electricalPost:
        return Colors.yellow;
      case HazardType.flooding:
        return Colors.blue;
      case HazardType.fallenTree:
        return Colors.green;
      case HazardType.brokenStreetlight:
        return Colors.amber;
      case HazardType.damagedSidewalk:
        return Colors.brown;
      case HazardType.blockedDrainage:
        return Colors.cyan;
      case HazardType.looseWires:
        return Colors.red;
      case HazardType.damagedBridge:
        return Colors.grey;
      case HazardType.landslide:
        return Colors.brown;
      case HazardType.fireHazard:
        return Colors.red;
      case HazardType.waterLeak:
        return Colors.blue;
      case HazardType.gasLeak:
        return Colors.orange;
      case HazardType.structuralDamage:
        return Colors.red;
      case HazardType.other:
        return Colors.purple;
    }
  }

  Color _getStatusColor(HazardReportStatus status) {
    switch (status) {
      case HazardReportStatus.submitted:
        return Colors.blue;
      case HazardReportStatus.underReview:
        return Colors.orange;
      case HazardReportStatus.assigned:
        return Colors.purple;
      case HazardReportStatus.inProgress:
        return Colors.amber;
      case HazardReportStatus.resolved:
        return Colors.green;
      case HazardReportStatus.closed:
        return Colors.grey;
      case HazardReportStatus.rejected:
        return Colors.red;
    }
  }

  Color _getSeverityColor(HazardSeverity severity) {
    switch (severity) {
      case HazardSeverity.low:
        return Colors.green;
      case HazardSeverity.medium:
        return Colors.orange;
      case HazardSeverity.high:
        return Colors.red;
      case HazardSeverity.critical:
        return Colors.red;
      case HazardSeverity.emergency:
        return Colors.red;
    }
  }

  void _showReportDetails(HazardReportEntity report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
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
              
              // Report Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getHazardTypeColor(report.hazardType).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getHazardTypeIcon(report.hazardType),
                      size: 32,
                      color: _getHazardTypeColor(report.hazardType),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Reported on ${report.reportDate.day}/${report.reportDate.month}/${report.reportDate.year}',
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
                        report.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildDetailRow('Hazard Type', _getHazardTypeName(report.hazardType)),
                      _buildDetailRow('Severity', report.severity.name.toUpperCase()),
                      _buildDetailRow('Location', report.location),
                      _buildDetailRow('Status', report.status.name.toUpperCase()),
                      if (report.assignedTo != null)
                        _buildDetailRow('Assigned To', report.assignedTo!),
                      if (report.estimatedResolutionDate != null)
                        _buildDetailRow('Expected Resolution', '${report.estimatedResolutionDate!.day}/${report.estimatedResolutionDate!.month}/${report.estimatedResolutionDate!.year}'),
                      if (report.actualResolutionDate != null)
                        _buildDetailRow('Resolved On', '${report.actualResolutionDate!.day}/${report.actualResolutionDate!.month}/${report.actualResolutionDate!.year}'),
                      if (report.resolutionNotes != null)
                        _buildDetailRow('Resolution Notes', report.resolutionNotes!),
                      
                      if (report.images != null && report.images!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Images',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: report.images!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 100,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text('Image ${index + 1}'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ShadButton(
                              text: 'Update Report',
                              onPressed: () {
                                Navigator.pop(context);
                                _updateReport(report);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ShadButton(
                              text: 'Share Location',
                              variant: ShadButtonVariant.outline,
                              onPressed: () {
                                // Share location functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Location shared')),
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
            width: 120,
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

  String _getHazardTypeName(HazardType type) {
    switch (type) {
      case HazardType.roadDamage:
        return 'Road Damage';
      case HazardType.electricalPost:
        return 'Electrical Post';
      case HazardType.flooding:
        return 'Flooding';
      case HazardType.fallenTree:
        return 'Fallen Tree';
      case HazardType.brokenStreetlight:
        return 'Broken Streetlight';
      case HazardType.damagedSidewalk:
        return 'Damaged Sidewalk';
      case HazardType.blockedDrainage:
        return 'Blocked Drainage';
      case HazardType.looseWires:
        return 'Loose Wires';
      case HazardType.damagedBridge:
        return 'Damaged Bridge';
      case HazardType.landslide:
        return 'Landslide';
      case HazardType.fireHazard:
        return 'Fire Hazard';
      case HazardType.waterLeak:
        return 'Water Leak';
      case HazardType.gasLeak:
        return 'Gas Leak';
      case HazardType.structuralDamage:
        return 'Structural Damage';
      case HazardType.other:
        return 'Other';
    }
  }

  void _showReportForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hazard report form would open here'),
      ),
    );
  }

  void _showQuickReport(HazardType type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quick report for ${_getHazardTypeName(type)} would open here'),
      ),
    );
  }

  void _updateReport(HazardReportEntity report) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Update form for "${report.title}" would open here'),
      ),
    );
  }
}
