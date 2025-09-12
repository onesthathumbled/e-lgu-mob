import 'package:equatable/equatable.dart';

/// User points entity
class UserPointsEntity extends Equatable {
  const UserPointsEntity({
    required this.userId,
    required this.totalPoints,
    required this.availablePoints,
    required this.level,
    required this.experience,
    required this.nextLevelExperience,
    required this.rank,
    required this.badges,
    required this.achievements,
    this.lastUpdated,
  });

  final String userId;
  final int totalPoints;
  final int availablePoints;
  final int level;
  final int experience;
  final int nextLevelExperience;
  final int rank;
  final List<BadgeEntity> badges;
  final List<AchievementEntity> achievements;
  final DateTime? lastUpdated;

  /// Experience progress percentage
  double get experienceProgress {
    if (nextLevelExperience == 0) return 1.0;
    return experience / nextLevelExperience;
  }

  /// Points needed for next level
  int get pointsToNextLevel => nextLevelExperience - experience;

  /// Is user at max level
  bool get isMaxLevel => nextLevelExperience == 0;

  /// User level title
  String get levelTitle {
    if (level <= 5) return 'Citizen';
    if (level <= 10) return 'Active Citizen';
    if (level <= 15) return 'Community Leader';
    if (level <= 20) return 'City Champion';
    return 'LGU Hero';
  }

  @override
  List<Object?> get props => [
        userId,
        totalPoints,
        availablePoints,
        level,
        experience,
        nextLevelExperience,
        rank,
        badges,
        achievements,
        lastUpdated,
      ];

  @override
  String toString() {
    return 'UserPointsEntity(userId: $userId, level: $level, totalPoints: $totalPoints)';
  }
}

/// Badge entity
class BadgeEntity extends Equatable {
  const BadgeEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.rarity,
    required this.pointsRequired,
    required this.isEarned,
    this.earnedDate,
    this.progress,
  });

  final String id;
  final String name;
  final String description;
  final String icon;
  final BadgeCategory category;
  final BadgeRarity rarity;
  final int pointsRequired;
  final bool isEarned;
  final DateTime? earnedDate;
  final double? progress;

  /// Is badge in progress
  bool get isInProgress => progress != null && progress! > 0 && !isEarned;

  /// Progress percentage
  double get progressPercentage => progress ?? 0.0;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        icon,
        category,
        rarity,
        pointsRequired,
        isEarned,
        earnedDate,
        progress,
      ];

  @override
  String toString() {
    return 'BadgeEntity(id: $id, name: $name, isEarned: $isEarned)';
  }
}

/// Achievement entity
class AchievementEntity extends Equatable {
  const AchievementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.pointsReward,
    required this.isCompleted,
    required this.requirements,
    this.completedDate,
    this.progress,
  });

  final String id;
  final String title;
  final String description;
  final AchievementCategory category;
  final int pointsReward;
  final bool isCompleted;
  final List<String> requirements;
  final DateTime? completedDate;
  final Map<String, int>? progress;

  /// Is achievement in progress
  bool get isInProgress => progress != null && !isCompleted;

  /// Overall progress percentage
  double get overallProgress {
    if (isCompleted) return 1.0;
    if (progress == null) return 0.0;
    
    int totalProgress = 0;
    int totalRequired = 0;
    
    for (final requirement in requirements) {
      final required = _getRequirementValue(requirement);
      final current = progress![requirement] ?? 0;
      totalRequired += required;
      totalProgress += current;
    }
    
    if (totalRequired == 0) return 0.0;
    return (totalProgress / totalRequired).clamp(0.0, 1.0);
  }

  int _getRequirementValue(String requirement) {
    // Mock requirement values - in real app, this would come from configuration
    switch (requirement) {
      case 'complete_applications':
        return 10;
      case 'report_issues':
        return 5;
      case 'participate_community':
        return 20;
      case 'refer_friends':
        return 3;
      default:
        return 1;
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        pointsReward,
        isCompleted,
        requirements,
        completedDate,
        progress,
      ];

  @override
  String toString() {
    return 'AchievementEntity(id: $id, title: $title, isCompleted: $isCompleted)';
  }
}

/// Reward entity
class RewardEntity extends Equatable {
  const RewardEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsCost,
    required this.category,
    required this.isAvailable,
    required this.quantity,
    this.image,
    this.validUntil,
    this.terms,
    this.redemptionCount,
  });

  final String id;
  final String name;
  final String description;
  final int pointsCost;
  final RewardCategory category;
  final bool isAvailable;
  final int quantity;
  final String? image;
  final DateTime? validUntil;
  final String? terms;
  final int? redemptionCount;

  /// Is reward expired
  bool get isExpired {
    if (validUntil == null) return false;
    return DateTime.now().isAfter(validUntil!);
  }

  /// Is reward out of stock
  bool get isOutOfStock => quantity <= 0;

  /// Can be redeemed
  bool get canBeRedeemed => isAvailable && !isExpired && !isOutOfStock;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pointsCost,
        category,
        isAvailable,
        quantity,
        image,
        validUntil,
        terms,
        redemptionCount,
      ];

  @override
  String toString() {
    return 'RewardEntity(id: $id, name: $name, pointsCost: $pointsCost)';
  }
}

/// Leaderboard entry entity
class LeaderboardEntryEntity extends Equatable {
  const LeaderboardEntryEntity({
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.totalPoints,
    required this.level,
    required this.rank,
    required this.badgesCount,
    required this.achievementsCount,
    this.thisMonthPoints,
    this.thisWeekPoints,
  });

  final String userId;
  final String userName;
  final String? userAvatar;
  final int totalPoints;
  final int level;
  final int rank;
  final int badgesCount;
  final int achievementsCount;
  final int? thisMonthPoints;
  final int? thisWeekPoints;

  /// User level title
  String get levelTitle {
    if (level <= 5) return 'Citizen';
    if (level <= 10) return 'Active Citizen';
    if (level <= 15) return 'Community Leader';
    if (level <= 20) return 'City Champion';
    return 'LGU Hero';
  }

  @override
  List<Object?> get props => [
        userId,
        userName,
        userAvatar,
        totalPoints,
        level,
        rank,
        badgesCount,
        achievementsCount,
        thisMonthPoints,
        thisWeekPoints,
      ];

  @override
  String toString() {
    return 'LeaderboardEntryEntity(userId: $userId, userName: $userName, rank: $rank)';
  }
}

/// Points transaction entity
class PointsTransactionEntity extends Equatable {
  const PointsTransactionEntity({
    required this.id,
    required this.userId,
    required this.points,
    required this.type,
    required this.description,
    required this.createdAt,
    this.referenceId,
    this.category,
  });

  final String id;
  final String userId;
  final int points;
  final PointsTransactionType type;
  final String description;
  final DateTime createdAt;
  final String? referenceId;
  final String? category;

  /// Is positive transaction (earned points)
  bool get isEarned => points > 0;

  /// Is negative transaction (spent points)
  bool get isSpent => points < 0;

  @override
  List<Object?> get props => [
        id,
        userId,
        points,
        type,
        description,
        createdAt,
        referenceId,
        category,
      ];

  @override
  String toString() {
    return 'PointsTransactionEntity(id: $id, points: $points, type: $type)';
  }
}

/// Badge category enum
enum BadgeCategory {
  service,
  community,
  reporting,
  participation,
  referral,
  special,
}

/// Badge rarity enum
enum BadgeRarity {
  common,
  uncommon,
  rare,
  epic,
  legendary,
}

/// Achievement category enum
enum AchievementCategory {
  service,
  community,
  reporting,
  participation,
  referral,
  milestone,
}

/// Reward category enum
enum RewardCategory {
  discount,
  voucher,
  merchandise,
  service,
  recognition,
  special,
}

/// Points transaction type enum
enum PointsTransactionType {
  earned,
  spent,
  bonus,
  penalty,
  adjustment,
}
