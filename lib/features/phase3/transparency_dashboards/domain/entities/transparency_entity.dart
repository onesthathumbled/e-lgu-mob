import 'package:equatable/equatable.dart';

/// SLA (Service Level Agreement) metrics
class SlaMetricsEntity extends Equatable {
  const SlaMetricsEntity({
    required this.serviceName,
    required this.totalRequests,
    required this.completedOnTime,
    required this.completedLate,
    required this.pendingRequests,
    required this.averageProcessingTime,
    required this.targetSlaHours,
    required this.complianceRate,
    required this.period,
    this.breakdownByMonth,
    this.breakdownByType,
    this.trendData,
  });

  final String serviceName;
  final int totalRequests;
  final int completedOnTime;
  final int completedLate;
  final int pendingRequests;
  final double averageProcessingTime; // in hours
  final double targetSlaHours;
  final double complianceRate; // percentage
  final String period; // 'monthly', 'quarterly', 'yearly'
  final Map<String, SlaMetricsEntity>? breakdownByMonth;
  final Map<String, SlaMetricsEntity>? breakdownByType;
  final List<SlaTrendDataEntity>? trendData;

  /// Calculate SLA compliance rate
  double get calculatedComplianceRate {
    if (totalRequests == 0) return 0.0;
    return (completedOnTime / totalRequests) * 100;
  }

  /// Get performance status
  String get performanceStatus {
    if (complianceRate >= 95) return 'excellent';
    if (complianceRate >= 85) return 'good';
    if (complianceRate >= 70) return 'fair';
    return 'poor';
  }

  @override
  List<Object?> get props => [
        serviceName,
        totalRequests,
        completedOnTime,
        completedLate,
        pendingRequests,
        averageProcessingTime,
        targetSlaHours,
        complianceRate,
        period,
        breakdownByMonth,
        breakdownByType,
        trendData,
      ];
}

/// SLA trend data for charts
class SlaTrendDataEntity extends Equatable {
  const SlaTrendDataEntity({
    required this.date,
    required this.complianceRate,
    required this.totalRequests,
    required this.completedOnTime,
    required this.averageProcessingTime,
  });

  final DateTime date;
  final double complianceRate;
  final int totalRequests;
  final int completedOnTime;
  final double averageProcessingTime;

  @override
  List<Object?> get props => [
        date,
        complianceRate,
        totalRequests,
        completedOnTime,
        averageProcessingTime,
      ];
}

/// Collection statistics entity
class CollectionStatsEntity extends Equatable {
  const CollectionStatsEntity({
    required this.period,
    required this.totalRevenue,
    required this.taxCollection,
    required this.permitFees,
    required this.businessPermitFees,
    required this.propertyTaxCollection,
    required this.otherFees,
    required this.collectionTarget,
    required this.collectionRate,
    this.breakdownByMonth,
    this.breakdownByType,
    this.trendData,
  });

  final String period;
  final double totalRevenue;
  final double taxCollection;
  final double permitFees;
  final double businessPermitFees;
  final double propertyTaxCollection;
  final double otherFees;
  final double collectionTarget;
  final double collectionRate; // percentage
  final Map<String, CollectionStatsEntity>? breakdownByMonth;
  final Map<String, double>? breakdownByType;
  final List<CollectionTrendDataEntity>? trendData;

  /// Calculate collection rate
  double get calculatedCollectionRate {
    if (collectionTarget == 0) return 0.0;
    return (totalRevenue / collectionTarget) * 100;
  }

  /// Get collection status
  String get collectionStatus {
    if (collectionRate >= 100) return 'target_met';
    if (collectionRate >= 90) return 'near_target';
    if (collectionRate >= 75) return 'on_track';
    return 'below_target';
  }

  @override
  List<Object?> get props => [
        period,
        totalRevenue,
        taxCollection,
        permitFees,
        businessPermitFees,
        propertyTaxCollection,
        otherFees,
        collectionTarget,
        collectionRate,
        breakdownByMonth,
        breakdownByType,
        trendData,
      ];
}

/// Collection trend data for charts
class CollectionTrendDataEntity extends Equatable {
  const CollectionTrendDataEntity({
    required this.date,
    required this.revenue,
    required this.target,
    required this.collectionRate,
  });

  final DateTime date;
  final double revenue;
  final double target;
  final double collectionRate;

  @override
  List<Object?> get props => [
        date,
        revenue,
        target,
        collectionRate,
      ];
}

/// Service usage statistics entity
class ServiceUsageStatsEntity extends Equatable {
  const ServiceUsageStatsEntity({
    required this.period,
    required this.totalUsers,
    required this.activeUsers,
    required this.newUsers,
    required this.mostUsedServices,
    required this.leastUsedServices,
    required this.userEngagement,
    required this.serviceCompletionRate,
    this.breakdownByService,
    this.breakdownByUserType,
    this.trendData,
  });

  final String period;
  final int totalUsers;
  final int activeUsers;
  final int newUsers;
  final List<ServiceUsageEntity> mostUsedServices;
  final List<ServiceUsageEntity> leastUsedServices;
  final double userEngagement; // percentage
  final double serviceCompletionRate; // percentage
  final Map<String, ServiceUsageEntity>? breakdownByService;
  final Map<String, int>? breakdownByUserType;
  final List<UsageTrendDataEntity>? trendData;

  /// Calculate user engagement rate
  double get calculatedUserEngagement {
    if (totalUsers == 0) return 0.0;
    return (activeUsers / totalUsers) * 100;
  }

  @override
  List<Object?> get props => [
        period,
        totalUsers,
        activeUsers,
        newUsers,
        mostUsedServices,
        leastUsedServices,
        userEngagement,
        serviceCompletionRate,
        breakdownByService,
        breakdownByUserType,
        trendData,
      ];
}

/// Individual service usage entity
class ServiceUsageEntity extends Equatable {
  const ServiceUsageEntity({
    required this.serviceName,
    required this.totalRequests,
    required this.completedRequests,
    required this.pendingRequests,
    required this.cancelledRequests,
    required this.completionRate,
    required this.averageProcessingTime,
    required this.userSatisfaction,
  });

  final String serviceName;
  final int totalRequests;
  final int completedRequests;
  final int pendingRequests;
  final int cancelledRequests;
  final double completionRate; // percentage
  final double averageProcessingTime; // in hours
  final double userSatisfaction; // rating out of 5

  /// Calculate completion rate
  double get calculatedCompletionRate {
    if (totalRequests == 0) return 0.0;
    return (completedRequests / totalRequests) * 100;
  }

  @override
  List<Object?> get props => [
        serviceName,
        totalRequests,
        completedRequests,
        pendingRequests,
        cancelledRequests,
        completionRate,
        averageProcessingTime,
        userSatisfaction,
      ];
}

/// Usage trend data for charts
class UsageTrendDataEntity extends Equatable {
  const UsageTrendDataEntity({
    required this.date,
    required this.totalUsers,
    required this.activeUsers,
    required this.newUsers,
    required this.totalRequests,
  });

  final DateTime date;
  final int totalUsers;
  final int activeUsers;
  final int newUsers;
  final int totalRequests;

  @override
  List<Object?> get props => [
        date,
        totalUsers,
        activeUsers,
        newUsers,
        totalRequests,
      ];
}

/// Dashboard summary entity
class DashboardSummaryEntity extends Equatable {
  const DashboardSummaryEntity({
    required this.period,
    required this.slaMetrics,
    required this.collectionStats,
    required this.serviceUsageStats,
    required this.lastUpdated,
    this.keyInsights,
    this.recommendations,
  });

  final String period;
  final List<SlaMetricsEntity> slaMetrics;
  final CollectionStatsEntity collectionStats;
  final ServiceUsageStatsEntity serviceUsageStats;
  final DateTime lastUpdated;
  final List<String>? keyInsights;
  final List<String>? recommendations;

  /// Overall performance score (0-100)
  double get overallPerformanceScore {
    final slaScore = slaMetrics.isNotEmpty 
        ? slaMetrics.map((e) => e.complianceRate).reduce((a, b) => a + b) / slaMetrics.length
        : 0.0;
    
    final collectionScore = collectionStats.collectionRate;
    final usageScore = serviceUsageStats.serviceCompletionRate;
    
    return (slaScore + collectionScore + usageScore) / 3;
  }

  /// Get overall performance status
  String get overallPerformanceStatus {
    final score = overallPerformanceScore;
    if (score >= 90) return 'excellent';
    if (score >= 80) return 'good';
    if (score >= 70) return 'fair';
    return 'needs_improvement';
  }

  @override
  List<Object?> get props => [
        period,
        slaMetrics,
        collectionStats,
        serviceUsageStats,
        lastUpdated,
        keyInsights,
        recommendations,
      ];
}
