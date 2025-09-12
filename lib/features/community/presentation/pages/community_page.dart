import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import 'community_events_page.dart';
import 'community_jobs_page.dart';
import 'community_marketplace_page.dart';
import '../../../phase3/events_calendar/presentation/pages/events_calendar_page.dart';
import '../../../phase2/community_groups/presentation/pages/community_groups_page.dart';
import '../../../phase3/facility_bookings/presentation/pages/facility_bookings_page.dart';
import '../../../phase3/waste_schedule/presentation/pages/waste_schedule_page.dart';
import '../../../phase3/hazard_reporting/presentation/pages/hazard_reporting_page.dart';

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
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommunityEventsPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            
            // Community Events Section
            Text(
              'Community Events',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            ServiceCard(
              title: 'Community Events',
              description: 'Join local events, festivals, and community gatherings.',
              category: 'Events',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommunityEventsPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Events Calendar',
              description: 'View and RSVP to upcoming community events and activities.',
              category: 'Events',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EventsCalendarPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Local Services Section
            Text(
              'Local Services',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            ServiceCard(
              title: 'Job Board',
              description: 'Find local job opportunities and post job openings.',
              category: 'Employment',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommunityJobsPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Local Marketplace',
              description: 'Buy and sell goods and services within your community.',
              category: 'Commerce',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommunityMarketplacePage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Community Groups & Organizations
            Text(
              'Community Groups & Organizations',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            ServiceCard(
              title: 'Community Groups',
              description: 'Join discussion groups, neighborhood associations, and interest groups.',
              category: 'Groups',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommunityGroupsPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Bayanihan Board',
              description: 'Volunteer for community projects and help your neighbors.',
              category: 'Volunteering',
              estimatedTime: 'Instant',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bayanihan board coming soon')),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Public Facilities & Services
            Text(
              'Public Facilities & Services',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            ServiceCard(
              title: 'Facility Bookings',
              description: 'Reserve community halls, gyms, courts, and other public facilities.',
              category: 'Facilities',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FacilityBookingsPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Waste Schedule',
              description: 'View garbage collection schedules and waste management information.',
              category: 'Environment',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WasteSchedulePage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Hazard Reporting',
              description: 'Report road damage, flooding, and other community hazards.',
              category: 'Safety',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HazardReportingPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
