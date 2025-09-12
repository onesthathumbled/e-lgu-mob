import 'package:flutter/material.dart';
import '../../../../shared/widgets/shadcn_components.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/community_entity.dart';

/// Community marketplace page
class CommunityMarketplacePage extends StatelessWidget {
  const CommunityMarketplacePage({super.key});

  // Mock data for marketplace items
  List<MarketplaceItemEntity> get _items => [
    MarketplaceItemEntity(
      id: 'item_001',
      title: 'Samsung Galaxy S21 - Excellent Condition',
      description: 'Samsung Galaxy S21 in excellent condition. No scratches, all accessories included. Selling due to upgrade.',
      price: 25000.0,
      category: MarketplaceCategory.electronics,
      sellerName: 'Juan Dela Cruz',
      sellerContact: '+63 912 345 6789',
      location: 'Barangay 1, Sample City',
      status: MarketplaceStatus.active,
      postedAt: DateTime.now().subtract(const Duration(days: 1)),
      condition: ItemCondition.likeNew,
      negotiable: true,
      deliveryAvailable: true,
      deliveryFee: 100.0,
    ),
    MarketplaceItemEntity(
      id: 'item_002',
      title: 'Wooden Dining Table Set',
      description: 'Beautiful wooden dining table with 4 chairs. Perfect for small families. Good condition, minor wear.',
      price: 8000.0,
      category: MarketplaceCategory.furniture,
      sellerName: 'Maria Santos',
      sellerContact: '+63 912 345 6790',
      location: 'Barangay 2, Sample City',
      status: MarketplaceStatus.active,
      postedAt: DateTime.now().subtract(const Duration(days: 3)),
      condition: ItemCondition.good,
      negotiable: true,
      deliveryAvailable: false,
    ),
    MarketplaceItemEntity(
      id: 'item_003',
      title: 'Fresh Vegetables - Homegrown',
      description: 'Fresh vegetables from our backyard garden. Organic, no pesticides. Available: tomatoes, eggplants, okra.',
      price: 150.0,
      category: MarketplaceCategory.food,
      sellerName: 'Pedro Garcia',
      sellerContact: '+63 912 345 6791',
      location: 'Barangay 3, Sample City',
      status: MarketplaceStatus.active,
      postedAt: DateTime.now().subtract(const Duration(hours: 6)),
      condition: ItemCondition.new_,
      negotiable: false,
      deliveryAvailable: true,
      deliveryFee: 50.0,
    ),
    MarketplaceItemEntity(
      id: 'item_004',
      title: 'Motorcycle Honda Wave 110',
      description: 'Honda Wave 110, 2019 model. Well-maintained, complete papers, low mileage. Perfect for daily commute.',
      price: 45000.0,
      category: MarketplaceCategory.vehicles,
      sellerName: 'Ana Cruz',
      sellerContact: '+63 912 345 6792',
      location: 'Barangay 4, Sample City',
      status: MarketplaceStatus.active,
      postedAt: DateTime.now().subtract(const Duration(days: 2)),
      condition: ItemCondition.good,
      negotiable: true,
      deliveryAvailable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Palengke'),
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
                    'E-Palengke (Marketplace)',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Buy and sell goods and services within your community. Support local businesses and find great deals from your neighbors.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Featured Items',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _MarketplaceItemCard(item: item),
            )),
          ],
        ),
      ),
    );
  }
}

class _MarketplaceItemCard extends StatelessWidget {
  const _MarketplaceItemCard({required this.item});

  final MarketplaceItemEntity item;

  String _getCategoryName() {
    switch (item.category) {
      case MarketplaceCategory.electronics:
        return 'Electronics';
      case MarketplaceCategory.clothing:
        return 'Clothing';
      case MarketplaceCategory.furniture:
        return 'Furniture';
      case MarketplaceCategory.vehicles:
        return 'Vehicles';
      case MarketplaceCategory.books:
        return 'Books';
      case MarketplaceCategory.food:
        return 'Food';
      case MarketplaceCategory.services:
        return 'Services';
      case MarketplaceCategory.realEstate:
        return 'Real Estate';
      case MarketplaceCategory.other:
        return 'Other';
    }
  }

  Color _getCategoryColor() {
    switch (item.category) {
      case MarketplaceCategory.electronics:
        return Colors.blue;
      case MarketplaceCategory.clothing:
        return Colors.pink;
      case MarketplaceCategory.furniture:
        return Colors.brown;
      case MarketplaceCategory.vehicles:
        return Colors.grey;
      case MarketplaceCategory.books:
        return Colors.green;
      case MarketplaceCategory.food:
        return Colors.orange;
      case MarketplaceCategory.services:
        return Colors.purple;
      case MarketplaceCategory.realEstate:
        return Colors.indigo;
      case MarketplaceCategory.other:
        return Colors.grey;
    }
  }

  String _getConditionName() {
    switch (item.condition) {
      case ItemCondition.new_:
        return 'New';
      case ItemCondition.likeNew:
        return 'Like New';
      case ItemCondition.good:
        return 'Good';
      case ItemCondition.fair:
        return 'Fair';
      case ItemCondition.poor:
        return 'Poor';
      case null:
        return 'Not Specified';
    }
  }

  Color _getConditionColor() {
    switch (item.condition) {
      case ItemCondition.new_:
        return Colors.green;
      case ItemCondition.likeNew:
        return Colors.blue;
      case ItemCondition.good:
        return Colors.orange;
      case ItemCondition.fair:
        return Colors.amber;
      case ItemCondition.poor:
        return Colors.red;
      case null:
        return Colors.grey;
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with category and condition badges
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getCategoryName(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getCategoryColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getConditionColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getConditionName(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getConditionColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                if (item.negotiable)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Negotiable',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Item title
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Item description
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Price
            Text(
              '₱${item.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Item details
            _MarketplaceDetailRow(
              icon: Icons.person,
              label: 'Seller',
              value: item.sellerName,
            ),
            _MarketplaceDetailRow(
              icon: Icons.location_on,
              label: 'Location',
              value: item.location,
            ),
            _MarketplaceDetailRow(
              icon: Icons.schedule,
              label: 'Posted',
              value: '${item.postedAt.day}/${item.postedAt.month}/${item.postedAt.year}',
            ),
            if (item.deliveryAvailable)
              _MarketplaceDetailRow(
                icon: Icons.local_shipping,
                label: 'Delivery',
                value: item.deliveryFee != null 
                    ? 'Available (₱${item.deliveryFee!.toStringAsFixed(2)})'
                    : 'Available',
              ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'View Details',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      _showItemDetails(context, item);
                    },
                    icon: const Icon(Icons.info_outline),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'Contact Seller',
                    onPressed: () {
                      _showContactDialog(context, item);
                    },
                    icon: const Icon(Icons.message),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context, MarketplaceItemEntity item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₱${item.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              _DetailRow(
                label: 'Category',
                value: _getCategoryName(),
              ),
              _DetailRow(
                label: 'Condition',
                value: _getConditionName(),
              ),
              _DetailRow(
                label: 'Seller',
                value: item.sellerName,
              ),
              _DetailRow(
                label: 'Location',
                value: item.location,
              ),
              _DetailRow(
                label: 'Posted',
                value: '${item.postedAt.day}/${item.postedAt.month}/${item.postedAt.year}',
              ),
              if (item.negotiable)
                _DetailRow(
                  label: 'Price',
                  value: 'Negotiable',
                ),
              if (item.deliveryAvailable)
                _DetailRow(
                  label: 'Delivery',
                  value: item.deliveryFee != null 
                      ? 'Available (₱${item.deliveryFee!.toStringAsFixed(2)})'
                      : 'Available',
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showContactDialog(context, item);
            },
            child: const Text('Contact Seller'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context, MarketplaceItemEntity item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact ${item.sellerName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item: ${item.title}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: ₱${item.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Contact Information:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 8),
                Text(
                  item.sellerContact,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Note: This is a mock contact system. In a real app, this would integrate with messaging or calling functionality.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
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
                const SnackBar(content: Text('Contact information copied to clipboard!')),
              );
            },
            child: const Text('Copy Contact'),
          ),
        ],
      ),
    );
  }
}

class _MarketplaceDetailRow extends StatelessWidget {
  const _MarketplaceDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
