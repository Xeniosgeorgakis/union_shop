import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
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
  final mockObserver = MockNavigatorObserver();

  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: child,
        routes: {
          '/collection/1': (context) =>
              const Scaffold(body: Text('Collection One Page')),
          '/collection/2': (context) =>
              const Scaffold(body: Text('Collection Two Page')),
        },
        navigatorObservers: [mockObserver],
      ),
    );
  }

  group('CollectionsPage Tests', () {
    setUp(() {
      mockObserver.reset();
    });

    testWidgets('should display Collections page with all elements',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const CollectionsPage()));
      await tester.pump();

      // Check for Header text
      expect(find.text('🔥 Massive BE@RBRICK Sale Live Now'), findsOneWidget);

      // Check for page banner
      expect(find.text('OUR COLLECTIONS'), findsOneWidget);
      expect(find.text('Explore our curated Bearbrick collections.'),
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

    testWidgets('should display all collection cards', (tester) async {
      await tester.pumpWidget(createTestableWidget(const CollectionsPage()));
      await tester.pump();

      // Check for the three collection cards by title
      expect(find.text('1000% BE@RBRICKS'), findsOneWidget);
      expect(find.text('400% AND 100% BE@RBRICKS'), findsOneWidget);
      expect(find.text('Bearbrick Merch'), findsOneWidget);

      // Verify there are 3 CollectionCard widgets
      expect(find.byType(CollectionCard), findsNWidgets(3));
    });

    testWidgets('should navigate when collection cards are tapped',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const CollectionsPage()));
      await tester.pump();

      // Tap the first collection card and verify navigation
      await tester.tap(find.text('1000% BE@RBRICKS'));
      await tester.pumpAndSettle();
      expect(mockObserver.pushed, isTrue);
      expect(mockObserver.pushedRoute, '/collection/1');
      expect(find.text('Collection One Page'), findsOneWidget);

      // Go back and reset observer
      Navigator.of(tester.element(find.text('Collection One Page'))).pop();
      await tester.pumpAndSettle();
      mockObserver.reset();

      // Tap the second collection card and verify navigation
      await tester.tap(find.text('400% AND 100% BE@RBRICKS'));
      await tester.pumpAndSettle();
      expect(mockObserver.pushed, isTrue);
      expect(mockObserver.pushedRoute, '/collection/2');
      expect(find.text('Collection Two Page'), findsOneWidget);
    });

   

    testWidgets('should display footer on Collections page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const CollectionsPage()));
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
