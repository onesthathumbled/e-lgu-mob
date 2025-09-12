import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/permit_entity.dart';
import 'permits_application_page.dart';

class PermitsPage extends StatelessWidget {
  const PermitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permits'),
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
                    'Health & Work Permits',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apply for health permits, work permits, and sanitation permits with online scheduling.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Available Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Health Permit',
              description: 'Apply for health permits for food establishments and health services.',
              category: 'Health',
              estimatedTime: '5-7 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PermitsApplicationPage(
                      permitType: PermitType.healthPermit,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Work Permit',
              description: 'Apply for work permits for employment and business operations.',
              category: 'Work',
              estimatedTime: '3-5 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PermitsApplicationPage(
                      permitType: PermitType.workPermit,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Sanitation Permit',
              description: 'Apply for sanitation permits for waste management and cleanliness.',
              category: 'Sanitation',
              estimatedTime: '3-5 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PermitsApplicationPage(
                      permitType: PermitType.sanitationPermit,
                    ),
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
