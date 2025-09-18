import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/phase2/queue_management/presentation/pages/queue_dashboard_page.dart';
import '../../features/phase2/obos/presentation/pages/obos_application_page.dart';
import '../../features/phase2/transport/presentation/pages/transport_services_page.dart';
import '../../features/phase2/evac_map/presentation/pages/evac_map_page.dart';
import '../../features/phase2/community_groups/presentation/pages/community_groups_page.dart';
import '../../features/phase2/gamification/presentation/pages/gamification_page.dart';
import '../../features/phase3/facility_bookings/presentation/pages/facility_bookings_page.dart';
import '../../features/phase3/events_calendar/presentation/pages/events_calendar_page.dart';
import '../../features/phase3/pet_registration/presentation/pages/pet_registration_page.dart';
import '../../features/phase3/waste_schedule/presentation/pages/waste_schedule_page.dart';
import '../../features/phase3/hazard_reporting/presentation/pages/hazard_reporting_page.dart';
import '../../features/phase3/transparency_dashboards/presentation/pages/transparency_dashboards_page.dart';
import '../../features/phase3/open_data_portal/presentation/pages/open_data_portal_page.dart';
import '../../shared/widgets/main_navigation.dart';
import '../../shared/widgets/onboarding_page.dart';
import '../../shared/widgets/splash_page.dart';
import '../../shared/widgets/stories_carousel.dart';
import '../../shared/widgets/announcement_banner.dart';

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
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationsPage(),
          ),
          GoRoute(
            path: '/queue-management',
            name: 'queue-management',
            builder: (context, state) => const QueueDashboardPage(),
          ),
          GoRoute(
            path: '/obos-application',
            name: 'obos-application',
            builder: (context, state) => const ObosApplicationPage(),
          ),
          GoRoute(
            path: '/transport-services',
            name: 'transport-services',
            builder: (context, state) => const TransportServicesPage(),
          ),
          GoRoute(
            path: '/evac-map',
            name: 'evac-map',
            builder: (context, state) => const EvacMapPage(),
          ),
          GoRoute(
            path: '/community-groups',
            name: 'community-groups',
            builder: (context, state) => const CommunityGroupsPage(),
          ),
          GoRoute(
            path: '/gamification',
            name: 'gamification',
            builder: (context, state) => const GamificationPage(),
          ),
          GoRoute(
            path: '/facility-bookings',
            name: 'facility-bookings',
            builder: (context, state) => const FacilityBookingsPage(),
          ),
          GoRoute(
            path: '/events-calendar',
            name: 'events-calendar',
            builder: (context, state) => const EventsCalendarPage(),
          ),
          GoRoute(
            path: '/pet-registration',
            name: 'pet-registration',
            builder: (context, state) => const PetRegistrationPage(),
          ),
          GoRoute(
            path: '/waste-schedule',
            name: 'waste-schedule',
            builder: (context, state) => const WasteSchedulePage(),
          ),
          GoRoute(
            path: '/hazard-reporting',
            name: 'hazard-reporting',
            builder: (context, state) => const HazardReportingPage(),
          ),
          GoRoute(
            path: '/transparency-dashboards',
            name: 'transparency-dashboards',
            builder: (context, state) => const TransparencyDashboardsPage(),
          ),
          GoRoute(
            path: '/open-data-portal',
            name: 'open-data-portal',
            builder: (context, state) => const OpenDataPortalPage(),
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
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _showAllQuickActions = false;
  bool _showAllGovernmentServices = false;
  bool _showAllCommunity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🇵🇭 e-LGU',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu,
                  color: Color(0xFF34C759),
                  size: 20,
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const ServicesDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            // Welcome Section - Modern Green Theme
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF34C759), // Modern Green
                    const Color(0xFF34C759).withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF34C759).withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🇵🇭 e-LGU',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Your gateway to local government services',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Stories/MyDay Carousel Section
            const StoriesCarousel(),
            
            const SizedBox(height: 24),
            
            // Quick Actions Section
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
                fontSize: 20,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Quick Actions Grid - 3 items per row, max 6 items
            _buildServiceGrid(
              services: [
                _ServiceItem(Icons.business, 'Business Permits', '', () => context.go(AppRouter.businessPermits)),
                _ServiceItem(Icons.home, 'Property Tax', '', () => context.go(AppRouter.propertyTax)),
                _ServiceItem(Icons.credit_card, 'Digital ID', '', () => context.go(AppRouter.digitalId)),
                _ServiceItem(Icons.queue, 'Queue Mgmt', '', () => context.go('/queue-management')),
                _ServiceItem(Icons.description, 'Civil Registry', '', () => context.go(AppRouter.civilRegistry)),
                _ServiceItem(Icons.health_and_safety, 'Permits', '', () => context.go(AppRouter.permits)),
                _ServiceItem(Icons.volunteer_activism, 'Social Programs', '', () => context.go(AppRouter.socialPrograms)),
                _ServiceItem(Icons.construction, 'Building Permits', '', () => context.go('/obos-application')),
              ],
              showAll: _showAllQuickActions,
              onToggleShowAll: () => setState(() => _showAllQuickActions = !_showAllQuickActions),
            ),
            
            const SizedBox(height: 24),
            
            // Government Services Section
            Text(
              'Government Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
                fontSize: 20,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Government Services Grid - 3 items per row, max 6 items
            _buildServiceGrid(
              services: [
                _ServiceItem(Icons.credit_card, 'Digital ID', 'LGU ID', () => context.go(AppRouter.digitalId)),
                _ServiceItem(Icons.description, 'Civil Registry', 'Birth, Marriage', () => context.go(AppRouter.civilRegistry)),
                _ServiceItem(Icons.health_and_safety, 'Permits', 'Health, Work', () => context.go(AppRouter.permits)),
                _ServiceItem(Icons.volunteer_activism, 'Social Programs', 'Assistance', () => context.go(AppRouter.socialPrograms)),
                _ServiceItem(Icons.queue, 'Queue Mgmt', 'Digital Queue', () => context.go('/queue-management')),
                _ServiceItem(Icons.construction, 'Building Permits', 'OBOS', () => context.go('/obos-application')),
                _ServiceItem(Icons.local_taxi, 'Transport', 'Tricycle, Parking', () => context.go('/transport-services')),
                _ServiceItem(Icons.event, 'Facility Bookings', 'Reserve halls', () => context.go('/facility-bookings')),
                _ServiceItem(Icons.calendar_today, 'Events', 'Community events', () => context.go('/events-calendar')),
                _ServiceItem(Icons.pets, 'Pet Registration', 'Register pets', () => context.go('/pet-registration')),
                _ServiceItem(Icons.groups, 'Community Groups', 'Discussion', () => context.go('/community-groups')),
                _ServiceItem(Icons.emoji_events, 'Gamification', 'Points, badges', () => context.go('/gamification')),
              ],
              showAll: _showAllGovernmentServices,
              onToggleShowAll: () => setState(() => _showAllGovernmentServices = !_showAllGovernmentServices),
            ),
            
            const SizedBox(height: 24),
            
            // Community Section
            Text(
              'Community',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
                fontSize: 20,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Community Grid - 3 items per row, max 6 items
            _buildServiceGrid(
              services: [
                _ServiceItem(Icons.people, 'Community', 'Events, Jobs', () => context.go(AppRouter.community)),
                _ServiceItem(Icons.groups, 'Community Groups', 'Discussion', () => context.go('/community-groups')),
                _ServiceItem(Icons.map, 'EVAC Map', 'Disaster Centers', () => context.go('/evac-map')),
                _ServiceItem(Icons.delete, 'Waste Schedule', 'Garbage', () => context.go('/waste-schedule')),
                _ServiceItem(Icons.report_problem, 'Hazard Reporting', 'Report damage', () => context.go('/hazard-reporting')),
                _ServiceItem(Icons.analytics, 'Transparency', 'SLA metrics', () => context.go('/transparency-dashboards')),
                _ServiceItem(Icons.dataset, 'Open Data', 'Public datasets', () => context.go('/open-data-portal')),
              ],
              showAll: _showAllCommunity,
              onToggleShowAll: () => setState(() => _showAllCommunity = !_showAllCommunity),
            ),
            
            const SizedBox(height: 24),
            
            // Emergency & Important Info Section
            Text(
              'Emergency & Important Info',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Emergency Contacts
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFCE1126).withValues(alpha: 0.1), // Philippine Flag Red
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFCE1126).withValues(alpha: 0.3), // Philippine Flag Red
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: const Color(0xFFCE1126), // Philippine Flag Red
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Emergency Contacts',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFCE1126), // Philippine Flag Red
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildEmergencyContact('Police', '911', Icons.local_police),
                  _buildEmergencyContact('Fire Department', '911', Icons.local_fire_department),
                  _buildEmergencyContact('Medical Emergency', '911', Icons.medical_services),
                  _buildEmergencyContact('LGU Hotline', '(02) 123-4567', Icons.phone),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Recent Announcements
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0038A8).withValues(alpha: 0.1), // Philippine Flag Blue
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF0038A8).withValues(alpha: 0.3), // Philippine Flag Blue
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.campaign,
                        color: const Color(0xFF0038A8), // Philippine Flag Blue
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recent Announcements',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF0038A8), // Philippine Flag Blue
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildAnnouncement('New Business Permit Online Application Available', 'Apply for business permits online with faster processing.'),
                  _buildAnnouncement('Property Tax Payment Extension', 'Deadline extended to December 31, 2024.'),
                  _buildAnnouncement('Community Clean-up Drive', 'Join us this Saturday for a community clean-up event.'),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Information Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFCD116).withValues(alpha: 0.1), // Philippine Flag Yellow
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFCD116).withValues(alpha: 0.3), // Philippine Flag Yellow
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFFCD116), // Philippine Flag Yellow
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '🇵🇭 All services are available 24/7. For assistance, contact the LGU hotline.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF1A1A1A), // Dark text for readability
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
              ],
            ),
          ),
          
          // Announcement Banner Overlay
          const HomepageAnnouncementBanner(),
        ],
      ),
    );
  }
  
  Widget _buildEmergencyContact(String service, String number, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFFCE1126), // Philippine Flag Red
          ),
          const SizedBox(width: 8),
          Text(
            service,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFCE1126), // Philippine Flag Red
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnnouncement(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid({
    required List<_ServiceItem> services,
    required bool showAll,
    required VoidCallback onToggleShowAll,
  }) {
    final displayServices = showAll ? services : services.take(6).toList();
    final hasMore = services.length > 6;

    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: displayServices.map((service) => _ServiceCard(
            icon: service.icon,
            title: service.title,
            subtitle: service.subtitle,
            color: const Color(0xFF34C759), // Modern Green
            onTap: service.onTap,
          )).toList(),
        ),
        if (hasMore) ...[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onToggleShowAll,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF34C759).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF34C759), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    showAll ? 'See Less' : 'See More',
                    style: const TextStyle(
                      color: Color(0xFF34C759),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF34C759),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ServiceItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _ServiceItem(this.icon, this.title, this.subtitle, this.onTap);
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.isFullWidth = false,
    this.isCompact = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool isFullWidth;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(isCompact ? 12 : 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: isCompact ? 36 : 48,
                  height: isCompact ? 36 : 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: isCompact ? 20 : 28,
                  ),
                ),
                SizedBox(height: isCompact ? 8 : 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: isCompact ? 12 : 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: isCompact ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: isCompact ? 4 : 6),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B7280),
                      fontSize: isCompact ? 10 : 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: isCompact ? 2 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
