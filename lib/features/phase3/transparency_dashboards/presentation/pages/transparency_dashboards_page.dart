import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/transparency_entity.dart';
import '../../../shared/widgets/chart_widgets.dart';

class TransparencyDashboardsPage extends StatefulWidget {
  const TransparencyDashboardsPage({super.key});

  @override
  State<TransparencyDashboardsPage> createState() => _TransparencyDashboardsPageState();
}

class _TransparencyDashboardsPageState extends State<TransparencyDashboardsPage> {
  final DashboardSummaryEntity _dashboardData = DashboardSummaryEntity(
    period: 'January 2024',
    slaMetrics: [
      const SlaMetricsEntity(
        serviceName: 'Business Permits',
        totalRequests: 150,
        completedOnTime: 135,
        completedLate: 10,
        pendingRequests: 5,
        averageProcessingTime: 2.5,
        targetSlaHours: 24,
        complianceRate: 90.0,
        period: 'monthly',
      ),
      const SlaMetricsEntity(
        serviceName: 'Property Tax',
        totalRequests: 200,
        completedOnTime: 190,
        completedLate: 8,
        pendingRequests: 2,
        averageProcessingTime: 1.2,
        targetSlaHours: 48,
        complianceRate: 95.0,
        period: 'monthly',
      ),
      const SlaMetricsEntity(
        serviceName: 'Digital ID',
        totalRequests: 80,
        completedOnTime: 70,
        completedLate: 5,
        pendingRequests: 5,
        averageProcessingTime: 3.0,
        targetSlaHours: 72,
        complianceRate: 87.5,
        period: 'monthly',
      ),
    ],
    collectionStats: const CollectionStatsEntity(
      period: 'January 2024',
      totalRevenue: 2500000.0,
      taxCollection: 1800000.0,
      permitFees: 500000.0,
      businessPermitFees: 300000.0,
      propertyTaxCollection: 1500000.0,
      otherFees: 200000.0,
      collectionTarget: 3000000.0,
      collectionRate: 83.3,
    ),
    serviceUsageStats: const ServiceUsageStatsEntity(
      period: 'January 2024',
      totalUsers: 1250,
      activeUsers: 980,
      newUsers: 150,
      mostUsedServices: [
        ServiceUsageEntity(
          serviceName: 'Property Tax',
          totalRequests: 200,
          completedRequests: 198,
          pendingRequests: 2,
          cancelledRequests: 0,
          completionRate: 99.0,
          averageProcessingTime: 1.2,
          userSatisfaction: 4.5,
        ),
        ServiceUsageEntity(
          serviceName: 'Business Permits',
          totalRequests: 150,
          completedRequests: 145,
          pendingRequests: 5,
          cancelledRequests: 0,
          completionRate: 96.7,
          averageProcessingTime: 2.5,
          userSatisfaction: 4.2,
        ),
      ],
      leastUsedServices: [
        ServiceUsageEntity(
          serviceName: 'Digital ID',
          totalRequests: 80,
          completedRequests: 75,
          pendingRequests: 5,
          cancelledRequests: 0,
          completionRate: 93.8,
          averageProcessingTime: 3.0,
          userSatisfaction: 4.0,
        ),
      ],
      userEngagement: 78.4,
      serviceCompletionRate: 96.2,
    ),
    lastUpdated: DateTime.now(),
    keyInsights: [
      'SLA compliance improved by 5% compared to last month',
      'Property tax collection exceeded target by 15%',
      'User engagement increased by 12% with new features',
      'Digital ID service shows highest satisfaction rating',
    ],
    recommendations: [
      'Focus on reducing processing time for Digital ID applications',
      'Implement automated reminders for pending applications',
      'Consider expanding popular services based on usage patterns',
      'Investigate reasons for low usage of certain services',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transparency Dashboards'),
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
              'LGU Transparency Dashboard',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time insights into LGU service performance and public data',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Overall Performance
            _buildOverallPerformance(),
            
            const SizedBox(height: 24),
            
            // Key Metrics
            _buildKeyMetrics(),
            
            const SizedBox(height: 24),
            
            // SLA Performance
            _buildSlaPerformance(),
            
            const SizedBox(height: 24),
            
            // Collection Statistics
            _buildCollectionStats(),
            
            const SizedBox(height: 24),
            
            // Service Usage
            _buildServiceUsage(),
            
            const SizedBox(height: 24),
            
            // Insights and Recommendations
            _buildInsightsAndRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallPerformance() {
    final score = _dashboardData.overallPerformanceScore;
    final status = _dashboardData.overallPerformanceStatus;
    
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Performance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              // Performance Score
              Expanded(
                child: Column(
                  children: [
                    Text(
                      score.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getPerformanceColor(score),
                      ),
                    ),
                    Text(
                      'Performance Score',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getPerformanceColor(score).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getPerformanceColor(score),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Performance Breakdown
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPerformanceItem('SLA Compliance', _dashboardData.slaMetrics.isNotEmpty 
                        ? _dashboardData.slaMetrics.map((e) => e.complianceRate).reduce((a, b) => a + b) / _dashboardData.slaMetrics.length
                        : 0.0),
                    _buildPerformanceItem('Collection Rate', _dashboardData.collectionStats.collectionRate),
                    _buildPerformanceItem('Service Completion', _dashboardData.serviceUsageStats.serviceCompletionRate),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            '${value.toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: _getPerformanceColor(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
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
            ShadMetricCard(
              title: 'Total Users',
              value: _dashboardData.serviceUsageStats.totalUsers.toString(),
              subtitle: '${_dashboardData.serviceUsageStats.activeUsers} active',
              icon: Icons.people,
              color: Colors.blue,
              trend: 'up',
              trendValue: '+${_dashboardData.serviceUsageStats.newUsers}',
            ),
            ShadMetricCard(
              title: 'Total Revenue',
              value: '₱${(_dashboardData.collectionStats.totalRevenue / 1000000).toStringAsFixed(1)}M',
              subtitle: '${_dashboardData.collectionStats.collectionRate.toStringAsFixed(1)}% of target',
              icon: Icons.attach_money,
              color: Colors.green,
              trend: 'up',
              trendValue: '+15%',
            ),
            ShadMetricCard(
              title: 'SLA Compliance',
              value: '${_dashboardData.slaMetrics.isNotEmpty 
                  ? (_dashboardData.slaMetrics.map((e) => e.complianceRate).reduce((a, b) => a + b) / _dashboardData.slaMetrics.length).toStringAsFixed(1)
                  : '0.0'}%',
              subtitle: 'Average across all services',
              icon: Icons.schedule,
              color: Colors.orange,
              trend: 'up',
              trendValue: '+5%',
            ),
            ShadMetricCard(
              title: 'User Engagement',
              value: '${_dashboardData.serviceUsageStats.userEngagement.toStringAsFixed(1)}%',
              subtitle: 'Active users this month',
              icon: Icons.trending_up,
              color: Colors.purple,
              trend: 'up',
              trendValue: '+12%',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSlaPerformance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SLA Performance',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        // SLA Chart
        ShadBarChart(
          title: 'SLA Compliance by Service',
          data: _dashboardData.slaMetrics.map((e) => e.complianceRate).toList(),
          labels: _dashboardData.slaMetrics.map((e) => e.serviceName).toList(),
          colors: [Colors.blue, Colors.green, Colors.orange],
        ),
        
        const SizedBox(height: 16),
        
        // SLA Details
        ..._dashboardData.slaMetrics.map((sla) => _buildSlaCard(sla)),
      ],
    );
  }

  Widget _buildSlaCard(SlaMetricsEntity sla) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ShadCard(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  sla.serviceName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPerformanceColor(sla.complianceRate).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${sla.complianceRate.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getPerformanceColor(sla.complianceRate),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildSlaDetail('Total Requests', sla.totalRequests.toString()),
              ),
              Expanded(
                child: _buildSlaDetail('On Time', sla.completedOnTime.toString()),
              ),
              Expanded(
                child: _buildSlaDetail('Late', sla.completedLate.toString()),
              ),
              Expanded(
                child: _buildSlaDetail('Pending', sla.pendingRequests.toString()),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Average Processing Time: ${sla.averageProcessingTime.toStringAsFixed(1)} hours',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildSlaDetail(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collection Statistics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        // Collection Chart
        ShadPieChart(
          title: 'Revenue Breakdown',
          data: [
            _dashboardData.collectionStats.propertyTaxCollection,
            _dashboardData.collectionStats.businessPermitFees,
            _dashboardData.collectionStats.otherFees,
          ],
          labels: [
            'Property Tax',
            'Business Permits',
            'Other Fees',
          ],
          colors: [Colors.blue, Colors.green, Colors.orange],
        ),
        
        const SizedBox(height: 16),
        
        // Collection Details
        ShadCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Revenue',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '₱${(_dashboardData.collectionStats.totalRevenue / 1000000).toStringAsFixed(1)}M',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildCollectionDetail('Target', '₱${(_dashboardData.collectionStats.collectionTarget / 1000000).toStringAsFixed(1)}M'),
                  ),
                  Expanded(
                    child: _buildCollectionDetail('Collection Rate', '${_dashboardData.collectionStats.collectionRate.toStringAsFixed(1)}%'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceUsage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Usage',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        // Most Used Services
        ShadCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Most Used Services',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              ..._dashboardData.serviceUsageStats.mostUsedServices.map((service) => _buildServiceItem(service)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem(ServiceUsageEntity service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.serviceName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${service.totalRequests} requests • ${service.completionRate.toStringAsFixed(1)}% completion',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${service.userSatisfaction.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Text(
                'rating',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsAndRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights & Recommendations',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        // Key Insights
        ShadCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Insights',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              
              ..._dashboardData.keyInsights!.map((insight) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        insight,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Recommendations
        ShadCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommendations',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              
              ..._dashboardData.recommendations!.map((recommendation) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.recommend,
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        recommendation,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPerformanceColor(double value) {
    if (value >= 90) return Colors.green;
    if (value >= 80) return Colors.blue;
    if (value >= 70) return Colors.orange;
    return Colors.red;
  }
}
