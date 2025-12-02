import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/about_us_page.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: child,
        routes: {
          '/': (context) => const Scaffold(body: Text('Home Page')),
          '/about': (context) => const AboutUsPage(),
          '/collections': (context) =>
              const Scaffold(body: Text('Collections Page')),
          '/sale': (context) => const Scaffold(body: Text('Sale Page')),
          '/login': (context) => const Scaffold(body: Text('Login Page')),
          '/cart': (context) => const Scaffold(body: Text('Cart Page')),
          '/printshark': (context) =>
              const Scaffold(body: Text('Printshark Page')),
          '/personalise': (context) =>
              const Scaffold(body: Text('Personalise Page')),
        },
      ),
    );
  }

  group('AboutUsPage Tests', () {
    testWidgets('should display About Us page with all elements',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const AboutUsPage()));
      await tester.pump();

      // Check for Header text
      expect(
          find.text(
              '🔥 Massive BE@RBRICK Sale Live Now — Limited Editions, Exclusive Drops, and Up to 20% Off While Stock Lasts!'),
          findsOneWidget);

      // Check for Logo
      expect(find.byType(Image), findsWidgets);

      // Check for Navigation Links
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About Us'), findsNWidgets(2)); // Header and footer link
      expect(find.text('Collections'), findsOneWidget);
      expect(find.text('Sale'), findsOneWidget);
      expect(find.text('Printshark'), findsOneWidget);

      // Check for Header Icons
      expect(
          find.descendant(
              of: find.byType(HeaderSearchWidget),
              matching: find.byIcon(Icons.search)),
          findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // Check that search field is not visible initially
      expect(find.byType(TextField), findsNothing);

      // Tap search icon and verify text field appears
      await tester.tap(find.descendant(
          of: find.byType(HeaderSearchWidget),
          matching: find.byIcon(Icons.search)));
      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('should display main content of About Us page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const AboutUsPage()));
      await tester.pump();

      // Check for main banner text
      expect(find.text('About Bearbrick Shop'), findsOneWidget);
      expect(find.text('Collectors Choice'), findsOneWidget);

      // Check for content body
      expect(
          find.text(
              'Welcome to Bearbrick Shop, your number one source for all things Bearbrick. We\'re dedicated to giving you the best of collectible figures, with a focus on authenticity, customer service, and uniqueness.'),
          findsOneWidget);
      expect(
          find.text(
              'Founded in 2023, Bearbrick Shop has come a long way from its beginnings. When we first started out, our passion for eco-friendly cleaning products drove us to do tons of research, so that Bearbrick Shop can offer you the world\'s most advanced collectibles. We now serve customers all over the world, and are thrilled that we\'re able to turn our passion into our own website.'),
          findsOneWidget);
      expect(
          find.text(
              'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us.'),
          findsOneWidget);
    });

    testWidgets('should display footer on About Us page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const AboutUsPage()));
      await tester.pump();

      // Scroll to the bottom to make sure footer is visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Check for footer content
      expect(find.text('OPENING HOURS'), findsOneWidget);
      expect(find.text('INFORMATION'), findsOneWidget);
      expect(find.text('HELP'), findsOneWidget);
      expect(find.text('© 2024 Bearbrick Shop. All rights reserved.'),
          findsOneWidget);
      // Check for search icon in footer
      expect(
          find.descendant(
              of: find.byType(Footer), matching: find.byIcon(Icons.search)),
          findsOneWidget);
    });
  });
}
