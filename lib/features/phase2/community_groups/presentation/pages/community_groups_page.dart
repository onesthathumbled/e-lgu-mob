import 'package:flutter/material.dart';
import '../../../../../shared/widgets/shadcn_components.dart';
import '../../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/community_group_entity.dart';

/// Community groups page
class CommunityGroupsPage extends StatefulWidget {
  const CommunityGroupsPage({super.key});

  @override
  State<CommunityGroupsPage> createState() => _CommunityGroupsPageState();
}

class _CommunityGroupsPageState extends State<CommunityGroupsPage> {
  // Mock data for community groups
  List<CommunityGroupEntity> get _groups => [
    CommunityGroupEntity(
      id: 'group_001',
      name: 'Sample City Gardeners',
      description: 'A community of gardening enthusiasts sharing tips, seeds, and experiences.',
      category: GroupCategory.hobby,
      creatorId: 'user_001',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      memberCount: 234,
      isPublic: true,
      isActive: true,
      tags: ['gardening', 'plants', 'sustainability'],
      location: 'Sample City',
      moderators: ['user_001', 'user_002'],
    ),
    CommunityGroupEntity(
      id: 'group_002',
      name: 'Barangay 1 Neighborhood Watch',
      description: 'Keeping our community safe through neighborhood watch programs.',
      category: GroupCategory.neighborhood,
      creatorId: 'user_003',
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
      memberCount: 89,
      isPublic: true,
      isActive: true,
      tags: ['safety', 'security', 'community'],
      location: 'Barangay 1',
      moderators: ['user_003', 'user_004'],
    ),
    CommunityGroupEntity(
      id: 'group_003',
      name: 'Sample City Business Network',
      description: 'Connect with local entrepreneurs and business owners.',
      category: GroupCategory.business,
      creatorId: 'user_005',
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
      memberCount: 156,
      isPublic: true,
      isActive: true,
      tags: ['business', 'networking', 'entrepreneurship'],
      location: 'Sample City',
      moderators: ['user_005', 'user_006'],
    ),
    CommunityGroupEntity(
      id: 'group_004',
      name: 'Youth Sports Club',
      description: 'Promoting sports and physical fitness among the youth.',
      category: GroupCategory.sports,
      creatorId: 'user_007',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      memberCount: 67,
      isPublic: true,
      isActive: true,
      tags: ['sports', 'youth', 'fitness'],
      location: 'Sample City Sports Complex',
      moderators: ['user_007'],
    ),
  ];

  // Mock data for recent posts
  List<GroupPostEntity> get _recentPosts => [
    GroupPostEntity(
      id: 'post_001',
      groupId: 'group_001',
      authorId: 'user_001',
      authorName: 'Maria Santos',
      content: 'Just harvested my first batch of tomatoes! Here are some tips for growing healthy tomatoes in our climate.',
      postType: PostType.text,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isPinned: false,
      isLocked: false,
      likes: 15,
      comments: 8,
      shares: 3,
      tags: ['tomatoes', 'harvest', 'tips'],
    ),
    GroupPostEntity(
      id: 'post_002',
      groupId: 'group_002',
      authorId: 'user_003',
      authorName: 'Pedro Reyes',
      content: 'Neighborhood watch meeting this Saturday at 7 PM. Please attend to discuss security measures.',
      postType: PostType.announcement,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      isPinned: true,
      isLocked: false,
      likes: 12,
      comments: 5,
      shares: 2,
    ),
    GroupPostEntity(
      id: 'post_003',
      groupId: 'group_003',
      authorId: 'user_005',
      authorName: 'Ana Cruz',
      content: 'Looking for a reliable supplier for office supplies. Any recommendations?',
      postType: PostType.question,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      isPinned: false,
      isLocked: false,
      likes: 7,
      comments: 12,
      shares: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Groups'),
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
            ShadCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community Groups',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join local groups, participate in discussions, and connect with your community.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'Create Group',
                    onPressed: () {
                      _showCreateGroupDialog();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'Find Groups',
                    variant: ShadButtonVariant.outline,
                    onPressed: () {
                      _showFindGroupsDialog();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Recent Posts
            Text(
              'Recent Posts',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._recentPosts.map((post) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _PostCard(post: post),
            )),
            
            const SizedBox(height: 24),
            
            // Community Groups
            Text(
              'Community Groups',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._groups.map((group) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _GroupCard(group: group),
            )),
          ],
        ),
      ),
    );
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Group'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group Creation Features:'),
            SizedBox(height: 16),
            Text('• Set group name and description'),
            Text('• Choose category and privacy settings'),
            Text('• Add group rules and guidelines'),
            Text('• Upload cover image'),
            Text('• Set location and contact info'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Group creation form coming soon')),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showFindGroupsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Find Groups'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Group Discovery Features:'),
            SizedBox(height: 16),
            Text('• Search by name or category'),
            Text('• Filter by location'),
            Text('• Browse popular groups'),
            Text('• View group recommendations'),
            Text('• Join groups with one click'),
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
                const SnackBar(content: Text('Group discovery coming soon')),
              );
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final GroupPostEntity post;

  IconData _getPostTypeIcon() {
    switch (post.postType) {
      case PostType.text:
        return Icons.text_fields;
      case PostType.image:
        return Icons.image;
      case PostType.video:
        return Icons.video_library;
      case PostType.link:
        return Icons.link;
      case PostType.poll:
        return Icons.poll;
      case PostType.announcement:
        return Icons.campaign;
      case PostType.event:
        return Icons.event;
      case PostType.question:
        return Icons.help_outline;
    }
  }

  Color _getPostTypeColor() {
    switch (post.postType) {
      case PostType.text:
        return Colors.blue;
      case PostType.image:
        return Colors.green;
      case PostType.video:
        return Colors.purple;
      case PostType.link:
        return Colors.orange;
      case PostType.poll:
        return Colors.red;
      case PostType.announcement:
        return Colors.amber;
      case PostType.event:
        return Colors.teal;
      case PostType.question:
        return Colors.indigo;
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(post.createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}';
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
            // Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getPostTypeColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    _getPostTypeIcon(),
                    color: _getPostTypeColor(),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _getTimeAgo(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (post.isPinned)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'PINNED',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Content
            Text(
              post.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            if (post.tags != null && post.tags!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: post.tags!.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#$tag',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue.shade700,
                    ),
                  ),
                )).toList(),
              ),
            ],
            
            const SizedBox(height: 12),
            
            // Actions
            Row(
              children: [
                _ActionButton(
                  icon: Icons.thumb_up_outlined,
                  label: '${post.likes}',
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: '${post.comments}',
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: '${post.shares}',
                  onTap: () {},
                ),
                const Spacer(),
                if (post.isRecent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'NEW',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green.shade700,
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group});

  final CommunityGroupEntity group;

  IconData _getCategoryIcon() {
    switch (group.category) {
      case GroupCategory.neighborhood:
        return Icons.home;
      case GroupCategory.hobby:
        return Icons.palette;
      case GroupCategory.professional:
        return Icons.work;
      case GroupCategory.religious:
        return Icons.church;
      case GroupCategory.educational:
        return Icons.school;
      case GroupCategory.sports:
        return Icons.sports;
      case GroupCategory.cultural:
        return Icons.theater_comedy;
      case GroupCategory.environmental:
        return Icons.eco;
      case GroupCategory.health:
        return Icons.health_and_safety;
      case GroupCategory.business:
        return Icons.business;
      case GroupCategory.other:
        return Icons.group;
    }
  }

  Color _getCategoryColor() {
    switch (group.category) {
      case GroupCategory.neighborhood:
        return Colors.blue;
      case GroupCategory.hobby:
        return Colors.green;
      case GroupCategory.professional:
        return Colors.purple;
      case GroupCategory.religious:
        return Colors.amber;
      case GroupCategory.educational:
        return Colors.teal;
      case GroupCategory.sports:
        return Colors.orange;
      case GroupCategory.cultural:
        return Colors.pink;
      case GroupCategory.environmental:
        return Colors.lightGreen;
      case GroupCategory.health:
        return Colors.red;
      case GroupCategory.business:
        return Colors.indigo;
      case GroupCategory.other:
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
            // Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: _getCategoryColor(),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        group.category.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getCategoryColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (group.isNew)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'NEW',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Description
            Text(
              group.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Tags
            if (group.tags != null && group.tags!.isNotEmpty) ...[
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: group.tags!.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 12),
            ],
            
            // Footer
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  '${group.memberCount} members',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                ShadButton(
                  text: 'Join',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Joining ${group.name}...')),
                    );
                  },
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
