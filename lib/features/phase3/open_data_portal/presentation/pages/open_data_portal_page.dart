import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/open_data_entity.dart';

class OpenDataPortalPage extends StatefulWidget {
  const OpenDataPortalPage({super.key});

  @override
  State<OpenDataPortalPage> createState() => _OpenDataPortalPageState();
}

class _OpenDataPortalPageState extends State<OpenDataPortalPage> {
  final List<OpenDataDatasetEntity> _datasets = [
    OpenDataDatasetEntity(
      id: '1',
      title: 'Business Permits Data',
      description: 'Monthly data on business permit applications, approvals, and processing times',
      category: DataCategory.business,
      organization: 'Business Permits and Licensing Office',
      contactEmail: 'bplo@lgu.gov.ph',
      license: DataLicense.openData,
      updateFrequency: UpdateFrequency.monthly,
      lastUpdated: DateTime(2024, 1, 15),
      createdAt: DateTime(2024, 1, 1),
      isPublic: true,
      downloadCount: 245,
      viewCount: 1200,
      tags: ['business', 'permits', 'licensing'],
      keywords: ['business permits', 'licensing', 'applications'],
      geographicCoverage: 'Entire Municipality',
      temporalCoverage: '2020-2024',
      dataQuality: 'High',
      recordCount: 1500,
      columns: ['application_id', 'business_name', 'application_date', 'status', 'processing_time'],
      dataTypes: {
        'application_id': 'string',
        'business_name': 'string',
        'application_date': 'date',
        'status': 'string',
        'processing_time': 'number',
      },
    ),
    OpenDataDatasetEntity(
      id: '2',
      title: 'Property Tax Collection',
      description: 'Annual property tax collection data by barangay and property type',
      category: DataCategory.financial,
      organization: 'Treasurer\'s Office',
      contactEmail: 'treasurer@lgu.gov.ph',
      license: DataLicense.openData,
      updateFrequency: UpdateFrequency.yearly,
      lastUpdated: DateTime(2024, 1, 10),
      createdAt: DateTime(2023, 1, 1),
      isPublic: true,
      downloadCount: 180,
      viewCount: 850,
      tags: ['tax', 'property', 'revenue'],
      keywords: ['property tax', 'collection', 'revenue'],
      geographicCoverage: 'All Barangays',
      temporalCoverage: '2019-2023',
      dataQuality: 'High',
      recordCount: 5000,
      columns: ['property_id', 'barangay', 'property_type', 'assessed_value', 'tax_collected'],
      dataTypes: {
        'property_id': 'string',
        'barangay': 'string',
        'property_type': 'string',
        'assessed_value': 'number',
        'tax_collected': 'number',
      },
    ),
    OpenDataDatasetEntity(
      id: '3',
      title: 'Population Demographics',
      description: 'Population data by age group, gender, and barangay',
      category: DataCategory.population,
      organization: 'Planning and Development Office',
      contactEmail: 'planning@lgu.gov.ph',
      license: DataLicense.openData,
      updateFrequency: UpdateFrequency.yearly,
      lastUpdated: DateTime(2023, 12, 31),
      createdAt: DateTime(2023, 1, 1),
      isPublic: true,
      downloadCount: 320,
      viewCount: 1500,
      tags: ['population', 'demographics', 'census'],
      keywords: ['population', 'demographics', 'age', 'gender'],
      geographicCoverage: 'All Barangays',
      temporalCoverage: '2020-2023',
      dataQuality: 'High',
      recordCount: 25000,
      columns: ['barangay', 'age_group', 'gender', 'population_count'],
      dataTypes: {
        'barangay': 'string',
        'age_group': 'string',
        'gender': 'string',
        'population_count': 'number',
      },
    ),
    OpenDataDatasetEntity(
      id: '4',
      title: 'Service Usage Statistics',
      description: 'Monthly statistics on LGU service usage and user engagement',
      category: DataCategory.serviceMetrics,
      organization: 'Information Technology Office',
      contactEmail: 'ito@lgu.gov.ph',
      license: DataLicense.openData,
      updateFrequency: UpdateFrequency.monthly,
      lastUpdated: DateTime(2024, 1, 20),
      createdAt: DateTime(2024, 1, 1),
      isPublic: true,
      downloadCount: 95,
      viewCount: 450,
      tags: ['services', 'usage', 'statistics'],
      keywords: ['service usage', 'user engagement', 'statistics'],
      geographicCoverage: 'Entire Municipality',
      temporalCoverage: '2023-2024',
      dataQuality: 'Medium',
      recordCount: 1200,
      columns: ['service_name', 'month', 'total_users', 'active_users', 'completion_rate'],
      dataTypes: {
        'service_name': 'string',
        'month': 'date',
        'total_users': 'number',
        'active_users': 'number',
        'completion_rate': 'number',
      },
    ),
  ];

  final DataPortalStatsEntity _portalStats = const DataPortalStatsEntity(
    totalDatasets: 4,
    publicDatasets: 4,
    totalDownloads: 840,
    totalViews: 4000,
    activeUsers: 150,
    popularDatasets: [],
    recentDownloads: [],
    categoryBreakdown: {
      DataCategory.business: 1,
      DataCategory.financial: 1,
      DataCategory.population: 1,
      DataCategory.serviceMetrics: 1,
    },
    monthlyTrends: {
      'January 2024': 120,
      'December 2023': 95,
      'November 2023': 110,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Data Portal'),
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
            Text(
              'Open Data Portal',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Access public datasets and government information for transparency and research',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Portal Statistics
            _buildPortalStats(),
            
            const SizedBox(height: 24),
            
            // Search and Filter
            _buildSearchAndFilter(),
            
            const SizedBox(height: 24),
            
            // Datasets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Datasets',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${_datasets.length} datasets',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Datasets List
            ..._datasets.map((dataset) => _buildDatasetCard(dataset)),
          ],
        ),
      ),
    );
  }

  Widget _buildPortalStats() {
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portal Statistics',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildMetricCard(
                'Total Datasets',
                _portalStats.totalDatasets.toString(),
                '${_portalStats.publicDatasets} public',
                Icons.dataset,
                Colors.blue,
              ),
              _buildMetricCard(
                'Total Downloads',
                _portalStats.totalDownloads.toString(),
                'This month',
                Icons.download,
                Colors.green,
              ),
              _buildMetricCard(
                'Total Views',
                _portalStats.totalViews.toString(),
                'All time',
                Icons.visibility,
                Colors.orange,
              ),
              _buildMetricCard(
                'Active Users',
                _portalStats.activeUsers.toString(),
                'This month',
                Icons.people,
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search & Filter',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Search Bar
          ShadInput(
            placeholder: 'Search datasets...',
            prefixIcon: const Icon(Icons.search),
          ),
          
          const SizedBox(height: 16),
          
          // Category Filter
          Text(
            'Categories',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: DataCategory.values.map((category) => FilterChip(
              label: Text(_getCategoryName(category)),
              selected: false,
              onSelected: (selected) {
                // Handle category filter
              },
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDatasetCard(OpenDataDatasetEntity dataset) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ShadCard(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dataset Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getCategoryColor(dataset.category).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getCategoryIcon(dataset.category),
                  color: _getCategoryColor(dataset.category),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataset.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      dataset.organization,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (dataset.isRecentlyUpdated)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'UPDATED',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Description
          Text(
            dataset.description,
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          // Dataset Details
          Row(
            children: [
              Expanded(
                child: _buildDatasetDetail('Records', dataset.recordCount?.toString() ?? 'N/A'),
              ),
              Expanded(
                child: _buildDatasetDetail('Updated', '${dataset.lastUpdated.day}/${dataset.lastUpdated.month}/${dataset.lastUpdated.year}'),
              ),
              Expanded(
                child: _buildDatasetDetail('Downloads', dataset.downloadCount.toString()),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Tags
          if (dataset.tags != null && dataset.tags!.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: dataset.tags!.map((tag) => Chip(
                label: Text(tag),
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                labelStyle: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
          ],
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ShadButton(
                  text: 'View Details',
                  variant: ShadButtonVariant.outline,
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    _showDatasetDetails(dataset);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShadButton(
                  text: 'Download',
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    _downloadDataset(dataset);
                  },
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color color) {
    return ShadCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: 8),
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDatasetDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(DataCategory category) {
    switch (category) {
      case DataCategory.financial:
        return Icons.attach_money;
      case DataCategory.serviceMetrics:
        return Icons.analytics;
      case DataCategory.population:
        return Icons.people;
      case DataCategory.infrastructure:
        return Icons.construction;
      case DataCategory.environment:
        return Icons.eco;
      case DataCategory.health:
        return Icons.health_and_safety;
      case DataCategory.education:
        return Icons.school;
      case DataCategory.publicSafety:
        return Icons.security;
      case DataCategory.transportation:
        return Icons.directions_car;
      case DataCategory.housing:
        return Icons.home;
      case DataCategory.business:
        return Icons.business;
      case DataCategory.other:
        return Icons.folder;
    }
  }

  Color _getCategoryColor(DataCategory category) {
    switch (category) {
      case DataCategory.financial:
        return Colors.green;
      case DataCategory.serviceMetrics:
        return Colors.blue;
      case DataCategory.population:
        return Colors.purple;
      case DataCategory.infrastructure:
        return Colors.orange;
      case DataCategory.environment:
        return Colors.teal;
      case DataCategory.health:
        return Colors.red;
      case DataCategory.education:
        return Colors.indigo;
      case DataCategory.publicSafety:
        return Colors.amber;
      case DataCategory.transportation:
        return Colors.cyan;
      case DataCategory.housing:
        return Colors.brown;
      case DataCategory.business:
        return Colors.pink;
      case DataCategory.other:
        return Colors.grey;
    }
  }

  String _getCategoryName(DataCategory category) {
    switch (category) {
      case DataCategory.financial:
        return 'Financial';
      case DataCategory.serviceMetrics:
        return 'Service Metrics';
      case DataCategory.population:
        return 'Population';
      case DataCategory.infrastructure:
        return 'Infrastructure';
      case DataCategory.environment:
        return 'Environment';
      case DataCategory.health:
        return 'Health';
      case DataCategory.education:
        return 'Education';
      case DataCategory.publicSafety:
        return 'Public Safety';
      case DataCategory.transportation:
        return 'Transportation';
      case DataCategory.housing:
        return 'Housing';
      case DataCategory.business:
        return 'Business';
      case DataCategory.other:
        return 'Other';
    }
  }

  void _showDatasetDetails(OpenDataDatasetEntity dataset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Dataset Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(dataset.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getCategoryIcon(dataset.category),
                      size: 32,
                      color: _getCategoryColor(dataset.category),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataset.title,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          dataset.organization,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Details
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dataset.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildDetailRow('Category', _getCategoryName(dataset.category)),
                      _buildDetailRow('License', dataset.license.name),
                      _buildDetailRow('Update Frequency', dataset.updateFrequency.name),
                      _buildDetailRow('Last Updated', '${dataset.lastUpdated.day}/${dataset.lastUpdated.month}/${dataset.lastUpdated.year}'),
                      _buildDetailRow('Geographic Coverage', dataset.geographicCoverage ?? 'N/A'),
                      _buildDetailRow('Temporal Coverage', dataset.temporalCoverage ?? 'N/A'),
                      _buildDetailRow('Data Quality', dataset.dataQuality ?? 'N/A'),
                      _buildDetailRow('Record Count', dataset.recordCount?.toString() ?? 'N/A'),
                      _buildDetailRow('Downloads', dataset.downloadCount.toString()),
                      _buildDetailRow('Views', dataset.viewCount.toString()),
                      
                      if (dataset.columns != null && dataset.columns!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Data Columns',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...dataset.columns!.map((column) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Text(
                                '• ',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Expanded(
                                child: Text(
                                  column,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              if (dataset.dataTypes != null && dataset.dataTypes![column] != null)
                                Text(
                                  '(${dataset.dataTypes![column]})',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                            ],
                          ),
                        )),
                      ],
                      
                      if (dataset.tags != null && dataset.tags!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Tags',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: dataset.tags!.map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                            ),
                          )).toList(),
                        ),
                      ],
                      
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ShadButton(
                              text: 'Download CSV',
                              onPressed: () {
                                Navigator.pop(context);
                                _downloadDataset(dataset, DataFormat.csv);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ShadButton(
                              text: 'Download JSON',
                              variant: ShadButtonVariant.outline,
                              onPressed: () {
                                Navigator.pop(context);
                                _downloadDataset(dataset, DataFormat.json);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadDataset(OpenDataDatasetEntity dataset, [DataFormat? format]) {
    final selectedFormat = format ?? DataFormat.csv;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Dataset'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dataset: ${dataset.title}'),
            Text('Format: ${selectedFormat.name.toUpperCase()}'),
            Text('Records: ${dataset.recordCount ?? 'N/A'}'),
            const SizedBox(height: 16),
            const Text('Download will start shortly...'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading ${dataset.title} in ${selectedFormat.name.toUpperCase()} format'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }
}
