import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

void main() {
  final testProduct = Product(
    title: 'Test Cart Product',
    price: '£100.00',
    imageUrl: 'assets/images/bearbricklogo.png',
    description: 'A product for testing the cart.',
  );

  Widget createTestableWidget(Widget child, {CartProvider? cartProvider}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cartProvider ?? CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('CartPage Tests', () {
    testWidgets('should display empty cart message when cart is empty',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const CartPage()));
      await tester.pump();

      // Check for empty cart UI
      expect(find.text('Your Cart is Empty'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
      expect(
          find.text('Looks like you haven\'t added anything to your cart yet.'),
          findsOneWidget);

      // Ensure order summary is not visible
      expect(find.text('Order Summary'), findsNothing);
    });

    testWidgets('should display items and order summary when cart has items',
        (tester) async {
      final cart = CartProvider();
      cart.addItem(testProduct, 1, 'Personal Use');

      await tester.pumpWidget(
          createTestableWidget(const CartPage(), cartProvider: cart));
      await tester.pump();

      // Check for cart item
      expect(find.text('Test Cart Product'), findsOneWidget);
      expect(find.text('£100.00'),
          findsNWidgets(3)); // Item price, subtotal, and total

      // Check for order summary
      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'PROCEED TO CHECKOUT'),
          findsOneWidget);
    });

    testWidgets('should increment and decrement item quantity', (tester) async {
      final cart = CartProvider();
      cart.addItem(testProduct, 1, 'Personal Use');

      await tester.pumpWidget(
          createTestableWidget(const CartPage(), cartProvider: cart));
      await tester.pump();

      final cartItemFinder = find.byType(CartListItem);

      // Check initial state
      expect(find.descendant(of: cartItemFinder, matching: find.text('1')),
          findsOneWidget);
      expect(find.text('£100.00'),
          findsNWidgets(3)); // Item price, subtotal, and total

      // Increment quantity
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Check updated state
      expect(find.descendant(of: cartItemFinder, matching: find.text('2')),
          findsOneWidget);
      expect(find.text('£200.00'),
          findsNWidgets(3)); // Item price, subtotal, and total

      // Decrement quantity
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Check final state
      expect(find.descendant(of: cartItemFinder, matching: find.text('1')),
          findsOneWidget);
      expect(find.text('£100.00'), findsNWidgets(3));
    });

    testWidgets('should remove item from cart when delete is tapped',
        (tester) async {
      final cart = CartProvider();
      cart.addItem(testProduct, 1, 'Personal Use');

      await tester.pumpWidget(
          createTestableWidget(const CartPage(), cartProvider: cart));
      await tester.pump();

      // Ensure item is in the cart
      expect(find.text('Test Cart Product'), findsOneWidget);

      // Tap delete button
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pump();

      // Verify cart is now empty
      expect(find.text('Your Cart is Empty'), findsOneWidget);
      expect(find.text('Test Cart Product'), findsNothing);
    });

    testWidgets('should display header and footer', (tester) async {
      await tester.pumpWidget(createTestableWidget(const CartPage()));
      await tester.pump();

      // Check for Header
      expect(find.text('🔥 Massive BE@RBRICK Sale Live Now'), findsOneWidget);
      expect(find.byType(HeaderSearchWidget), findsOneWidget);

      // Check for Footer
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.byType(Footer), findsOneWidget);
      expect(find.text('OPENING HOURS'), findsOneWidget);
    });
  });
}
