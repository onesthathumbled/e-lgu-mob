import 'package:flutter/material.dart';
import '../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../shared/widgets/main_navigation.dart';

/// Transport services page
class TransportServicesPage extends StatelessWidget {
  const TransportServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport & Mobility'),
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
                    'Transport & Local Mobility',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage tricycle franchises, parking permits, and traffic violations.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Service Cards
            Text(
              'Transport Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Tricycle Franchise
            _ServiceCard(
              icon: Icons.motorcycle,
              title: 'Tricycle Franchise',
              description: 'Apply for or renew tricycle franchise permits',
              color: Colors.blue,
              onTap: () {
                _showTricycleFranchiseDialog(context);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Parking Permits
            _ServiceCard(
              icon: Icons.local_parking,
              title: 'Parking Permits',
              description: 'Apply for residential or commercial parking permits',
              color: Colors.green,
              onTap: () {
                _showParkingPermitDialog(context);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Traffic Violations
            _ServiceCard(
              icon: Icons.warning,
              title: 'Traffic Violations',
              description: 'View and pay traffic violation fines',
              color: Colors.orange,
              onTap: () {
                _showTrafficViolationsDialog(context);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Adjudication Calendar
            _ServiceCard(
              icon: Icons.calendar_today,
              title: 'Adjudication Calendar',
              description: 'Schedule hearings for contested violations',
              color: Colors.purple,
              onTap: () {
                _showAdjudicationCalendarDialog(context);
              },
            ),
            
            const SizedBox(height: 24),
            
            // Quick Stats
            Text(
              'Quick Stats',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Active Franchises',
                    value: '1,245',
                    icon: Icons.motorcycle,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Parking Permits',
                    value: '3,892',
                    icon: Icons.local_parking,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Pending Violations',
                    value: '156',
                    icon: Icons.warning,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Monthly Revenue',
                    value: '₱2.4M',
                    icon: Icons.attach_money,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTricycleFranchiseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tricycle Franchise'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tricycle Franchise Services:'),
            SizedBox(height: 16),
            Text('• New Franchise Application'),
            Text('• Franchise Renewal'),
            Text('• Route Modification'),
            Text('• Franchise Transfer'),
            Text('• Status Inquiry'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tricycle franchise application form coming soon')),
              );
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showParkingPermitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Parking Permits'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Parking Permit Services:'),
            SizedBox(height: 16),
            Text('• Residential Parking Permit'),
            Text('• Commercial Parking Permit'),
            Text('• Temporary Parking Permit'),
            Text('• Special Event Parking'),
            Text('• Permit Renewal'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Parking permit application form coming soon')),
              );
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showTrafficViolationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Traffic Violations'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Traffic Violation Services:'),
            SizedBox(height: 16),
            Text('• View Violation Records'),
            Text('• Pay Violation Fines'),
            Text('• Contest Violations'),
            Text('• Schedule Adjudication'),
            Text('• Payment History'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Traffic violations portal coming soon')),
              );
            },
            child: const Text('View'),
          ),
        ],
      ),
    );
  }

  void _showAdjudicationCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adjudication Calendar'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adjudication Services:'),
            SizedBox(height: 16),
            Text('• Schedule Hearing'),
            Text('• View Hearing Schedule'),
            Text('• Reschedule Hearing'),
            Text('• Hearing Results'),
            Text('• Appeal Process'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Adjudication calendar coming soon')),
              );
            },
            child: const Text('Schedule'),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

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
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

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
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
