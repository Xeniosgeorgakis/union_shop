import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

void main() {
  group('Product Page Tests', () {
    const productArgs = {
      'title': 'Test Product',
      'price': '£99.99',
      'originalPrice': '£120.00',
      'imageUrl': 'assets/images/bearbricklogo.png',
      'description': 'This is a test description.',
    };

    Widget createTestableWidget(Widget child) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: MaterialApp(
          home: child,
          onGenerateRoute: (settings) {
            if (settings.name == '/product') {
              return MaterialPageRoute(
                settings: const RouteSettings(
                  name: '/product',
                  arguments: productArgs,
                ),
                builder: (_) => const ProductPage(),
              );
            }
            return null;
          },
        ),
      );
    }

    testWidgets('should display product page with basic elements',
        (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/product',
                      arguments: productArgs),
                  child: const Text('Go to Product'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go to Product'));
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text(
            '🔥 Massive BE@RBRICK Sale Live Now — Limited Editions, Exclusive Drops, and Up to 20% Off While Stock Lasts!'),
        findsOneWidget,
      );
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£99.99'), findsOneWidget);
      expect(find.text('£120.00'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('This is a test description.'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/product',
                      arguments: productArgs),
                  child: const Text('Go to Product'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Go to Product'));
      await tester.pumpAndSettle();

      // Check that header icons are present
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
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/product',
                      arguments: productArgs),
                  child: const Text('Go to Product'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Go to Product'));
      await tester.pumpAndSettle();

      await tester.drag(
          find.byWidgetPredicate((widget) =>
              widget is SingleChildScrollView &&
              widget.scrollDirection == Axis.vertical),
          const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.text('OPENING HOURS'), findsOneWidget);
      expect(find.text('INFORMATION'), findsOneWidget);
      expect(find.text('HELP'), findsOneWidget);
      // Check for search icon in footer
      expect(
          find.descendant(
              of: find.byType(Footer), matching: find.byIcon(Icons.search)),
          findsOneWidget);
    });
  });
}
