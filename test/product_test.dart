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

    Widget createTestableWidget(Widget child,
        {Map<String, dynamic>? arguments}) {
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
                settings: RouteSettings(
                  name: '/product',
                  arguments: arguments ?? productArgs,
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
        find.text('🔥 Massive BE@RBRICK Sale Live Now'),
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

    testWidgets('should increment and decrement quantity', (tester) async {
      await tester.pumpWidget(createTestableWidget(const ProductPage()));

      // Check initial quantity
      expect(find.text('1'), findsOneWidget);

      // Find and scroll to the add icon
      final addIcon = find.byIcon(Icons.add);
      await tester.ensureVisible(addIcon);
      await tester.pumpAndSettle();

      // Increment quantity
      await tester.tap(addIcon);
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // Find and scroll to the remove icon
      final removeIcon = find.byIcon(Icons.remove);
      await tester.ensureVisible(removeIcon);
      await tester.pumpAndSettle();

      // Decrement quantity
      await tester.tap(removeIcon);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // Ensure quantity does not go below 1
      await tester.tap(removeIcon);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should change purchase type', (tester) async {
      await tester.pumpWidget(createTestableWidget(const ProductPage()));

      // Find the dropdown finder.
      final dropdownFinder = find.text('Personal Use');

      // Ensure the dropdown is visible by scrolling to it.
      await tester.ensureVisible(dropdownFinder);
      await tester.pumpAndSettle();

      // Check initial purchase type
      expect(dropdownFinder, findsOneWidget);

      // Change purchase type to 'Gift'
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle(); // Wait for dropdown animation

      // Find and tap the 'Gift' option in the opened dropdown.
      await tester.tap(find.text('Gift').last);
      await tester.pumpAndSettle();

      // Check if purchase type is updated
      expect(find.text('Gift'), findsOneWidget);
    });

    testWidgets('should add item to cart with correct purchase type',
        (tester) async {
      late CartProvider cartProvider;
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (context) {
              cartProvider = Provider.of<CartProvider>(context, listen: false);
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/product',
                        arguments: productArgs),
                    child: const Text('Go to Product'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Go to product page
      await tester.tap(find.text('Go to Product'));
      await tester.pumpAndSettle();

      // Change purchase type to 'Gift'
      final dropdownFinder = find.text('Personal Use');
      await tester.ensureVisible(dropdownFinder);
      await tester.pumpAndSettle();
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gift').last);
      await tester.pumpAndSettle();

      // Add item to cart
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'ADD TO CART');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();
      await tester.tap(addToCartButton);
      await tester.pump();

      // Verify item was added to cart with the correct purchase type
      expect(cartProvider.itemCount, 1);
      expect(cartProvider.items.first.purchaseType, 'Gift');
    });

    testWidgets('should add item to cart and show snackbar', (tester) async {
      late CartProvider cartProvider;
      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (context) {
              cartProvider = Provider.of<CartProvider>(context, listen: false);
              // Navigate to the product page with arguments to properly initialize it.
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/product',
                        arguments: productArgs),
                    child: const Text('Go to Product'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      // Go to product page
      await tester.tap(find.text('Go to Product'));
      await tester.pumpAndSettle();

      // Check that cart is initially empty
      expect(cartProvider.itemCount, 0);

      // Scroll the "ADD TO CART" button into view and tap it
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'ADD TO CART');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();
      await tester.tap(addToCartButton);
      await tester.pump(); // Let the SnackBar appear

      // Verify SnackBar is shown
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Test Product has been added to your cart.'),
          findsOneWidget);

      // Verify item was added to cart
      expect(cartProvider.itemCount, 1);
      expect(cartProvider.items.first.product.title, 'Test Product');
    });

    testWidgets('should select different product image', (tester) async {
      const garfieldArgs = {
        'title': 'Bearbrick Garfield 100% & 400% Set (Gold)',
        'price': '£112.00',
        'originalPrice': '£140.00',
        'imageUrl':
            'https://images.stockx.com/images/Bearbrick-Garfield-100-400-Set-Gold-Chrome-Ver-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
        'description': 'A Garfield Bearbrick.',
      };

      await tester.pumpWidget(
        createTestableWidget(
          Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/product',
                      arguments: garfieldArgs),
                  child: const Text('Go to Product'),
                ),
              ),
            ),
          ),
          arguments: garfieldArgs,
        ),
      );

      await tester.tap(find.text('Go to Product'));
      await tester.pumpAndSettle();

      // Find thumbnails by looking for the GestureDetector wrapping the thumbnail Container.
      final thumbnailGestureDetectors = find.byWidgetPredicate((widget) {
        if (widget is! GestureDetector) return false;
        final container = widget.child;
        if (container is! Container) return false;

        // Check for properties specific to the thumbnail containers
        return container.margin == const EdgeInsets.only(right: 16);
      });

      expect(thumbnailGestureDetectors, findsNWidgets(2));

      // Tap the second thumbnail
      await tester.tap(thumbnailGestureDetectors.last);
      await tester.pump();

      // Verify the second thumbnail is now selected (has a black border)
      final secondThumbnailGestureDetector =
          tester.widget<GestureDetector>(thumbnailGestureDetectors.last);
      final secondThumbnailContainer =
          secondThumbnailGestureDetector.child as Container;
      final decoration = secondThumbnailContainer.decoration as BoxDecoration;
      expect(decoration.border, isA<Border>());
      final border = decoration.border as Border;
      expect(border.top.color, Colors.black);
      expect(border.top.width, 2);
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
