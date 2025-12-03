import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  setUpAll(() {
    // Set a larger screen size for tests to avoid layout overflow
    TestWidgetsFlutterBinding.ensureInitialized();
    const Size testScreenSize = Size(1200, 800);
    TestWidgetsFlutterBinding.instance.window.physicalSizeTestValue = testScreenSize;
    TestWidgetsFlutterBinding.instance.window.devicePixelRatioTestValue = 1.0;
  });

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

  group('CartPage Tests', () {
    testWidgets('should display cart page title', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TestCartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Your Cart is Empty'), findsOneWidget);
    });

    testWidgets('should display empty cart message', (tester) async {
      await tester.pumpWidget(createTestableWidget(const TestCartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Your Cart is Empty'), findsOneWidget);
    });

    testWidgets('should display cart items when items exist', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(
        Product(
          title: 'Test Product',
          price: '25.00',
          originalPrice: null,
          imageUrl: 'test.jpg',
          description: 'Test description',
        ),
        1,
        'Personal Use',
      );

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.textContaining('£25.00'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display quantity controls', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('1'), findsAtLeastNWidgets(1));
    });

    testWidgets('should increment quantity when add button tapped', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text('2'), findsAtLeastNWidgets(1));
    });

    testWidgets('should decrement quantity when remove button tapped', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsAtLeastNWidgets(1));

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      expect(find.text('1'), findsAtLeastNWidgets(1));
    });

    testWidgets('should remove item when quantity reaches zero', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsNothing);
      expect(find.text('Your Cart is Empty'), findsOneWidget);
    });

    testWidgets('should display subtotal', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('£10.00'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display checkout button', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('PROCEED TO CHECKOUT'), findsOneWidget);
    });

    testWidgets('should show processing dialog during checkout', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('PROCEED TO CHECKOUT'));
      await tester.pump();

      expect(find.text('Transaction in progress...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsAtLeastNWidgets(1));
      
      // Wait for the 3-second timer to complete
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('should clear cart after successful checkout', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(Product(
        title: 'Test Product',
        price: '£10.00',
        originalPrice: '£15.00',
        imageUrl: 'test.jpg',
        description: 'Test description',
      ), 1, 'Personal Use');

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('PROCEED TO CHECKOUT'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Tap OK on success dialog
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Your Cart is Empty'), findsOneWidget);
      expect(find.text('Test Product'), findsNothing);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('OPENING HOURS'), findsOneWidget);
    });

    testWidgets('should display app drawer', (tester) async {
      await tester.pumpWidget(createTestableWidget(const CartPage()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should handle multiple items in cart', (tester) async {
      final cartProvider = CartProvider();
      cartProvider.addItem(
        Product(
          title: 'Product 1',
          price: '25.00',
          originalPrice: null,
          imageUrl: 'test1.jpg',
          description: 'Test description 1',
        ),
        1,
        'Personal Use',
      );
      cartProvider.addItem(
        Product(
          title: 'Product 2',
          price: '5.00',
          originalPrice: null,
          imageUrl: 'test2.jpg',
          description: 'Test description 2',
        ),
        1,
        'Personal Use',
      );

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: cartProvider),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: const MaterialApp(
          home: TestCartPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 2'), findsOneWidget);
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('£30.00'), findsAtLeastNWidgets(1));
    });
  });
}

class MockAppHeader extends StatelessWidget implements PreferredSizeWidget {
  const MockAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}

class TestCartPage extends StatelessWidget {
  const TestCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MockAppHeader(),
      body: CartPage(),
    );
  }
}