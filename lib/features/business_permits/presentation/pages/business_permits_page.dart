import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';

/// Business Permits page
class BusinessPermitsPage extends StatelessWidget {
  const BusinessPermitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Permits'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: const ServicesDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Permit & Licensing System (BPLS)',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apply for new business permits, renew existing ones, or make amendments to your business registration.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Services section
            Text(
              'Available Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Service cards
            ServiceCard(
              title: 'New Business Permit',
              description: 'Apply for a new business permit to start your business operations.',
              category: 'Business',
              estimatedTime: '5-7 business days',
              onTap: () {
                // TODO: Navigate to new business permit form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('New Business Permit form coming soon'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Business Permit Renewal',
              description: 'Renew your existing business permit before it expires.',
              category: 'Business',
              estimatedTime: '3-5 business days',
              onTap: () {
                // TODO: Navigate to renewal form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Business Permit Renewal form coming soon'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Business Permit Amendment',
              description: 'Make changes to your existing business permit information.',
              category: 'Business',
              estimatedTime: '3-5 business days',
              onTap: () {
                // TODO: Navigate to amendment form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Business Permit Amendment form coming soon'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Business Closure',
              description: 'Formally close your business and cancel your permit.',
              category: 'Business',
              estimatedTime: '1-2 business days',
              onTap: () {
                // TODO: Navigate to closure form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Business Closure form coming soon'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Quick actions
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
                    text: 'Track Application',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      // TODO: Navigate to tracking page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Application tracking coming soon'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.track_changes),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ShadButton(
                    text: 'View History',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      // TODO: Navigate to history page
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Application history coming soon'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.history),
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
