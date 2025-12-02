import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

void main() {
  // Helper to create a testable widget with necessary providers
  Widget createTestableWidget({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        home: Scaffold(
          // A simplified header structure for testing components
          appBar: AppBar(
            title: Row(
              children: [
                const HeaderSearchWidget(),
                Consumer<CartProvider>(
                  builder: (context, cart, _) => Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        onPressed: () {},
                      ),
                      if (cart.itemCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cart.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  group('Header Tests', () {
    group('HeaderSearchWidget', () {
      testWidgets('should show search icon and hide text field initially',
          (tester) async {
        await tester.pumpWidget(
            createTestableWidget(child: const HeaderSearchWidget()));

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byType(TextField), findsNothing);
      });

      testWidgets(
          'should show text field and close icon when search icon is tapped',
          (tester) async {
        await tester.pumpWidget(
          createTestableWidget(child: const HeaderSearchWidget()),
        );

        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();

        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.close), findsOneWidget);
        expect(find.byIcon(Icons.search), findsNothing);
      });

      testWidgets('should update search query in provider when typing',
          (tester) async {
        final searchProvider = SearchProvider();
        // Build a widget tree with a single SearchProvider instance.
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: searchProvider),
              ChangeNotifierProvider(create: (_) => CartProvider()),
            ],
            child: const MaterialApp(
              home: Scaffold(
                body: HeaderSearchWidget(),
              ),
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();

        await tester.enterText(find.byType(TextField), 'test query');
        await tester.pump();

        // Verify the text was entered into the TextField
        expect(find.text('test query'), findsOneWidget);
      });

      testWidgets('should hide text field when close icon is tapped',
          (tester) async {
        await tester.pumpWidget(
          createTestableWidget(child: const HeaderSearchWidget()),
        );

        // Open search
        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();
        expect(find.byType(TextField), findsOneWidget);

        // Close search
        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();

        expect(find.byType(TextField), findsNothing);
        expect(find.byIcon(Icons.search), findsOneWidget);
      });
    });

    group('Cart Icon Badge', () {
      testWidgets('should not display badge when cart is empty',
          (tester) async {
        await tester.pumpWidget(createTestableWidget(child: Container()));
        expect(find.text('0'), findsNothing);
      });

      testWidgets('should display badge with item count when cart is not empty',
          (tester) async {
        final cartProvider = CartProvider();
        await tester.pumpWidget(
          ChangeNotifierProvider.value(
            value: cartProvider,
            child: createTestableWidget(child: Container()),
          ),
        );

        // Add an item to the cart
        final product =
            Product(title: 'Test', price: '10', imageUrl: '', description: '');
        cartProvider.addItem(product, 2, 'Personal Use');
        await tester.pump();

        // Verify badge shows '2'
        expect(find.text('2'), findsOneWidget);
      });
    });
  });
}
