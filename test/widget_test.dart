// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:e_lgu_mob/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LguApp());

    // Verify that the app starts with splash screen showing e-LGU
    expect(find.text('e-LGU'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
    
    // Wait for the timer to complete and dispose properly
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
