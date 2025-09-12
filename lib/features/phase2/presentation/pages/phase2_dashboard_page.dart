import 'package:flutter/material.dart';
import '../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../shared/widgets/main_navigation.dart';
import '../../queue_management/presentation/pages/queue_dashboard_page.dart';
import '../../obos/presentation/pages/obos_application_page.dart';
import '../../transport/presentation/pages/transport_services_page.dart';
import '../../evac_map/presentation/pages/evac_map_page.dart';
import '../../community_groups/presentation/pages/community_groups_page.dart';
import '../../gamification/presentation/pages/gamification_page.dart';

/// Phase 2 dashboard page
class Phase2DashboardPage extends StatelessWidget {
  const Phase2DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phase 2 Features'),
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
                    'Phase 2 Features',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Advanced LGU services and community features for enhanced citizen engagement.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Service Categories
            Text(
              'Advanced Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Queue Management
            _ServiceCard(
              icon: Icons.queue,
              title: 'Queue Management',
              description: 'Digital queue system for LGU offices with real-time updates',
              color: Colors.blue,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QueueDashboardPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // OBOS System
            _ServiceCard(
              icon: Icons.construction,
              title: 'Building & Zoning (OBOS)',
              description: 'End-to-end building permit and zoning clearance system',
              color: Colors.orange,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ObosApplicationPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Transport & Mobility
            _ServiceCard(
              icon: Icons.directions_car,
              title: 'Transport & Mobility',
              description: 'Tricycle franchises, parking permits, and traffic violations',
              color: Colors.green,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TransportServicesPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Information & Community
            Text(
              'Information & Community',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // EVAC Map
            _ServiceCard(
              icon: Icons.map,
              title: 'EVAC Map',
              description: 'Evacuation centers and disaster alerts with offline support',
              color: Colors.red,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EvacMapPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Community Groups
            _ServiceCard(
              icon: Icons.groups,
              title: 'Community Groups',
              description: 'Join groups, participate in discussions, and connect with neighbors',
              color: Colors.purple,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommunityGroupsPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Gamification
            _ServiceCard(
              icon: Icons.stars,
              title: 'Rewards & Points',
              description: 'Earn points for community participation and redeem rewards',
              color: Colors.amber,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GamificationPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Quick Stats
            Text(
              'Phase 2 Statistics',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Active Queues',
                    value: '12',
                    icon: Icons.queue,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Building Permits',
                    value: '45',
                    icon: Icons.construction,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Community Groups',
                    value: '23',
                    icon: Icons.groups,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Points Earned',
                    value: '2.4K',
                    icon: Icons.stars,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
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
