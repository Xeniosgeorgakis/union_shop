import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/personalise_page.dart';

void main() {
  Widget createTestableWidget(Widget child, {CartProvider? cartProvider}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cartProvider ?? CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: child,
        routes: {
          '/cart': (context) => const Scaffold(body: Text('Cart Page')),
        },
      ),
    );
  }

  group('PersonalisePage Tests', () {
    testWidgets('should display Personalise page with initial elements',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const PersonalisePage()));
      await tester.pump();

      // Check for titles
      expect(find.text('Personalise Your T-Shirt'), findsOneWidget);
      expect(find.text('Customisation'), findsOneWidget);

      // Check for initial preview text
      expect(find.text('Preview Area'), findsOneWidget);

      // Check for dropdowns with default values
      expect(
          find.widgetWithText(DropdownButtonFormField<LineOption>, 'One Line'),
          findsOneWidget);
      expect(find.widgetWithText(DropdownButtonFormField<String>, 'Arial'),
          findsOneWidget);

      // Check for initial text field and quantity
      expect(find.widgetWithText(TextFormField, 'Enter your text (Line 1)'),
          findsOneWidget);
      expect(find.text('1'), findsOneWidget);

      // Check for button
      expect(
          find.widgetWithText(ElevatedButton, 'ADD TO CART'), findsOneWidget);
    });

    testWidgets('should show/hide text fields based on line option',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const PersonalisePage()));
      await tester.pump();

      // Initially, one line is visible
      expect(find.byType(TextFormField), findsOneWidget);

      // Change to two lines
      final oneLineDropdown = find.text('One Line');
      await tester.ensureVisible(oneLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(oneLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines').last);
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(2));

      // Change to three lines
      final twoLineDropdown = find.text('Two Lines');
      await tester.ensureVisible(twoLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(twoLineDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three Lines').last);
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('should update preview text when typing', (tester) async {
      await tester.pumpWidget(createTestableWidget(const PersonalisePage()));
      await tester.pump();

      // Enter text
      final textField =
          find.widgetWithText(TextFormField, 'Enter your text (Line 1)');
      await tester.ensureVisible(textField);
      await tester.pumpAndSettle();
      await tester.enterText(textField, 'Hello World');
      await tester.pump();

      // Verify preview text is updated by finding a Text widget that is not inside a form field.
      final previewTextFinder = find.byWidgetPredicate((widget) =>
          widget is Text &&
          widget.data == 'Hello World' &&
          find.ancestor(of: find.byWidget(widget), matching: find.byType(TextFormField)).evaluate().isEmpty);
          
      expect(previewTextFinder, findsOneWidget);
      expect(find.text('Preview Area'), findsNothing);
    });

    testWidgets('should increment and decrement quantity', (tester) async {
      await tester.pumpWidget(createTestableWidget(const PersonalisePage()));
      await tester.pump();

      final quantityFinder = find.text('Quantity');
      await tester.ensureVisible(quantityFinder);
      await tester.pumpAndSettle();

      // Check initial quantity
      expect(find.text('1'), findsOneWidget);

      // Increment
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // Decrement
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // Ensure it doesn't go below 1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should show error snackbar when adding to cart with no text',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const PersonalisePage()));
      await tester.pump();

      // Tap add to cart without text
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'ADD TO CART');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();
      await tester.tap(addToCartButton);
      await tester.pump();

      // Verify error snackbar
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
          find.text('Please enter some text to personalise.'), findsOneWidget);
    });

    testWidgets('should add item to cart and show confirmation snackbar',
        (tester) async {
      final cartProvider = CartProvider();
      await tester.pumpWidget(createTestableWidget(const PersonalisePage(),
          cartProvider: cartProvider));
      await tester.pump();

      // Enter text
      final textField =
          find.widgetWithText(TextFormField, 'Enter your text (Line 1)');
      await tester.ensureVisible(textField);
      await tester.pumpAndSettle();
      await tester.enterText(textField, 'Custom T-Shirt');
      await tester.pump();

      // Tap add to cart
      final addToCartButton =
          find.widgetWithText(ElevatedButton, 'ADD TO CART');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();
      await tester.tap(addToCartButton);
      await tester.pump();

      // Verify confirmation snackbar
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Personalised T-Shirt has been added to your cart.'),
          findsOneWidget);

      // Verify item was added to cart
      expect(cartProvider.itemCount, 1);
      expect(cartProvider.items.first.product.title, 'Personalised T-Shirt');
      expect(cartProvider.items.first.product.description,
          contains('Custom Text: "Custom T-Shirt"'));
    });
  });
}
