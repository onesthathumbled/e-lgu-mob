import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import 'new_business_permit_page.dart';
import '../../../property_tax/presentation/pages/property_tax_page.dart';
import '../../../digital_id/presentation/pages/digital_id_page.dart';
import '../../../civil_registry/presentation/pages/civil_registry_page.dart';
import '../../../permits/presentation/pages/permits_page.dart';
import '../../../social_programs/presentation/pages/social_programs_page.dart';
import '../../../phase2/obos/presentation/pages/obos_application_page.dart';

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
                    'Government Services Hub',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Access all local government services in one place. From business permits to community services, everything you need is here.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Business & Licensing Services
            Text(
              'Business & Licensing Services',
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NewBusinessPermitPage(),
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
            
            // Property & Tax Services
            Text(
              'Property & Tax Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Property Tax Payment',
              description: 'Pay your Real Property Tax (RPT) online with various payment options.',
              category: 'Tax',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PropertyTaxPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Property Tax Certificate',
              description: 'Request for property tax clearance and certificates.',
              category: 'Tax',
              estimatedTime: '3-5 business days',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Property tax certificate request coming soon'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Identification & Civil Registry
            Text(
              'Identification & Civil Registry',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Digital ID Application',
              description: 'Apply for your official LGU digital identification card.',
              category: 'ID',
              estimatedTime: '7-10 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DigitalIdPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Civil Registry Services',
              description: 'Birth, marriage, and death certificate requests.',
              category: 'Civil Registry',
              estimatedTime: '5-7 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CivilRegistryPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Health & Safety Permits
            Text(
              'Health & Safety Permits',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Health Permits',
              description: 'Sanitary permits, health certificates, and food establishment permits.',
              category: 'Health',
              estimatedTime: '3-5 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PermitsPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Building Permits (OBOS)',
              description: 'Building permits, occupancy permits, and zoning clearances.',
              category: 'Building',
              estimatedTime: '10-15 business days',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ObosApplicationPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Social Services
            Text(
              'Social Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Social Programs',
              description: 'Financial assistance, livelihood programs, and social services.',
              category: 'Social',
              estimatedTime: 'Varies',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SocialProgramsPage(),
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
