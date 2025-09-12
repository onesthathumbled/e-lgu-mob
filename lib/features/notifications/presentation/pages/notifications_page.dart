import 'package:flutter/material.dart';
import '../../../../shared/widgets/main_navigation.dart';
import '../../domain/entities/notification_entity.dart';

/// Notifications page
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Mock notifications data
  List<NotificationEntity> _notifications = [
    NotificationEntity(
      id: 'notif_001',
      title: 'Application Approved',
      body: 'Your business permit application has been approved. You can now download your permit.',
      type: NotificationType.applicationStatus,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      priority: NotificationPriority.high,
      category: 'Business Permits',
      actionUrl: '/business-permits',
    ),
    NotificationEntity(
      id: 'notif_002',
      title: 'Payment Reminder',
      body: 'Your property tax payment is due in 3 days. Pay now to avoid penalties.',
      type: NotificationType.paymentReminder,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      priority: NotificationPriority.normal,
      category: 'Property Tax',
      actionUrl: '/property-tax',
    ),
    NotificationEntity(
      id: 'notif_003',
      title: 'Document Ready',
      body: 'Your birth certificate is ready for pickup at the Civil Registry Office.',
      type: NotificationType.documentReady,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      priority: NotificationPriority.normal,
      category: 'Civil Registry',
      actionUrl: '/civil-registry',
    ),
    NotificationEntity(
      id: 'notif_004',
      title: 'Emergency Alert',
      body: 'Heavy rainfall expected. Please stay indoors and avoid flooded areas.',
      type: NotificationType.emergencyAlert,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      priority: NotificationPriority.urgent,
      category: 'Emergency',
    ),
    NotificationEntity(
      id: 'notif_005',
      title: 'Appointment Reminder',
      body: 'You have an inspection appointment tomorrow at 2:00 PM for your health permit.',
      type: NotificationType.appointment,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      priority: NotificationPriority.normal,
      category: 'Permits',
      actionUrl: '/permits',
    ),
    NotificationEntity(
      id: 'notif_006',
      title: 'System Update',
      body: 'e-LGU app has been updated with new features. Update now for the best experience.',
      type: NotificationType.systemUpdate,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      priority: NotificationPriority.low,
      category: 'System',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => n.isUnread).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const ServicesDrawer(),
      body: Column(
        children: [
          // Header with actions
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'You have $unreadCount unread notifications',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                if (unreadCount > 0)
                  TextButton(
                    onPressed: _markAllAsRead,
                    child: const Text('Mark all as read'),
                  ),
              ],
            ),
          ),
          
          // Notifications list
          Expanded(
            child: _notifications.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return _NotificationCard(
                        notification: notification,
                        onTap: () => _handleNotificationTap(notification),
                        onMarkAsRead: () => _markAsRead(notification),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(NotificationEntity notification) {
    // Mark as read if unread
    if (notification.isUnread) {
      _markAsRead(notification);
    }

    // Navigate to relevant screen if action URL is provided
    if (notification.actionUrl != null) {
      // In a real app, this would use proper navigation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigate to: ${notification.actionUrl}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _markAsRead(NotificationEntity notification) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        _notifications[index] = NotificationEntity(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          type: notification.type,
          createdAt: notification.createdAt,
          readAt: DateTime.now(),
          actionUrl: notification.actionUrl,
          data: notification.data,
          priority: notification.priority,
          category: notification.category,
        );
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications.map((notification) {
        if (notification.isUnread) {
          return NotificationEntity(
            id: notification.id,
            title: notification.title,
            body: notification.body,
            type: notification.type,
            createdAt: notification.createdAt,
            readAt: DateTime.now(),
            actionUrl: notification.actionUrl,
            data: notification.data,
            priority: notification.priority,
            category: notification.category,
          );
        }
        return notification;
      }).toList();
    });
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
  });

  final NotificationEntity notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  Color _getPriorityColor() {
    switch (notification.priority) {
      case NotificationPriority.low:
        return Colors.grey;
      case NotificationPriority.normal:
        return Colors.blue;
      case NotificationPriority.high:
        return Colors.orange;
      case NotificationPriority.urgent:
        return Colors.red;
    }
  }

  IconData _getTypeIcon() {
    switch (notification.type) {
      case NotificationType.applicationStatus:
        return Icons.assignment_turned_in;
      case NotificationType.paymentReminder:
        return Icons.payment;
      case NotificationType.documentReady:
        return Icons.description;
      case NotificationType.appointment:
        return Icons.event;
      case NotificationType.announcement:
        return Icons.campaign;
      case NotificationType.emergencyAlert:
        return Icons.warning;
      case NotificationType.systemUpdate:
        return Icons.system_update;
      case NotificationType.general:
        return Icons.notifications;
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(notification.createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${notification.createdAt.day}/${notification.createdAt.month}/${notification.createdAt.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: notification.isUnread ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: notification.isUnread
            ? BorderSide(color: _getPriorityColor().withValues(alpha: 0.3), width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getPriorityColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getTypeIcon(),
                  color: _getPriorityColor(),
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and time
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: notification.isUnread 
                                  ? FontWeight.w600 
                                  : FontWeight.w500,
                            ),
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
                    
                    const SizedBox(height: 4),
                    
                    // Body
                    Text(
                      notification.body,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Category and priority
                    Row(
                      children: [
                        if (notification.category != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              notification.category!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (notification.priority == NotificationPriority.urgent)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'URGENT',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const Spacer(),
                        if (notification.isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getPriorityColor(),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
