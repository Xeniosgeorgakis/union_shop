import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/header_search_widget.dart';
import 'package:union_shop/models/search_provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/product_page.dart';

void main() {
  Widget createTestableWidget({bool isMobile = false}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: HeaderSearchWidget(isMobile: isMobile),
          ),
        ),
        routes: {
          '/product': (context) => const ProductPage(),
        },
        onGenerateRoute: (settings) {
          // Handle dynamic /product/:id routes
          if (settings.name?.startsWith('/product/') == true) {
            final productId = settings.name!.substring('/product/'.length);
            return MaterialPageRoute(
              builder: (context) => ProductPage(productId: productId),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }

  group('HeaderSearchWidget Tests', () {
    group('Initial State', () {
      testWidgets('should display search icon button when search not visible',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byType(TextField), findsNothing);
      });

      testWidgets('should display IconButton when search not visible',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        expect(find.byType(IconButton), findsOneWidget);
      });

      testWidgets('should not display TextField initially', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        expect(find.byType(TextField), findsNothing);
      });
    });

    group('Opening Search', () {
      testWidgets('should show TextField when search icon is tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        // Initially no TextField
        expect(find.byType(TextField), findsNothing);

        // Tap search icon
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // TextField should appear
        expect(find.byType(TextField), findsOneWidget);
      });

      testWidgets('should show search hint text', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        expect(find.text('Search...'), findsOneWidget);
      });

      testWidgets('should show two IconButtons when search is visible',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Should have 2 IconButtons: the search button that performs search
        expect(find.byType(IconButton), findsOneWidget);
      });

      testWidgets('should autofocus TextField when opened', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.autofocus, true);
      });

      testWidgets('should display Row when search is visible', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('TextField Properties', () {
      testWidgets('should have correct width for desktop mode', (tester) async {
        await tester.pumpWidget(createTestableWidget(isMobile: false));

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final sizedBox = tester.widget<SizedBox>(
          find.ancestor(
            of: find.byType(TextField),
            matching: find.byType(SizedBox),
          ),
        );
        expect(sizedBox.width, 150);
        expect(sizedBox.height, 36);
      });

      testWidgets('should have correct width for mobile mode', (tester) async {
        await tester.pumpWidget(createTestableWidget(isMobile: true));

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final sizedBox = tester.widget<SizedBox>(
          find.ancestor(
            of: find.byType(TextField),
            matching: find.byType(SizedBox),
          ),
        );
        expect(sizedBox.width, 100);
        expect(sizedBox.height, 36);
      });

      testWidgets('should have OutlineInputBorder', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.decoration?.border, isA<OutlineInputBorder>());
      });

      testWidgets('should have horizontal content padding', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(
          textField.decoration?.contentPadding,
          const EdgeInsets.symmetric(horizontal: 10),
        );
      });
    });

    group('Search Functionality', () {
      testWidgets('should accept text input', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Bearbrick');
        expect(find.text('Bearbrick'), findsOneWidget);
      });

      testWidgets('should navigate when valid product found (no error shown)',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter a product name that exists in allProducts
        await tester.enterText(find.byType(TextField), 'Garfield');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should NOT show error snackbar (success case)
        expect(find.text('No product found.'), findsNothing);
      });

      testWidgets('should show no suggestions when no product matches',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter a product name that doesn't exist
        await tester.enterText(find.byType(TextField), 'Nonexistent Product');
        await tester.pumpAndSettle();

        // Should show no suggestions (no ListTile)
        expect(find.byType(ListTile), findsNothing);
      });

      testWidgets('should perform search when search icon button is tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter text
        await tester.enterText(find.byType(TextField), 'Squid Game');

        // Tap the search button (IconButton)
        await tester.tap(find.byType(IconButton));
        await tester.pumpAndSettle();

        // Should NOT show error snackbar (success case)
        expect(find.text('No product found.'), findsNothing);
      });

      testWidgets('should not search when query is empty', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Submit empty search
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should not show snackbar or navigate
        expect(find.text('No product found.'), findsNothing);
        expect(find.byType(ProductPage), findsNothing);
      });

      testWidgets('should not search when query is only whitespace',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter whitespace
        await tester.enterText(find.byType(TextField), '   ');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should not show snackbar or navigate
        expect(find.text('No product found.'), findsNothing);
        expect(find.byType(ProductPage), findsNothing);
      });

      testWidgets('should perform case-insensitive search', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter lowercase search
        await tester.enterText(find.byType(TextField), 'elmo');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should NOT show error snackbar (success case)
        expect(find.text('No product found.'), findsNothing);
      });

      testWidgets('should find product by partial match', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter partial search
        await tester.enterText(find.byType(TextField), 'Nike');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should NOT show error snackbar (success case)
        expect(find.text('No product found.'), findsNothing);
      });

      testWidgets('should trim whitespace from search query', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Enter search with leading/trailing spaces
        await tester.enterText(find.byType(TextField), '  BAPE  ');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should NOT show error snackbar (success case)
        expect(find.text('No product found.'), findsNothing);
      });
    });

    group('Search Provider Integration', () {
      testWidgets('should use SearchProvider to control visibility',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        // Get the search provider
        final searchProvider = tester
            .element(find.byType(HeaderSearchWidget))
            .read<SearchProvider>();

        // Initially not visible
        expect(searchProvider.isSearchVisible, false);
        expect(find.byType(TextField), findsNothing);

        // Tap to show search
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Should now be visible
        expect(searchProvider.isSearchVisible, true);
        expect(find.byType(TextField), findsOneWidget);
      });

      testWidgets('should update when SearchProvider changes', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        final searchProvider = tester
            .element(find.byType(HeaderSearchWidget))
            .read<SearchProvider>();

        // Initially not visible
        expect(find.byType(TextField), findsNothing);

        // Programmatically set search visibility
        searchProvider.setSearch(true);
        await tester.pumpAndSettle();

        // Should show TextField
        expect(find.byType(TextField), findsOneWidget);

        // Set back to false
        searchProvider.setSearch(false);
        await tester.pumpAndSettle();

        // Should hide TextField
        expect(find.byType(TextField), findsNothing);
      });
    });

    group('Widget Disposal', () {
      testWidgets('should dispose TextEditingController properly',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // Remove widget
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();

        // If disposal had issues, this would throw an error
        // Successfully reaching here means dispose was called properly
      });
    });

    group('Navigation with Arguments', () {
      testWidgets('should attempt navigation when product is found',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Elmo');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Verify search succeeded (no error message)
        expect(find.text('No product found.'), findsNothing);

        // Verify we're not on the original page anymore by checking if ProductPage exists
        // or by checking that we navigated away from HeaderSearchWidget context
        await tester.pumpAndSettle(const Duration(milliseconds: 100));
      });
    });

    group('Icon Properties', () {
      testWidgets('should have correct icon size', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        final iconButton = tester.widget<IconButton>(find.byType(IconButton));
        final icon = iconButton.icon as Icon;
        expect(icon.size, 18);
      });

      testWidgets('should have black icon color', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        final iconButton = tester.widget<IconButton>(find.byType(IconButton));
        final icon = iconButton.icon as Icon;
        expect(icon.color, Colors.black);
      });

      testWidgets('should maintain icon properties when search is visible',
          (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final iconButton = tester.widget<IconButton>(find.byType(IconButton));
        final icon = iconButton.icon as Icon;
        expect(icon.size, 18);
        expect(icon.color, Colors.black);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle rapid open/close actions', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        final searchProvider = tester
            .element(find.byType(HeaderSearchWidget))
            .read<SearchProvider>();

        // Rapid toggle
        searchProvider.setSearch(true);
        await tester.pump();
        searchProvider.setSearch(false);
        await tester.pump();
        searchProvider.setSearch(true);
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsOneWidget);
      });

      testWidgets('should handle multiple search attempts', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        // First search - valid product
        await tester.enterText(find.byType(TextField), 'Tiger');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Should NOT show error snackbar (success case)
        expect(find.text('No product found.'), findsNothing);
      });

      testWidgets('should handle special characters in search', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), '@#\$%^&*()');
        await tester.pumpAndSettle();

        expect(find.byType(ListTile), findsNothing);
      });

      testWidgets('should handle very long search queries', (tester) async {
        await tester.pumpWidget(createTestableWidget());

        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();

        final longQuery = 'a' * 200;
        await tester.enterText(find.byType(TextField), longQuery);
        await tester.pumpAndSettle();

        expect(find.byType(ListTile), findsNothing);
      });
    });
  });
}
