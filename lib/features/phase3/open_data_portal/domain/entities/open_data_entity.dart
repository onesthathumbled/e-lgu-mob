import 'package:equatable/equatable.dart';

/// Data categories
enum DataCategory {
  financial,
  serviceMetrics,
  population,
  infrastructure,
  environment,
  health,
  education,
  publicSafety,
  transportation,
  housing,
  business,
  other,
}

/// Data formats
enum DataFormat {
  csv,
  json,
  xml,
  pdf,
  excel,
  api,
}

/// Data license types
enum DataLicense {
  publicDomain,
  openData,
  creativeCommons,
  restricted,
  confidential,
}

/// Data update frequency
enum UpdateFrequency {
  realTime,
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
  onDemand,
  irregular,
}

/// Open data dataset entity
class OpenDataDatasetEntity extends Equatable {
  const OpenDataDatasetEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.organization,
    required this.contactEmail,
    required this.license,
    required this.updateFrequency,
    required this.lastUpdated,
    required this.createdAt,
    required this.isPublic,
    required this.downloadCount,
    required this.viewCount,
    this.tags,
    this.keywords,
    this.geographicCoverage,
    this.temporalCoverage,
    this.dataQuality,
    this.metadata,
    this.documentation,
    this.apiEndpoint,
    this.sampleData,
    this.dataDictionary,
    this.usageExamples,
    this.relatedDatasets,
    this.version,
    this.fileSize,
    this.recordCount,
    this.columns,
    this.dataTypes,
  });

  final String id;
  final String title;
  final String description;
  final DataCategory category;
  final String organization;
  final String contactEmail;
  final DataLicense license;
  final UpdateFrequency updateFrequency;
  final DateTime lastUpdated;
  final DateTime createdAt;
  final bool isPublic;
  final int downloadCount;
  final int viewCount;
  final List<String>? tags;
  final List<String>? keywords;
  final String? geographicCoverage;
  final String? temporalCoverage;
  final String? dataQuality;
  final Map<String, dynamic>? metadata;
  final String? documentation;
  final String? apiEndpoint;
  final String? sampleData;
  final Map<String, String>? dataDictionary;
  final List<String>? usageExamples;
  final List<String>? relatedDatasets;
  final String? version;
  final int? fileSize; // in bytes
  final int? recordCount;
  final List<String>? columns;
  final Map<String, String>? dataTypes;

  /// Get available formats
  List<DataFormat> get availableFormats {
    final formats = <DataFormat>[];
    if (apiEndpoint != null) formats.add(DataFormat.api);
    formats.addAll([DataFormat.csv, DataFormat.json, DataFormat.pdf]);
    return formats;
  }

  /// Check if dataset is recently updated (within last 30 days)
  bool get isRecentlyUpdated {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return lastUpdated.isAfter(thirtyDaysAgo);
  }

  /// Get popularity score based on downloads and views
  double get popularityScore {
    return (downloadCount * 2.0) + viewCount;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        organization,
        contactEmail,
        license,
        updateFrequency,
        lastUpdated,
        createdAt,
        isPublic,
        downloadCount,
        viewCount,
        tags,
        keywords,
        geographicCoverage,
        temporalCoverage,
        dataQuality,
        metadata,
        documentation,
        apiEndpoint,
        sampleData,
        dataDictionary,
        usageExamples,
        relatedDatasets,
        version,
        fileSize,
        recordCount,
        columns,
        dataTypes,
      ];
}

/// Data download request entity
class DataDownloadRequestEntity extends Equatable {
  const DataDownloadRequestEntity({
    required this.id,
    required this.datasetId,
    required this.userId,
    required this.userEmail,
    required this.requestedFormat,
    required this.requestDate,
    required this.status,
    this.downloadUrl,
    this.expiresAt,
    this.downloadedAt,
    this.fileSize,
    this.purpose,
    this.organization,
    this.contactInfo,
  });

  final String id;
  final String datasetId;
  final String userId;
  final String userEmail;
  final DataFormat requestedFormat;
  final DateTime requestDate;
  final String status; // 'pending', 'processing', 'ready', 'downloaded', 'expired', 'failed'
  final String? downloadUrl;
  final DateTime? expiresAt;
  final DateTime? downloadedAt;
  final int? fileSize;
  final String? purpose;
  final String? organization;
  final String? contactInfo;

  /// Check if download is ready
  bool get isReady {
    return status == 'ready' && downloadUrl != null;
  }

  /// Check if download has expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Check if download is still valid
  bool get isValid {
    return isReady && !isExpired;
  }

  @override
  List<Object?> get props => [
        id,
        datasetId,
        userId,
        userEmail,
        requestedFormat,
        requestDate,
        status,
        downloadUrl,
        expiresAt,
        downloadedAt,
        fileSize,
        purpose,
        organization,
        contactInfo,
      ];
}

/// Data portal statistics entity
class DataPortalStatsEntity extends Equatable {
  const DataPortalStatsEntity({
    required this.totalDatasets,
    required this.publicDatasets,
    required this.totalDownloads,
    required this.totalViews,
    required this.activeUsers,
    required this.popularDatasets,
    required this.recentDownloads,
    required this.categoryBreakdown,
    required this.monthlyTrends,
  });

  final int totalDatasets;
  final int publicDatasets;
  final int totalDownloads;
  final int totalViews;
  final int activeUsers;
  final List<OpenDataDatasetEntity> popularDatasets;
  final List<DataDownloadRequestEntity> recentDownloads;
  final Map<DataCategory, int> categoryBreakdown;
  final Map<String, int> monthlyTrends;

  /// Calculate public dataset percentage
  double get publicDatasetPercentage {
    if (totalDatasets == 0) return 0.0;
    return (publicDatasets / totalDatasets) * 100;
  }

  /// Get most popular category
  DataCategory get mostPopularCategory {
    if (categoryBreakdown.isEmpty) return DataCategory.other;
    
    var maxCount = 0;
    var popularCategory = DataCategory.other;
    
    categoryBreakdown.forEach((category, count) {
      if (count > maxCount) {
        maxCount = count;
        popularCategory = category;
      }
    });
    
    return popularCategory;
  }

  @override
  List<Object?> get props => [
        totalDatasets,
        publicDatasets,
        totalDownloads,
        totalViews,
        activeUsers,
        popularDatasets,
        recentDownloads,
        categoryBreakdown,
        monthlyTrends,
      ];
}

/// Data quality report entity
class DataQualityReportEntity extends Equatable {
  const DataQualityReportEntity({
    required this.datasetId,
    required this.reportDate,
    required this.overallScore,
    required this.completeness,
    required this.accuracy,
    required this.consistency,
    required this.timeliness,
    required this.validity,
    this.issues,
    this.recommendations,
    this.lastValidated,
  });

  final String datasetId;
  final DateTime reportDate;
  final double overallScore; // 0-100
  final double completeness; // percentage of non-null values
  final double accuracy; // percentage of accurate values
  final double consistency; // percentage of consistent values
  final double timeliness; // how up-to-date the data is
  final double validity; // percentage of valid values
  final List<String>? issues;
  final List<String>? recommendations;
  final DateTime? lastValidated;

  /// Get quality grade
  String get qualityGrade {
    if (overallScore >= 90) return 'A';
    if (overallScore >= 80) return 'B';
    if (overallScore >= 70) return 'C';
    if (overallScore >= 60) return 'D';
    return 'F';
  }

  /// Get quality status
  String get qualityStatus {
    if (overallScore >= 80) return 'excellent';
    if (overallScore >= 60) return 'good';
    if (overallScore >= 40) return 'fair';
    return 'poor';
  }

  @override
  List<Object?> get props => [
        datasetId,
        reportDate,
        overallScore,
        completeness,
        accuracy,
        consistency,
        timeliness,
        validity,
        issues,
        recommendations,
        lastValidated,
      ];
}
