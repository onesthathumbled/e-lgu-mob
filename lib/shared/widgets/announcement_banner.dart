import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/announcement_banner_provider.dart';
import 'shadcn_components.dart';

/// Announcement banner widget that appears once but can be reset
class AnnouncementBanner extends ConsumerWidget {
  const AnnouncementBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerState = ref.watch(announcementBannerProvider);
    final bannerNotifier = ref.read(announcementBannerProvider.notifier);

    // Don't show banner if it's not visible
    if (!bannerState.isVisible) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ShadBanner(
        title: bannerState.title,
        description: bannerState.description,
        variant: ShadBannerVariant.default_,
        action: bannerState.actionText != null
            ? ShadButton(
                text: bannerState.actionText!,
                onPressed: () {
                  if (bannerState.actionUrl != null) {
                    context.go(bannerState.actionUrl!);
                  }
                },
                variant: ShadButtonVariant.outline,
                size: ShadButtonSize.sm,
              )
            : null,
        onDismiss: () {
          bannerNotifier.dismissBanner();
        },
      ),
    );
  }
}

/// Real announcement-style banner that appears as an overlay notification
class AnnouncementBannerOverlay extends ConsumerWidget {
  const AnnouncementBannerOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerState = ref.watch(announcementBannerProvider);

    // Don't show banner if it's not visible
    if (!bannerState.isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Material(
            elevation: 12,
            borderRadius: BorderRadius.circular(20),
            shadowColor: const Color(0xFF0038A8).withValues(alpha: 0.3),
            child: Container(
              padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  const Color(0xFF0038A8).withValues(alpha: 0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF0038A8).withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and close button
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF0038A8), // Philippine Flag Blue
                            const Color(0xFF0038A8).withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.campaign,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bannerState.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color(0xFF0038A8), // Philippine Flag Blue
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '🇵🇭 e-LGU Announcement',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(announcementBannerProvider.notifier).dismissBanner();
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Description
                Text(
                  bannerState.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Action buttons
                Row(
                  children: [
                    if (bannerState.actionText != null) ...[
                      Expanded(
                        child: ShadButton(
                          text: bannerState.actionText!,
                          onPressed: () {
                            if (bannerState.actionUrl != null) {
                              context.go(bannerState.actionUrl!);
                            }
                            ref.read(announcementBannerProvider.notifier).dismissBanner();
                          },
                          variant: ShadButtonVariant.primary,
                          size: ShadButtonSize.default_,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    ShadButton(
                      text: 'Dismiss',
                      onPressed: () {
                        ref.read(announcementBannerProvider.notifier).dismissBanner();
                      },
                      variant: ShadButtonVariant.outline,
                      size: ShadButtonSize.default_,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ),    );
  }
}

/// Homepage announcement banner that shows as an overlay
class HomepageAnnouncementBanner extends ConsumerWidget {
  const HomepageAnnouncementBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AnnouncementBannerOverlay();
  }
}

/// Admin/Developer widget to reset announcement banner
class AnnouncementBannerResetWidget extends ConsumerWidget {
  const AnnouncementBannerResetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerState = ref.watch(announcementBannerProvider);
    final bannerNotifier = ref.read(announcementBannerProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Announcement Banner',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${bannerState.isVisible ? "Visible" : "Hidden"}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    text: 'Reset Banner',
                    onPressed: () {
                      bannerNotifier.resetBanner();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Announcement banner reset successfully!'),
                          backgroundColor: Color(0xFF22C55E), // Success green
                        ),
                      );
                    },
                    variant: ShadButtonVariant.outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ShadButton(
                    text: 'Show Custom',
                    onPressed: () {
                      bannerNotifier.showCustomBanner(
                        title: '🎉 New Feature Available!',
                        description: 'Check out our latest updates and improvements to better serve you.',
                        actionText: 'Explore',
                        actionUrl: '/services',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Custom announcement banner shown!'),
                          backgroundColor: Color(0xFF22C55E), // Success green
                        ),
                      );
                    },
                    variant: ShadButtonVariant.primary,
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
