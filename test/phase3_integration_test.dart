import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_lgu_mob/main.dart';

void main() {
  group('Phase 3 Integration Tests', () {
    testWidgets('App launches successfully with Phase 3 features', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const LguApp());

      // Verify that the app starts with splash screen showing e-LGU
      expect(find.text('e-LGU'), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);

      // Wait for the timer to complete and dispose properly
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    testWidgets('Phase 3 services are accessible from home page', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Wait for splash screen to complete and navigate to onboarding
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // Navigate to login page from onboarding
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Login with demo credentials
      await tester.enterText(find.byType(TextField).first, 'john.doe@email.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // Verify we're on the home page
      expect(find.text('Welcome to e-LGU'), findsOneWidget);
      expect(find.text('Quick Services'), findsOneWidget);

      // Check for Phase 3 services in Quick Services grid
      expect(find.text('Facility Bookings'), findsOneWidget);
      expect(find.text('Events Calendar'), findsOneWidget);
      expect(find.text('Pet Registration'), findsOneWidget);

      // Check for Phase 3 services in Community section
      expect(find.text('Waste Schedule'), findsOneWidget);
      expect(find.text('Hazard Reporting'), findsOneWidget);
      expect(find.text('Transparency Dashboard'), findsOneWidget);
      expect(find.text('Open Data Portal'), findsOneWidget);
    });

    testWidgets('Facility Bookings page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Facility Bookings
      await tester.tap(find.text('Facility Bookings'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Book LGU Facilities'), findsOneWidget);
      expect(find.text('Available Facilities'), findsOneWidget);
      expect(find.text('Barangay Hall Main'), findsOneWidget);
      expect(find.text('Community Gymnasium'), findsOneWidget);
      expect(find.text('Function Room A'), findsOneWidget);
    });

    testWidgets('Events Calendar page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Events Calendar
      await tester.tap(find.text('Events Calendar'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Community Events'), findsOneWidget);
      expect(find.text('Upcoming Events'), findsOneWidget);
      expect(find.text('Barangay Assembly Meeting'), findsOneWidget);
      expect(find.text('Community Clean-up Drive'), findsOneWidget);
      expect(find.text('Basketball Tournament'), findsOneWidget);
    });

    testWidgets('Pet Registration page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Pet Registration
      await tester.tap(find.text('Pet Registration'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Pet Registration'), findsOneWidget);
      expect(find.text('My Pets'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Lost Pet Report'), findsOneWidget);
      expect(find.text('Vaccination Reminder'), findsOneWidget);
      expect(find.text('Pet Directory'), findsOneWidget);
      expect(find.text('Veterinary Services'), findsOneWidget);
    });

    testWidgets('Waste Schedule page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Waste Schedule
      await tester.tap(find.text('Waste Schedule'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Waste Collection Schedule'), findsOneWidget);
      expect(find.text('Today\'s Collection'), findsOneWidget);
      expect(find.text('Upcoming Collections'), findsOneWidget);
      expect(find.text('Weekly Collection Schedule'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
    });

    testWidgets('Hazard Reporting page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Hazard Reporting
      await tester.tap(find.text('Hazard Reporting'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Report Hazards'), findsOneWidget);
      expect(find.text('Emergency?'), findsOneWidget);
      expect(find.text('My Reports'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Road Damage'), findsOneWidget);
      expect(find.text('Electrical Issue'), findsOneWidget);
      expect(find.text('Flooding'), findsOneWidget);
      expect(find.text('Other Hazard'), findsOneWidget);
    });

    testWidgets('Transparency Dashboard page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Transparency Dashboard
      await tester.tap(find.text('Transparency Dashboard'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('LGU Transparency Dashboard'), findsOneWidget);
      expect(find.text('Overall Performance'), findsOneWidget);
      expect(find.text('Key Metrics'), findsOneWidget);
      expect(find.text('SLA Performance'), findsOneWidget);
      expect(find.text('Collection Statistics'), findsOneWidget);
      expect(find.text('Service Usage'), findsOneWidget);
      expect(find.text('Insights & Recommendations'), findsOneWidget);
    });

    testWidgets('Open Data Portal page loads correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Navigate to Open Data Portal
      await tester.tap(find.text('Open Data Portal'));
      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Open Data Portal'), findsOneWidget);
      expect(find.text('Portal Statistics'), findsOneWidget);
      expect(find.text('Search & Filter'), findsOneWidget);
      expect(find.text('Available Datasets'), findsOneWidget);
      expect(find.text('Business Permits Data'), findsOneWidget);
      expect(find.text('Property Tax Collection'), findsOneWidget);
      expect(find.text('Population Demographics'), findsOneWidget);
      expect(find.text('Service Usage Statistics'), findsOneWidget);
    });

    testWidgets('Services drawer includes Phase 3 services', (WidgetTester tester) async {
      await _loginUser(tester);

      // Open services drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Check for Phase 3 services in drawer
      expect(find.text('Facility Bookings'), findsOneWidget);
      expect(find.text('Events Calendar'), findsOneWidget);
      expect(find.text('Pet Registration'), findsOneWidget);
      expect(find.text('Waste Schedule'), findsOneWidget);
      expect(find.text('Hazard Reporting'), findsOneWidget);
      expect(find.text('Transparency Dashboard'), findsOneWidget);
      expect(find.text('Open Data Portal'), findsOneWidget);

      // Close drawer
      await tester.tap(find.byType(BackdropFilter));
      await tester.pumpAndSettle();
    });

    testWidgets('Phase 3 services navigation works correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Test Facility Bookings navigation
      await tester.tap(find.text('Facility Bookings'));
      await tester.pumpAndSettle();
      expect(find.text('Book LGU Facilities'), findsOneWidget);

      // Go back to home
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Test Events Calendar navigation
      await tester.tap(find.text('Events Calendar'));
      await tester.pumpAndSettle();
      expect(find.text('Community Events'), findsOneWidget);

      // Go back to home
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Test Pet Registration navigation
      await tester.tap(find.text('Pet Registration'));
      await tester.pumpAndSettle();
      expect(find.text('Pet Registration'), findsOneWidget);
    });

    testWidgets('Phase 3 service cards display correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Check Facility Bookings card
      final facilityCard = find.ancestor(
        of: find.text('Facility Bookings'),
        matching: find.byType(Card),
      );
      expect(facilityCard, findsOneWidget);

      // Check Events Calendar card
      final eventsCard = find.ancestor(
        of: find.text('Events Calendar'),
        matching: find.byType(Card),
      );
      expect(eventsCard, findsOneWidget);

      // Check Pet Registration card
      final petCard = find.ancestor(
        of: find.text('Pet Registration'),
        matching: find.byType(Card),
      );
      expect(petCard, findsOneWidget);
    });

    testWidgets('Phase 3 community features display correctly', (WidgetTester tester) async {
      await _loginUser(tester);

      // Scroll down to see community features
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // Check community features
      expect(find.text('Waste Schedule'), findsOneWidget);
      expect(find.text('Hazard Reporting'), findsOneWidget);
      expect(find.text('Transparency Dashboard'), findsOneWidget);
      expect(find.text('Open Data Portal'), findsOneWidget);
    });
  });
}

/// Helper function to login user
Future<void> _loginUser(WidgetTester tester) async {
  // Wait for splash screen to complete and navigate to onboarding
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();

  // Navigate to login page from onboarding
  await tester.tap(find.text('Get Started'));
  await tester.pumpAndSettle();

  // Enter credentials and login
  await tester.enterText(find.byType(TextField).first, 'john.doe@email.com');
  await tester.enterText(find.byType(TextField).last, 'password123');
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();
}
