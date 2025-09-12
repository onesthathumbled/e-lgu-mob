import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';

class SocialProgramsPage extends StatelessWidget {
  const SocialProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Programs'),
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
                    'Citizen Assistance & Social Programs',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Apply for financial assistance, scholarships, medical aid, and training programs.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Available Programs',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Financial Assistance',
              description: 'Apply for financial aid and emergency assistance programs.',
              category: 'Social Services',
              estimatedTime: '7-10 business days',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Financial assistance application coming soon')),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Scholarship Program',
              description: 'Apply for educational scholarships and grants.',
              category: 'Social Services',
              estimatedTime: '10-14 business days',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scholarship application coming soon')),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Medical Assistance',
              description: 'Apply for medical aid and health assistance programs.',
              category: 'Social Services',
              estimatedTime: '5-7 business days',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Medical assistance application coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
