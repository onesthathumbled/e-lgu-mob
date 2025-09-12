import 'package:flutter/material.dart';
import '../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/gamification_entity.dart';

/// Gamification page
class GamificationPage extends StatefulWidget {
  const GamificationPage({super.key});

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  // Mock user points data
  UserPointsEntity get _userPoints => UserPointsEntity(
    userId: 'user_001',
    totalPoints: 2450,
    availablePoints: 1800,
    level: 8,
    experience: 450,
    nextLevelExperience: 600,
    rank: 15,
    badges: _mockBadges,
    achievements: _mockAchievements,
    lastUpdated: DateTime.now(),
  );

  // Mock badges data
  List<BadgeEntity> get _mockBadges => [
    BadgeEntity(
      id: 'badge_001',
      name: 'First Application',
      description: 'Complete your first service application',
      icon: '🎯',
      category: BadgeCategory.service,
      rarity: BadgeRarity.common,
      pointsRequired: 100,
      isEarned: true,
      earnedDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    BadgeEntity(
      id: 'badge_002',
      name: 'Community Helper',
      description: 'Report 5 community issues',
      icon: '🏘️',
      category: BadgeCategory.community,
      rarity: BadgeRarity.uncommon,
      pointsRequired: 500,
      isEarned: true,
      earnedDate: DateTime.now().subtract(const Duration(days: 15)),
    ),
    BadgeEntity(
      id: 'badge_003',
      name: 'Service Master',
      description: 'Complete 10 service applications',
      icon: '⭐',
      category: BadgeCategory.service,
      rarity: BadgeRarity.rare,
      pointsRequired: 1000,
      isEarned: false,
      progress: 0.7,
    ),
  ];

  // Mock achievements data
  List<AchievementEntity> get _mockAchievements => [
    AchievementEntity(
      id: 'ach_001',
      title: 'Service Champion',
      description: 'Complete 10 service applications',
      category: AchievementCategory.service,
      pointsReward: 500,
      isCompleted: false,
      requirements: ['complete_applications'],
      progress: {'complete_applications': 7},
    ),
    AchievementEntity(
      id: 'ach_002',
      title: 'Community Guardian',
      description: 'Report 5 community issues',
      category: AchievementCategory.community,
      pointsReward: 300,
      isCompleted: true,
      requirements: ['report_issues'],
      completedDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  // Mock rewards data
  List<RewardEntity> get _mockRewards => [
    RewardEntity(
      id: 'reward_001',
      name: '10% Off Business Permit',
      description: 'Get 10% discount on your next business permit application',
      pointsCost: 500,
      category: RewardCategory.discount,
      isAvailable: true,
      quantity: 50,
      validUntil: DateTime.now().add(const Duration(days: 30)),
    ),
    RewardEntity(
      id: 'reward_002',
      name: 'Free Document Processing',
      description: 'Free processing for one civil registry document',
      pointsCost: 300,
      category: RewardCategory.service,
      isAvailable: true,
      quantity: 25,
    ),
    RewardEntity(
      id: 'reward_003',
      name: 'LGU Merchandise',
      description: 'Official LGU t-shirt and cap',
      pointsCost: 800,
      category: RewardCategory.merchandise,
      isAvailable: true,
      quantity: 10,
    ),
  ];

  // Mock leaderboard data
  List<LeaderboardEntryEntity> get _mockLeaderboard => [
    LeaderboardEntryEntity(
      userId: 'user_001',
      userName: 'You',
      userAvatar: null,
      totalPoints: 2450,
      level: 8,
      rank: 15,
      badgesCount: 2,
      achievementsCount: 1,
      thisMonthPoints: 450,
      thisWeekPoints: 120,
    ),
    LeaderboardEntryEntity(
      userId: 'user_002',
      userName: 'Maria Santos',
      userAvatar: null,
      totalPoints: 3200,
      level: 12,
      rank: 1,
      badgesCount: 5,
      achievementsCount: 3,
      thisMonthPoints: 600,
      thisWeekPoints: 150,
    ),
    LeaderboardEntryEntity(
      userId: 'user_003',
      userName: 'Pedro Reyes',
      userAvatar: null,
      totalPoints: 2800,
      level: 10,
      rank: 2,
      badgesCount: 4,
      achievementsCount: 2,
      thisMonthPoints: 520,
      thisWeekPoints: 140,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards & Points'),
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
            // User Points Summary
            _UserPointsCard(userPoints: _userPoints),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'View Leaderboard',
                    onPressed: () {
                      _showLeaderboard();
                    },
                    icon: const Icon(Icons.leaderboard),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'Redeem Rewards',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      _showRewards();
                    },
                    icon: const Icon(Icons.card_giftcard),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Recent Achievements
            Text(
              'Recent Achievements',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._mockAchievements.map((achievement) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _AchievementCard(achievement: achievement),
            )),
            
            const SizedBox(height: 24),
            
            // Available Rewards
            Text(
              'Available Rewards',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._mockRewards.map((reward) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _RewardCard(reward: reward),
            )),
            
            const SizedBox(height: 24),
            
            // Badges
            Text(
              'Badges',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _mockBadges.length,
              itemBuilder: (context, index) {
                final badge = _mockBadges[index];
                return _BadgeCard(badge: badge);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLeaderboard() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leaderboard'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: _mockLeaderboard.length,
            itemBuilder: (context, index) {
              final entry = _mockLeaderboard[index];
              return _LeaderboardEntryCard(entry: entry);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showRewards() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem Rewards'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reward Categories:'),
            SizedBox(height: 16),
            Text('• Service Discounts'),
            Text('• Free Processing'),
            Text('• LGU Merchandise'),
            Text('• Special Recognition'),
            Text('• Exclusive Access'),
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
                const SnackBar(content: Text('Rewards store coming soon')),
              );
            },
            child: const Text('Browse'),
          ),
        ],
      ),
    );
  }
}

class _UserPointsCard extends StatelessWidget {
  const _UserPointsCard({required this.userPoints});

  final UserPointsEntity userPoints;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.stars,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Level ${userPoints.level}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userPoints.levelTitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Rank #${userPoints.rank}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Points display
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userPoints.totalPoints}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Points',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userPoints.availablePoints}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Available Points',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Experience progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Experience',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      '${userPoints.experience}/${userPoints.nextLevelExperience}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: userPoints.experienceProgress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  '${userPoints.pointsToNextLevel} points to next level',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
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

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({required this.achievement});

  final AchievementEntity achievement;

  Color _getCategoryColor() {
    switch (achievement.category) {
      case AchievementCategory.service:
        return Colors.blue;
      case AchievementCategory.community:
        return Colors.green;
      case AchievementCategory.reporting:
        return Colors.orange;
      case AchievementCategory.participation:
        return Colors.purple;
      case AchievementCategory.referral:
        return Colors.pink;
      case AchievementCategory.milestone:
        return Colors.amber;
    }
  }

  IconData _getCategoryIcon() {
    switch (achievement.category) {
      case AchievementCategory.service:
        return Icons.work;
      case AchievementCategory.community:
        return Icons.people;
      case AchievementCategory.reporting:
        return Icons.report;
      case AchievementCategory.participation:
        return Icons.event;
      case AchievementCategory.referral:
        return Icons.share;
      case AchievementCategory.milestone:
        return Icons.flag;
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
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: achievement.isCompleted 
                    ? _getCategoryColor().withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                achievement.isCompleted ? _getCategoryIcon() : Icons.lock,
                color: achievement.isCompleted 
                    ? _getCategoryColor()
                    : Colors.grey,
                size: 24,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  if (achievement.isInProgress) ...[
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: achievement.overallProgress,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(_getCategoryColor()),
                    ),
                  ],
                ],
              ),
            ),
            
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+${achievement.pointsReward}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getCategoryColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (achievement.isCompleted)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'COMPLETED',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
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

class _RewardCard extends StatelessWidget {
  const _RewardCard({required this.reward});

  final RewardEntity reward;

  Color _getCategoryColor() {
    switch (reward.category) {
      case RewardCategory.discount:
        return Colors.green;
      case RewardCategory.voucher:
        return Colors.blue;
      case RewardCategory.merchandise:
        return Colors.purple;
      case RewardCategory.service:
        return Colors.orange;
      case RewardCategory.recognition:
        return Colors.amber;
      case RewardCategory.special:
        return Colors.pink;
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
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getCategoryColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.card_giftcard,
                color: _getCategoryColor(),
                size: 24,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reward.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reward.quantity} available',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${reward.pointsCost} pts',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getCategoryColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ShadButton(
                  text: 'Redeem',
                  onPressed: reward.canBeRedeemed ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Redeeming ${reward.name}...')),
                    );
                  } : null,
                  variant: ShadButtonVariant.outline,
                  size: ShadButtonSize.sm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final BadgeEntity badge;

  Color _getRarityColor() {
    switch (badge.rarity) {
      case BadgeRarity.common:
        return Colors.grey;
      case BadgeRarity.uncommon:
        return Colors.green;
      case BadgeRarity.rare:
        return Colors.blue;
      case BadgeRarity.epic:
        return Colors.purple;
      case BadgeRarity.legendary:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: badge.isEarned ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: badge.isEarned 
            ? BorderSide(color: _getRarityColor().withOpacity(0.3), width: 2)
            : BorderSide.none,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: badge.isEarned 
              ? _getRarityColor().withOpacity(0.05)
              : Colors.grey.withOpacity(0.05),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              badge.icon,
              style: TextStyle(
                fontSize: 32,
                color: badge.isEarned ? _getRarityColor() : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              badge.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: badge.isEarned ? null : Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (badge.isInProgress) ...[
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: badge.progressPercentage,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(_getRarityColor()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LeaderboardEntryCard extends StatelessWidget {
  const _LeaderboardEntryCard({required this.entry});

  final LeaderboardEntryEntity entry;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = entry.userName == 'You';
    
    return Card(
      elevation: isCurrentUser ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isCurrentUser 
            ? BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Rank
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCurrentUser 
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '${entry.rank}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isCurrentUser ? Colors.white : Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundColor: isCurrentUser 
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.grey.shade300,
              child: Text(
                entry.userName[0].toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isCurrentUser 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.userName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Level ${entry.level} • ${entry.levelTitle}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Points
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${entry.totalPoints}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'points',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
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
