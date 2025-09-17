import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/navigation/app_router.dart';
import '../../theme/shadcn_theme.dart';

/// Main navigation widget with bottom navigation bar
class MainNavigation extends StatelessWidget {
  const MainNavigation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ShadcnTheme.background,
          boxShadow: ShadcnTheme.shadowLg,
        ),
        child: SafeArea(
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: ShadcnTheme.space4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  isActive: currentIndex == 0,
                  onTap: () => _onTap(context, 0),
                ),
                _NavItem(
                  icon: Icons.description_outlined,
                  activeIcon: Icons.description,
                  label: 'Services',
                  isActive: currentIndex == 1,
                  onTap: () => _onTap(context, 1),
                ),
                _FloatingAddButton(
                  onTap: () => _showQuickActions(context),
                ),
                _NavItem(
                  icon: Icons.people_outline,
                  activeIcon: Icons.people,
                  label: 'Community',
                  isActive: currentIndex == 2,
                  onTap: () => _onTap(context, 2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profile',
                  isActive: currentIndex == 4,
                  onTap: () => _onTap(context, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    
    switch (location) {
      case AppRouter.home:
        return 0;
      case AppRouter.businessPermits:
      case AppRouter.propertyTax:
      case AppRouter.digitalId:
      case AppRouter.civilRegistry:
      case AppRouter.permits:
      case AppRouter.socialPrograms:
      case '/queue-management':
      case '/obos-application':
      case '/transport-services':
      case '/facility-bookings':
      case '/events-calendar':
      case '/pet-registration':
      case '/waste-schedule':
      case '/hazard-reporting':
        return 1;
      case AppRouter.community:
      case '/community-groups':
      case '/evac-map':
      case '/transparency-dashboards':
      case '/open-data-portal':
        return 2;
      case '/notifications':
        return 3;
      case AppRouter.profile:
      case '/gamification':
        return 4;
      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.businessPermits);
        break;
      case 2:
        context.go(AppRouter.community);
        break;
      case 3:
        context.go('/notifications');
        break;
      case 4:
        context.go(AppRouter.profile);
        break;
    }
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: ShadcnTheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(ShadcnTheme.radius2xl),
            topRight: Radius.circular(ShadcnTheme.radius2xl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: ShadcnTheme.space3),
              decoration: BoxDecoration(
                color: ShadcnTheme.mutedForeground,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ShadcnTheme.space6),
              child: Column(
                children: [
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: ShadcnTheme.space6),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickActionCard(
                          icon: Icons.business,
                          title: 'Business Permit',
                          onTap: () {
                            Navigator.pop(context);
                            context.go(AppRouter.businessPermits);
                          },
                        ),
                      ),
                      const SizedBox(width: ShadcnTheme.space4),
                      Expanded(
                        child: _QuickActionCard(
                          icon: Icons.home,
                          title: 'Property Tax',
                          onTap: () {
                            Navigator.pop(context);
                            context.go(AppRouter.propertyTax);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ShadcnTheme.space4),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickActionCard(
                          icon: Icons.credit_card,
                          title: 'Digital ID',
                          onTap: () {
                            Navigator.pop(context);
                            context.go(AppRouter.digitalId);
                          },
                        ),
                      ),
                      const SizedBox(width: ShadcnTheme.space4),
                      Expanded(
                        child: _QuickActionCard(
                          icon: Icons.description,
                          title: 'Documents',
                          onTap: () {
                            Navigator.pop(context);
                            context.go(AppRouter.civilRegistry);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ShadcnTheme.space6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Services navigation drawer
class ServicesDrawer extends StatelessWidget {
  const ServicesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ShadcnTheme.primary,
                  ShadcnTheme.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(height: 8),
                Text(
                  'LGU Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Local Government Services',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _ServiceTile(
                  icon: Icons.business,
                  title: 'Business Permits',
                  subtitle: 'BPLS Services',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.businessPermits);
                  },
                ),
                _ServiceTile(
                  icon: Icons.home,
                  title: 'Property Tax',
                  subtitle: 'RPT Payments',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.propertyTax);
                  },
                ),
                _ServiceTile(
                  icon: Icons.credit_card,
                  title: 'Digital ID',
                  subtitle: 'LGU ID Services',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.digitalId);
                  },
                ),
                _ServiceTile(
                  icon: Icons.description,
                  title: 'Civil Registry',
                  subtitle: 'Birth, Marriage, Death',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.civilRegistry);
                  },
                ),
                _ServiceTile(
                  icon: Icons.health_and_safety,
                  title: 'Permits',
                  subtitle: 'Health, Work, Sanitation',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.permits);
                  },
                ),
                _ServiceTile(
                  icon: Icons.volunteer_activism,
                  title: 'Social Programs',
                  subtitle: 'Assistance & Aid',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.socialPrograms);
                  },
                ),
                _ServiceTile(
                  icon: Icons.queue,
                  title: 'Queue Management',
                  subtitle: 'Digital Queue & Ticketing',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/queue-management');
                  },
                ),
                _ServiceTile(
                  icon: Icons.construction,
                  title: 'Building Permits',
                  subtitle: 'OBOS Applications',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/obos-application');
                  },
                ),
                _ServiceTile(
                  icon: Icons.local_taxi,
                  title: 'Transport Services',
                  subtitle: 'Tricycle, Parking, Violations',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/transport-services');
                  },
                ),
                _ServiceTile(
                  icon: Icons.event,
                  title: 'Facility Bookings',
                  subtitle: 'Reserve halls, gyms, courts',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/facility-bookings');
                  },
                ),
                _ServiceTile(
                  icon: Icons.calendar_today,
                  title: 'Events Calendar',
                  subtitle: 'Community events & RSVP',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/events-calendar');
                  },
                ),
                _ServiceTile(
                  icon: Icons.pets,
                  title: 'Pet Registration',
                  subtitle: 'Register pets & vaccinations',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/pet-registration');
                  },
                ),
                _ServiceTile(
                  icon: Icons.delete,
                  title: 'Waste Schedule',
                  subtitle: 'Garbage collection schedule',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/waste-schedule');
                  },
                ),
                _ServiceTile(
                  icon: Icons.report_problem,
                  title: 'Hazard Reporting',
                  subtitle: 'Report road damage, flooding',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/hazard-reporting');
                  },
                ),
                const Divider(),
                _ServiceTile(
                  icon: Icons.people,
                  title: 'Community',
                  subtitle: 'Events, Jobs, Marketplace',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.community);
                  },
                ),
                _ServiceTile(
                  icon: Icons.groups,
                  title: 'Community Groups',
                  subtitle: 'Discussion & Moderation',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/community-groups');
                  },
                ),
                _ServiceTile(
                  icon: Icons.map,
                  title: 'EVAC Map',
                  subtitle: 'Disaster & Evacuation',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/evac-map');
                  },
                ),
                _ServiceTile(
                  icon: Icons.analytics,
                  title: 'Transparency Dashboard',
                  subtitle: 'SLA metrics & collection stats',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/transparency-dashboards');
                  },
                ),
                _ServiceTile(
                  icon: Icons.dataset,
                  title: 'Open Data Portal',
                  subtitle: 'Public datasets & information',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/open-data-portal');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ShadcnTheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(ShadcnTheme.radiusMd),
        ),
        child: Icon(
          icon,
          color: ShadcnTheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ShadcnTheme.mutedForeground,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ShadcnTheme.radiusMd),
      ),
    );
  }
}

/// Modern navigation item component
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ShadcnTheme.space2,
          vertical: ShadcnTheme.space1,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? ShadcnTheme.primary : ShadcnTheme.mutedForeground,
              size: 24,
            ),
            const SizedBox(height: ShadcnTheme.space1),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isActive ? ShadcnTheme.primary : ShadcnTheme.mutedForeground,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating add button component
class _FloatingAddButton extends StatelessWidget {
  const _FloatingAddButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: ShadcnTheme.primary,
          shape: BoxShape.circle,
          boxShadow: ShadcnTheme.shadowLg,
        ),
        child: const Icon(
          Icons.add,
          color: ShadcnTheme.primaryForeground,
          size: 28,
        ),
      ),
    );
  }
}

/// Quick action card component
class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ShadcnTheme.space4),
        decoration: BoxDecoration(
          color: ShadcnTheme.muted,
          borderRadius: BorderRadius.circular(ShadcnTheme.radiusLg),
          border: Border.all(color: ShadcnTheme.border, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: ShadcnTheme.primary,
              size: 32,
            ),
            const SizedBox(height: ShadcnTheme.space2),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
