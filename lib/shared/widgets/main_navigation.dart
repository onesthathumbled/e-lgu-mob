import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/navigation/app_router.dart';

/// Main navigation widget with bottom navigation bar
class MainNavigation extends StatelessWidget {
  const MainNavigation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTap(context, index),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            activeIcon: Icon(Icons.business),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch_outlined),
            activeIcon: Icon(Icons.rocket_launch),
            label: 'Phase 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
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
        return 1;
      case AppRouter.community:
        return 2;
      case '/notifications':
        return 3;
      case '/phase2':
        return 4;
      case AppRouter.profile:
        return 5;
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
        context.go('/phase2');
        break;
      case 5:
        context.go(AppRouter.profile);
        break;
    }
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
              color: Theme.of(context).colorScheme.primary,
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
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
