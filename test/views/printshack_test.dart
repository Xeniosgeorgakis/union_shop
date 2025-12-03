import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/printshark_page.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

// A mock navigator observer to verify navigation events.
class MockNavigatorObserver extends NavigatorObserver {
  bool pushed = false;
  String? pushedRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed = true;
    pushedRoute = route.settings.name;
  }

  void reset() {
    pushed = false;
    pushedRoute = null;
  }
}

void main() {
  late MockNavigatorObserver mockObserver;

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: child,
        routes: {
          '/personalise': (context) =>
              const Scaffold(body: Text('Personalise Page')),
        },
        navigatorObservers: [mockObserver],
      ),
    );
  }

  group('PrintsharkPage Tests', () {
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('should display Printshark page with all elements',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const PrintsharkPage()));
      await tester.pump();

      // Check for Header text
      expect(find.text('🔥 Massive BE@RBRICK Sale Live Now'), findsOneWidget);

      // Check for page banner
      expect(find.text('ABOUT PRINT SHACK'), findsOneWidget);

      // Check for content titles
      expect(find.text('What Is Print Shack?'), findsOneWidget);
      expect(find.text('What We Offer'), findsOneWidget);
      expect(find.text('How It Works'), findsOneWidget);

      // Check for the "Start Personalising" button
      expect(find.widgetWithText(ElevatedButton, 'Start Personalising'),
          findsOneWidget);

      // Check for Header Icons
      expect(
          find.descendant(
              of: find.byType(HeaderSearchWidget),
              matching: find.byIcon(Icons.search)),
          findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should navigate to Personalise page when button is tapped',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const PrintsharkPage()));
      await tester.pump();

      // Find the button, scroll to it, and tap it
      final button = find.widgetWithText(ElevatedButton, 'Start Personalising');
      await tester.ensureVisible(button);
      await tester.pumpAndSettle();
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Verify navigation
      expect(mockObserver.pushed, isTrue);
      expect(mockObserver.pushedRoute, '/personalise');
      expect(find.text('Personalise Page'), findsOneWidget);
    });

    testWidgets('should display footer on Printshark page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const PrintsharkPage()));
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
