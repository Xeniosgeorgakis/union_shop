import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/login_page.dart';

void main() {
  group('LoginPage Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: LoginPage(),
      );
    }

    testWidgets('should display login page elements', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check for Header text
      expect(
          find.text(
              '🔥 Massive BE@RBRICK Sale Live Now — Limited Editions, Exclusive Drops, and Up to 20% Off While Stock Lasts!'),
          findsOneWidget);

      // Check for Logo
      expect(find.byType(Image), findsWidgets);

      // Check for Login Title
      expect(find.text('Login'), findsOneWidget);

      // Check for Form Fields
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

      // Check for Sign In Button
      expect(find.widgetWithText(ElevatedButton, 'SIGN IN'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty fields',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Tap Sign In button without entering data
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN IN'));
      await tester.pump();

      // Check for validation messages
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid email domain',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Enter invalid email
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@yahoo.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');

      // Tap Sign In button
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN IN'));
      await tester.pump();

      // Check for specific domain validation error
      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('should allow login with valid gmail', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Enter valid gmail
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'user@gmail.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');

      // Tap Sign In button
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN IN'));
      await tester.pump();

      // Verify no validation errors exist
      expect(find.text('Enter a valid email'), findsNothing);
      expect(find.text('Please enter your email'), findsNothing);

      // Verify SnackBar appears (indicating success logic triggered)
      expect(find.text('Logging in...'), findsOneWidget);
    });

    testWidgets('should allow login with valid hotmail', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Enter valid hotmail
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'user@hotmail.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');

      // Tap Sign In button
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN IN'));
      await tester.pump();

      // Verify SnackBar appears
      expect(find.text('Logging in...'), findsOneWidget);
    });
  });
}
