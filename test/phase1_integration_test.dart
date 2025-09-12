import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_lgu_mob/main.dart';

/// Phase 1 Integration Tests for e-LGU Mobile App
/// 
/// This test suite validates all Phase 1 functionalities:
/// 1. Authentication System
/// 2. Business Permits (BPLS)
/// 3. Property Tax Payment (RPT)
/// 4. Digital ID Registration
/// 5. Civil Registry Document Requests
/// 6. Permits Application System
/// 7. Social Programs Application
/// 8. Community Features (Events, Jobs, Marketplace)
void main() {
  group('e-LGU Phase 1 Integration Tests', () {
    testWidgets('App launches successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const LguApp());
      
      // Verify that the app starts with splash screen
      expect(find.text('e-LGU'), findsOneWidget);
    });

    testWidgets('Authentication flow works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Wait for splash screen to complete and navigate to onboarding
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      // Navigate to login page from onboarding
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Verify login page elements
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Sign in with eGovPH'), findsOneWidget);

      // Test login with demo credentials
      await tester.enterText(find.byType(TextField).first, 'john.doe@email.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // Verify successful login and navigation to home
      expect(find.text('Welcome to e-LGU'), findsOneWidget);
      expect(find.text('Quick Services'), findsOneWidget);
    });

    testWidgets('Home page displays all service cards', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Navigate to home page (assuming already logged in)
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'john.doe@email.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      // Verify all service cards are present
      expect(find.text('Business Permits'), findsOneWidget);
      expect(find.text('Property Tax'), findsOneWidget);
      expect(find.text('Digital ID'), findsOneWidget);
      expect(find.text('Civil Registry'), findsOneWidget);
      expect(find.text('Permits'), findsOneWidget);
      expect(find.text('Social Programs'), findsOneWidget);
      expect(find.text('Community'), findsOneWidget);
    });

    testWidgets('Business Permits application flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Business Permits
      await tester.tap(find.text('Business Permits'));
      await tester.pumpAndSettle();

      // Verify Business Permits page
      expect(find.text('Business Permits & Licensing'), findsOneWidget);
      expect(find.text('New Business Permit'), findsOneWidget);

      // Navigate to New Business Permit
      await tester.tap(find.text('New Business Permit'));
      await tester.pumpAndSettle();

      // Verify New Business Permit form
      expect(find.text('New Business Permit'), findsOneWidget);
      expect(find.text('Business Information'), findsOneWidget);
      expect(find.text('Business Name *'), findsOneWidget);
      expect(find.text('Submit Application'), findsOneWidget);
    });

    testWidgets('Property Tax payment flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Property Tax
      await tester.tap(find.text('Property Tax'));
      await tester.pumpAndSettle();

      // Verify Property Tax page
      expect(find.text('Real Property Tax Services'), findsOneWidget);
      expect(find.text('Pay Real Property Tax'), findsOneWidget);

      // Navigate to Property Tax Payment
      await tester.tap(find.text('Pay Real Property Tax'));
      await tester.pumpAndSettle();

      // Verify Property Tax Payment form
      expect(find.text('Pay Real Property Tax'), findsOneWidget);
      expect(find.text('Property Lookup'), findsOneWidget);
      expect(find.text('Tax Declaration Number'), findsOneWidget);
      expect(find.text('Search Property'), findsOneWidget);
    });

    testWidgets('Digital ID registration flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Digital ID
      await tester.tap(find.text('Digital ID'));
      await tester.pumpAndSettle();

      // Verify Digital ID page
      expect(find.text('Local Digital ID'), findsOneWidget);
      expect(find.text('Apply for Digital ID'), findsOneWidget);

      // Navigate to Digital ID Registration
      await tester.tap(find.text('Apply for Digital ID'));
      await tester.pumpAndSettle();

      // Verify Digital ID Registration form
      expect(find.text('Digital ID Registration'), findsOneWidget);
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('First Name *'), findsOneWidget);
      expect(find.text('Register Digital ID'), findsOneWidget);
    });

    testWidgets('Civil Registry document request flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Civil Registry
      await tester.tap(find.text('Civil Registry'));
      await tester.pumpAndSettle();

      // Verify Civil Registry page
      expect(find.text('Civil Registry Services'), findsOneWidget);
      expect(find.text('Birth Certificate'), findsOneWidget);

      // Navigate to Birth Certificate request
      await tester.tap(find.text('Birth Certificate'));
      await tester.pumpAndSettle();

      // Verify Civil Registry Request form
      expect(find.text('Request Birth Certificate'), findsOneWidget);
      expect(find.text('Requestor Information'), findsOneWidget);
      expect(find.text('Full Name *'), findsOneWidget);
      expect(find.text('Submit Request'), findsOneWidget);
    });

    testWidgets('Permits application flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Permits
      await tester.tap(find.text('Permits'));
      await tester.pumpAndSettle();

      // Verify Permits page
      expect(find.text('Permits & Licenses'), findsOneWidget);
      expect(find.text('Health Permit'), findsOneWidget);

      // Navigate to Health Permit application
      await tester.tap(find.text('Health Permit'));
      await tester.pumpAndSettle();

      // Verify Permits Application form
      expect(find.text('Apply for Health Permit'), findsOneWidget);
      expect(find.text('Business Information'), findsOneWidget);
      expect(find.text('Business Name *'), findsOneWidget);
      expect(find.text('Submit Application'), findsOneWidget);
    });

    testWidgets('Social Programs application flow', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Social Programs
      await tester.tap(find.text('Social Programs'));
      await tester.pumpAndSettle();

      // Verify Social Programs page
      expect(find.text('Citizen Assistance & Social Programs'), findsOneWidget);
      expect(find.text('Medical Assistance Program'), findsOneWidget);

      // Navigate to Medical Assistance Program
      await tester.tap(find.text('Medical Assistance Program'));
      await tester.pumpAndSettle();

      // Verify Social Programs Application form
      expect(find.text('Apply for Medical Assistance Program'), findsOneWidget);
      expect(find.text('Eligibility Requirements'), findsOneWidget);
      expect(find.text('Application Form'), findsOneWidget);
      expect(find.text('Submit Application'), findsOneWidget);
    });

    testWidgets('Community features navigation', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Community
      await tester.tap(find.text('Community'));
      await tester.pumpAndSettle();

      // Verify Community page
      expect(find.text('Community Features'), findsOneWidget);
      expect(find.text('Local Events'), findsOneWidget);
      expect(find.text('Job Board'), findsOneWidget);
      expect(find.text('Local Marketplace'), findsOneWidget);

      // Test Community Events navigation
      await tester.tap(find.text('Local Events'));
      await tester.pumpAndSettle();
      expect(find.text('Community Events'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Test Job Board navigation
      await tester.tap(find.text('Job Board'));
      await tester.pumpAndSettle();
      expect(find.text('Job Opportunities'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Test Marketplace navigation
      await tester.tap(find.text('Local Marketplace'));
      await tester.pumpAndSettle();
      expect(find.text('E-Palengke (Marketplace)'), findsOneWidget);
    });

    testWidgets('Services drawer navigation works', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Open services drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verify drawer contents
      expect(find.text('LGU Services'), findsOneWidget);
      expect(find.text('Business Permits'), findsOneWidget);
      expect(find.text('Property Tax'), findsOneWidget);
      expect(find.text('Digital ID'), findsOneWidget);
      expect(find.text('Civil Registry'), findsOneWidget);
      expect(find.text('Permits'), findsOneWidget);
      expect(find.text('Social Programs'), findsOneWidget);
      expect(find.text('Community'), findsOneWidget);
    });

    testWidgets('Bottom navigation works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Test bottom navigation
      await tester.tap(find.text('Services'));
      await tester.pumpAndSettle();
      expect(find.text('Business Permits'), findsOneWidget);

      await tester.tap(find.text('Community'));
      await tester.pumpAndSettle();
      expect(find.text('Community Features'), findsOneWidget);

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Welcome to e-LGU'), findsOneWidget);
    });

    testWidgets('Form validation works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Navigate to Business Permits
      await tester.tap(find.text('Business Permits'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('New Business Permit'));
      await tester.pumpAndSettle();

      // Try to submit empty form
      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      // Verify validation messages appear
      expect(find.text('Business name is required'), findsOneWidget);
    });

    testWidgets('Mock data displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const LguApp());
      await tester.pumpAndSettle();

      // Login and navigate to home
      await _loginUser(tester);
      
      // Test Property Tax mock data
      await tester.tap(find.text('Property Tax'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pay Real Property Tax'));
      await tester.pumpAndSettle();

      // Enter mock property data
      await tester.enterText(find.byType(TextField).first, 'TD-2024-001');
      await tester.enterText(find.byType(TextField).last, 'PIN-123456789');
      await tester.tap(find.text('Search Property'));
      await tester.pumpAndSettle();

      // Verify mock property data displays
      expect(find.text('Property Details'), findsOneWidget);
      expect(find.text('Lot 123, Block 45, Sample Subdivision'), findsOneWidget);
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
