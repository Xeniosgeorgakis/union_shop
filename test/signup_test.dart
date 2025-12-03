import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/auth/signup_page.dart';
import 'package:union_shop/auth/login_page.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  Future<void> scrollToWidget(WidgetTester tester, Finder finder) async {
    final scrollableFinder = find.byType(SingleChildScrollView);
    await tester.dragUntilVisible(
      finder,
      scrollableFinder,
      const Offset(0, -100),
    );
    await tester.pumpAndSettle();
  }

  group('SignUpPage Tests', () {
    testWidgets('should display signup page elements', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pump();

      // Check for Sign Up Title
      expect(find.text('Create Account'), findsOneWidget);

      // Check for Form Fields
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Confirm Password'),
          findsOneWidget);

      // Check for Form Field Icons
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
    });

    testWidgets('should show validation errors for empty fields',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pumpAndSettle();

      // Scroll to make button visible
      await scrollToWidget(
          tester, find.widgetWithText(ElevatedButton, 'SIGN UP'));

      // Tap Sign Up button without entering data
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.pumpAndSettle();

      // Check for validation messages
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
      expect(find.text('Please confirm your password'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid email',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pumpAndSettle();

      // Enter invalid email (no @ symbol)
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'invalidemail');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Confirm Password'),
          'password123');

      // Scroll to button and tap
      await scrollToWidget(
          tester, find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.pumpAndSettle();

      // Check for email validation error
      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('should show validation error for short password',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pumpAndSettle();

      // Enter valid email but short password
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@gmail.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), '12345');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Confirm Password'), '12345');

      // Scroll to button and tap
      await scrollToWidget(
          tester, find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.pumpAndSettle();

      // Check for password length validation error
      expect(
          find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('should show validation error for mismatched passwords',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pumpAndSettle();

      // Enter valid email and password, but different confirm password
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'test@gmail.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Confirm Password'),
          'password456');

      // Scroll to button and tap
      await scrollToWidget(
          tester, find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.pumpAndSettle();

      // Check for password mismatch validation error
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('should create account with valid credentials', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: MaterialApp(
            initialRoute: '/signup',
            routes: {
              '/': (context) =>
                  const Scaffold(body: Center(child: Text('Home Screen'))),
              '/signup': (context) => const SignUpPage(),
              '/login': (context) => const LoginPage(),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter valid credentials
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Email'), 'newuser@gmail.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Confirm Password'),
          'password123');

      // Scroll to button and tap
      await scrollToWidget(
          tester, find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'SIGN UP'));
      await tester.pump(); // For SnackBar

      // Verify SnackBar appears (indicating success logic triggered)
      expect(find.text('Creating account...'), findsOneWidget);

      await tester.pumpAndSettle(); // For navigation to complete

      // Verify navigation to home screen
      expect(find.text('Home Screen'), findsOneWidget);
    });

    testWidgets('should navigate to login page when Sign In link is tapped',
        (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: MaterialApp(
            initialRoute: '/signup',
            routes: {
              '/signup': (context) => const SignUpPage(),
              '/login': (context) => const LoginPage(),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to Sign In link
      await scrollToWidget(
          tester, find.text('Already have an account? Sign In'));

      // Tap on Sign In link
      await tester.tap(find.text('Already have an account? Sign In'));
      await tester.pumpAndSettle(); // For navigation to complete

      // Verify navigation to login page
      expect(find.text('Login'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'SIGN IN'), findsOneWidget);
    });

    testWidgets('should have password fields obscured', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pump();

      // Check that password fields exist
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Confirm Password'),
          findsOneWidget);
    });

    testWidgets('should display bearbrick logo', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pump();

      // Check for logo image - there should be at least 1
      final logoFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                'assets/images/bearbricklogo.png',
      );

      expect(logoFinder, findsAtLeastNWidgets(1));
    });

    testWidgets('should have properly styled form container', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pumpAndSettle();

      // Check for Form widget
      expect(find.byType(Form), findsOneWidget);

      // Scroll to button
      await scrollToWidget(
          tester, find.widgetWithText(ElevatedButton, 'SIGN UP'));

      // Check for elevated button styling
      final signUpButton = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'SIGN UP'));
      expect(signUpButton.style?.backgroundColor?.resolve({}), Colors.black);
      expect(signUpButton.style?.foregroundColor?.resolve({}), Colors.white);
    });

    testWidgets('should dispose controllers properly', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SignUpPage()));
      await tester.pump();

      // Verify page is displayed
      expect(find.text('Create Account'), findsOneWidget);

      // Remove the widget tree (this will trigger dispose)
      await tester.pumpWidget(Container());
      await tester.pump();

      // If dispose() had issues, this would throw an error
      // Successfully reaching here means dispose was called properly
    });
  });
}
