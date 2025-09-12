import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/business_permits/presentation/pages/business_permits_page.dart';
import '../../features/property_tax/presentation/pages/property_tax_page.dart';
import '../../features/digital_id/presentation/pages/digital_id_page.dart';
import '../../features/civil_registry/presentation/pages/civil_registry_page.dart';
import '../../features/permits/presentation/pages/permits_page.dart';
import '../../features/social_programs/presentation/pages/social_programs_page.dart';
import '../../features/community/presentation/pages/community_page.dart';
import '../../shared/widgets/main_navigation.dart';
import '../../shared/widgets/onboarding_page.dart';
import '../../shared/widgets/splash_page.dart';

/// Application router configuration
class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String businessPermits = '/business-permits';
  static const String propertyTax = '/property-tax';
  static const String digitalId = '/digital-id';
  static const String civilRegistry = '/civil-registry';
  static const String permits = '/permits';
  static const String socialPrograms = '/social-programs';
  static const String community = '/community';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash screen
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Onboarding
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      
      // Authentication routes
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      
      // Main app with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: profile,
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: businessPermits,
            name: 'business-permits',
            builder: (context, state) => const BusinessPermitsPage(),
          ),
          GoRoute(
            path: propertyTax,
            name: 'property-tax',
            builder: (context, state) => const PropertyTaxPage(),
          ),
          GoRoute(
            path: digitalId,
            name: 'digital-id',
            builder: (context, state) => const DigitalIdPage(),
          ),
          GoRoute(
            path: civilRegistry,
            name: 'civil-registry',
            builder: (context, state) => const CivilRegistryPage(),
          ),
          GoRoute(
            path: permits,
            name: 'permits',
            builder: (context, state) => const PermitsPage(),
          ),
          GoRoute(
            path: socialPrograms,
            name: 'social-programs',
            builder: (context, state) => const SocialProgramsPage(),
          ),
          GoRoute(
            path: community,
            name: 'community',
            builder: (context, state) => const CommunityPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Home page with service overview
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('e-LGU'),
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
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Welcome to e-LGU',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your gateway to local government services',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Services Section
            Text(
              'Quick Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Services Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _ServiceCard(
                  icon: Icons.business,
                  title: 'Business Permits',
                  subtitle: 'BPLS Services',
                  color: Colors.blue,
                  onTap: () => context.go(AppRouter.businessPermits),
                ),
                _ServiceCard(
                  icon: Icons.home,
                  title: 'Property Tax',
                  subtitle: 'RPT Payments',
                  color: Colors.green,
                  onTap: () => context.go(AppRouter.propertyTax),
                ),
                _ServiceCard(
                  icon: Icons.credit_card,
                  title: 'Digital ID',
                  subtitle: 'LGU ID Services',
                  color: Colors.orange,
                  onTap: () => context.go(AppRouter.digitalId),
                ),
                _ServiceCard(
                  icon: Icons.description,
                  title: 'Civil Registry',
                  subtitle: 'Birth, Marriage, Death',
                  color: Colors.purple,
                  onTap: () => context.go(AppRouter.civilRegistry),
                ),
                _ServiceCard(
                  icon: Icons.health_and_safety,
                  title: 'Permits',
                  subtitle: 'Health, Work, Sanitation',
                  color: Colors.red,
                  onTap: () => context.go(AppRouter.permits),
                ),
                _ServiceCard(
                  icon: Icons.volunteer_activism,
                  title: 'Social Programs',
                  subtitle: 'Assistance & Aid',
                  color: Colors.teal,
                  onTap: () => context.go(AppRouter.socialPrograms),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Community Section
            Text(
              'Community',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            _ServiceCard(
              icon: Icons.people,
              title: 'Community',
              subtitle: 'Events, Jobs, Marketplace',
              color: Colors.indigo,
              onTap: () => context.go(AppRouter.community),
              isFullWidth: true,
            ),
            
            const SizedBox(height: 24),
            
            // Information Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'All services are available 24/7. For assistance, contact the LGU hotline.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.isFullWidth = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
