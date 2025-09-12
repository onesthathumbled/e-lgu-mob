import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import 'property_tax_payment_page.dart';

/// Property Tax page
class PropertyTaxPage extends StatelessWidget {
  const PropertyTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Tax'),
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
                    'Real Property Tax (RPT) Payments',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pay your real property taxes online, view payment history, and receive digital receipts.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Property lookup section
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property Lookup',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ShadInput(
                    label: 'Tax Declaration Number (TD No.)',
                    placeholder: 'Enter TD number',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  const SizedBox(height: 16),
                  ShadInput(
                    label: 'Property Identification Number (PIN)',
                    placeholder: 'Enter PIN',
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  const SizedBox(height: 16),
                  ShadButton(
                    text: 'Search Property',
                    onPressed: () {
                      // TODO: Implement property search
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Property search coming soon'),
                        ),
                      );
                    },
                    fullWidth: true,
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
              title: 'Pay Real Property Tax',
              description: 'Pay your annual real property tax online with various payment methods.',
              category: 'Property',
              estimatedTime: 'Instant',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PropertyTaxPaymentPage(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'View Payment History',
              description: 'Check your past property tax payments and download receipts.',
              category: 'Property',
              estimatedTime: 'Instant',
              onTap: () {
                // TODO: Navigate to payment history
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment history coming soon'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Request Tax Certificate',
              description: 'Request a certificate of tax payment for your property.',
              category: 'Property',
              estimatedTime: '1-2 business days',
              onTap: () {
                // TODO: Navigate to certificate request
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tax certificate request coming soon'),
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
                    text: 'Payment Calculator',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      // TODO: Navigate to calculator
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tax calculator coming soon'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calculate),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ShadButton(
                    text: 'Download Receipt',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      // TODO: Navigate to receipt download
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Receipt download coming soon'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
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
