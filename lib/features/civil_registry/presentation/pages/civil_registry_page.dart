import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/civil_registry_entity.dart';
import 'civil_registry_request_page.dart';

class CivilRegistryPage extends StatelessWidget {
  const CivilRegistryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civil Registry'),
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
                    'Civil Registry Documents',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Request birth, marriage, and death certificates with online payment and delivery options.',
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
              title: 'Birth Certificate',
              description: 'Request a certified copy of your birth certificate.',
              category: 'Civil Registry',
              estimatedTime: '3-5 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CivilRegistryRequestPage(
                      documentType: CivilRegistryDocumentType.birthCertificate,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Marriage Certificate',
              description: 'Request a certified copy of your marriage certificate.',
              category: 'Civil Registry',
              estimatedTime: '3-5 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CivilRegistryRequestPage(
                      documentType: CivilRegistryDocumentType.marriageCertificate,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ServiceCard(
              title: 'Death Certificate',
              description: 'Request a certified copy of a death certificate.',
              category: 'Civil Registry',
              estimatedTime: '3-5 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CivilRegistryRequestPage(
                      documentType: CivilRegistryDocumentType.deathCertificate,
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
