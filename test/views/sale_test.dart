import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

// A mock navigator observer to verify navigation events.
class MockNavigatorObserver extends NavigatorObserver {
  bool pushed = false;
  String? pushedRoute;
  Object? pushedArguments;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed = true;
    pushedRoute = route.settings.name;
    pushedArguments = route.settings.arguments;
  }

  void reset() {
    pushed = false;
    pushedRoute = null;
    pushedArguments = null;
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
          '/product': (context) => const Scaffold(body: Text('Product Page')),
        },
        navigatorObservers: [mockObserver],
      ),
    );
  }

  group('SalePage Tests', () {
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('should display Sale page with all elements', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SalePage()));
      await tester.pump();

      // Check for Header text
      expect(find.text('🔥 Massive BE@RBRICK Sale Live Now'), findsOneWidget);

      // Check for page banner
      expect(find.text('SALE ITEMS'), findsOneWidget);
      expect(find.text('Grab these exclusive deals before they are gone!'),
          findsOneWidget);

      // Check for sort dropdown
      expect(find.text('Sort by:'), findsOneWidget);
      expect(find.widgetWithText(DropdownButton<String>, 'Default'),
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

    testWidgets('should sort products by price low to high', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SalePage()));
      await tester.pump();

      // Tap the dropdown
      await tester.tap(find.text('Default'));
      await tester.pumpAndSettle();

      // Select 'Price: Low to High'
      await tester.tap(find.text('Price: Low to High').last);
      await tester.pumpAndSettle();

      // Get all SaleProductCard widgets
      final cards =
          tester.widgetList<SaleProductCard>(find.byType(SaleProductCard));
      final prices =
          cards.map((c) => double.parse(c.price.replaceAll('£', ''))).toList();

      // Verify the prices are sorted in ascending order
      for (int i = 0; i < prices.length - 1; i++) {
        expect(prices[i] <= prices[i + 1], isTrue);
      }
    });

    testWidgets('should sort products by price high to low', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SalePage()));
      await tester.pump();

      // Tap the dropdown
      await tester.tap(find.text('Default'));
      await tester.pumpAndSettle();

      // Select 'Price: High to Low'
      await tester.tap(find.text('Price: High to Low').last);
      await tester.pumpAndSettle();

      // Get all SaleProductCard widgets
      final cards =
          tester.widgetList<SaleProductCard>(find.byType(SaleProductCard));
      final prices =
          cards.map((c) => double.parse(c.price.replaceAll('£', ''))).toList();

      // Verify the prices are sorted in descending order
      for (int i = 0; i < prices.length - 1; i++) {
        expect(prices[i] >= prices[i + 1], isTrue);
      }
    });

    testWidgets('should navigate to product page on tap', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SalePage()));
      await tester.pump();

      // Find the first product card and tap it
      final firstCard = find.byType(SaleProductCard).first;
      final cardWidget = tester.widget<SaleProductCard>(firstCard);

      await tester.ensureVisible(firstCard);
      await tester.tap(firstCard);
      await tester.pumpAndSettle();

      // Verify navigation
      expect(mockObserver.pushed, isTrue);
      expect(mockObserver.pushedRoute, '/product');

      // Verify arguments
      final args = mockObserver.pushedArguments as Map<String, dynamic>;
      expect(args['title'], cardWidget.title);
      expect(args['price'], cardWidget.price);
    });

    testWidgets('should display footer on Sale page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const SalePage()));
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
