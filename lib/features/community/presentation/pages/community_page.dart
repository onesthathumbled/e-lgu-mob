import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
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
                    'Community Features',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect with your community through events, job postings, marketplace, and more.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Community Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Local Events',
              description: 'Discover and participate in local community events and activities.',
              category: 'Community',
              estimatedTime: 'Instant',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Local events coming soon')),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Job Board',
              description: 'Find local job opportunities and post job openings.',
              category: 'Community',
              estimatedTime: 'Instant',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Job board coming soon')),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Local Marketplace',
              description: 'Buy and sell goods and services within your community.',
              category: 'Community',
              estimatedTime: 'Instant',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Local marketplace coming soon')),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Bayanihan Board',
              description: 'Volunteer for community projects and help your neighbors.',
              category: 'Community',
              estimatedTime: 'Instant',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bayanihan board coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
