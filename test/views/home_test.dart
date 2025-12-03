import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

      // Check that basic UI elements are present

      expect(
        find.text('🔥 Massive BE@RBRICK Sale Live Now'),
        findsOneWidget,
      );

      expect(find.text('OVER 20% OFF!'), findsOneWidget);

      expect(find.text('OVER 20% OFF ON SELECTED PRODUCTS!'), findsOneWidget);
      expect(find.text('BROWSE OUR COLLECTIONS'), findsOneWidget);

      expect(find.text('VIEW ALL SALES'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

      // Check that product cards are displayed
      // The home page displays allProducts[0] through allProducts[3]
      // which are: collection1[0-2] (KAWS, Squid Game, PAC-MAN) and collection2[0] (Garfield)

      expect(
          find.text('KAWS Companion Bearbrick 1000% (Blue)'), findsOneWidget);
      expect(find.text('1000% Bearbrick - Squid Game (Red)'), findsOneWidget);
      expect(find.text('Bearbrick PAC-MAN 1000% (Black)'), findsOneWidget);
      expect(find.text('Bearbrick Garfield 100% & 400% Set (Gold)'),
          findsOneWidget);

      // Check prices are displayed

      expect(find.text('£200.00'), findsWidgets); // KAWS and PAC-MAN
      expect(find.text('£160.00'), findsOneWidget); // Squid Game
      expect(find.text('£112.00'), findsOneWidget); // Garfield
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

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
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

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

    testWidgets('should navigate to sale page when "VIEW ALL SALES" is tapped',
        (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

      // Find the "VIEW ALL SALES" button
      final viewAllSalesButton =
          find.widgetWithText(ElevatedButton, 'VIEW ALL SALES');

      // Scroll to the button and tap it
      await tester.ensureVisible(viewAllSalesButton);
      await tester.pumpAndSettle();
      await tester.tap(viewAllSalesButton);
      await tester.pumpAndSettle();

      // Verify navigation to the SalePage
      expect(find.text('SALE ITEMS'), findsOneWidget);
    });

    testWidgets(
        'should navigate to collections page when "BROWSE OUR COLLECTIONS" is tapped',
        (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

      // Find the "BROWSE OUR COLLECTIONS" button
      final browseButton =
          find.widgetWithText(ElevatedButton, 'BROWSE OUR COLLECTIONS');

      // Tap the button
      await tester.tap(browseButton);
      await tester.pumpAndSettle();

      // Verify navigation to the CollectionsPage
      expect(find.text('OUR COLLECTIONS'), findsOneWidget);
    });

    testWidgets(
        'should navigate to personalise page when Print Shack image is tapped',
        (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CartProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          child: const UnionShopApp(),
        ),
      );
      await tester.pump();

      // Find the Print Shack image
      final printShackImage = find.byWidgetPredicate((widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName == 'assets/images/tshirt.png');

      // Scroll to the image and tap it
      await tester.ensureVisible(printShackImage);
      await tester.pumpAndSettle();
      await tester.tap(printShackImage);
      await tester.pumpAndSettle();

      // Verify navigation to the PersonalisePage
      expect(find.text('Personalise Your T-Shirt'), findsOneWidget);
    });
  });
}
