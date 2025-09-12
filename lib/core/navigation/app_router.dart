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

/// Home page placeholder
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LGU Mobile'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 64,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to LGU Mobile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your gateway to local government services',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
