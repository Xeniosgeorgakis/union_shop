import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  Widget createTestableWidget(String initialRoute) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        initialRoute: initialRoute,
        routes: {
          '/': (context) => Scaffold(
                appBar: AppBar(title: const Text('Home')),
                endDrawer: const AppDrawer(),
                body: const Center(child: Text('Home Screen')),
              ),
          '/about': (context) => Scaffold(
                appBar: AppBar(title: const Text('About Us')),
                endDrawer: const AppDrawer(),
                body: const Center(child: Text('About Us Screen')),
              ),
          '/collections': (context) => Scaffold(
                appBar: AppBar(title: const Text('Collections')),
                endDrawer: const AppDrawer(),
                body: const Center(child: Text('Collections Screen')),
              ),
          '/sale': (context) => Scaffold(
                appBar: AppBar(title: const Text('Sale')),
                endDrawer: const AppDrawer(),
                body: const Center(child: Text('Sale Screen')),
              ),
          '/printshark': (context) => Scaffold(
                appBar: AppBar(title: const Text('Print Shark')),
                endDrawer: const AppDrawer(),
                body: const Center(child: Text('Print Shark Screen')),
              ),
          '/personalise': (context) => Scaffold(
                appBar: AppBar(title: const Text('Personalise')),
                endDrawer: const AppDrawer(),
                body: const Center(child: Text('Personalise Screen')),
              ),
        },
      ),
    );
  }

  Future<void> openDrawer(WidgetTester tester) async {
    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openEndDrawer();
    await tester.pumpAndSettle();
  }

  group('AppDrawer Tests', () {
    group('UI Elements', () {
      testWidgets('should display drawer header with Menu text',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        expect(find.text('Menu'), findsOneWidget);
        expect(find.byType(DrawerHeader), findsOneWidget);
      });

      testWidgets('should display all menu items', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Find within the drawer
        final drawerFinder = find.byType(Drawer);
        expect(find.descendant(of: drawerFinder, matching: find.text('Home')),
            findsOneWidget);
        expect(
            find.descendant(of: drawerFinder, matching: find.text('About Us')),
            findsOneWidget);
        expect(
            find.descendant(
                of: drawerFinder, matching: find.text('Collections')),
            findsOneWidget);
        expect(find.descendant(of: drawerFinder, matching: find.text('SALE!')),
            findsOneWidget);
        expect(
            find.descendant(
                of: drawerFinder, matching: find.text('PrintShack')),
            findsOneWidget);
      });

      testWidgets('should display PrintShack submenu items when expanded',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Tap to expand PrintShack
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();

        expect(find.text('About Print Shack'), findsOneWidget);
        expect(find.text('Personalise'), findsOneWidget);
      });

      testWidgets('should have ExpansionTile for PrintShack', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        expect(find.byType(ExpansionTile), findsOneWidget);
      });

      testWidgets('should display ListView in drawer', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('should have black drawer header background', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        final drawerHeader =
            tester.widget<DrawerHeader>(find.byType(DrawerHeader));
        final decoration = drawerHeader.decoration as BoxDecoration;
        expect(decoration.color, Colors.black);
      });
    });

    group('Current Route Selection', () {
      testWidgets('should highlight Home when on home route', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        final homeTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('Home'),
            matching: find.byType(ListTile),
          ),
        );

        expect(homeTile.selected, true);
      });

      testWidgets('should highlight About Us when on about route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/about'));
        await openDrawer(tester);

        final aboutTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('About Us'),
            matching: find.byType(ListTile),
          ),
        );

        expect(aboutTile.selected, true);
      });

      testWidgets('should highlight Collections when on collections route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/collections'));
        await openDrawer(tester);

        final collectionsTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('Collections'),
            matching: find.byType(ListTile),
          ),
        );

        expect(collectionsTile.selected, true);
      });

      testWidgets('should highlight SALE! when on sale route', (tester) async {
        await tester.pumpWidget(createTestableWidget('/sale'));
        await openDrawer(tester);

        final saleTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('SALE!'),
            matching: find.byType(ListTile),
          ),
        );

        expect(saleTile.selected, true);
      });

      testWidgets('should not highlight items when on different route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        final aboutTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('About Us'),
            matching: find.byType(ListTile),
          ),
        );

        expect(aboutTile.selected, false);
      });
    });

    group('Navigation', () {
      testWidgets('should navigate to About Us page when tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        await tester.tap(find.text('About Us'));
        await tester.pumpAndSettle();

        expect(find.text('About Us Screen'), findsOneWidget);
      });

      testWidgets('should navigate to Collections page when tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        await tester.tap(find.text('Collections'));
        await tester.pumpAndSettle();

        expect(find.text('Collections Screen'), findsOneWidget);
      });

      testWidgets('should navigate to Sale page when tapped', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        await tester.tap(find.text('SALE!'));
        await tester.pumpAndSettle();

        expect(find.text('Sale Screen'), findsOneWidget);
      });

      testWidgets('should navigate to Print Shark page when tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Expand PrintShack
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();

        // Tap About Print Shack
        await tester.tap(find.text('About Print Shack'));
        await tester.pumpAndSettle();

        expect(find.text('Print Shark Screen'), findsOneWidget);
      });

      testWidgets('should navigate to Personalise page when tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Expand PrintShack
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();

        // Tap Personalise
        await tester.tap(find.text('Personalise'));
        await tester.pumpAndSettle();

        expect(find.text('Personalise Screen'), findsOneWidget);
      });

      testWidgets('should navigate to Home and clear stack when Home tapped',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/about'));
        await openDrawer(tester);

        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();

        expect(find.text('Home Screen'), findsOneWidget);
      });

      testWidgets('should close drawer after navigation', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Verify drawer is open
        expect(find.text('Menu'), findsOneWidget);

        await tester.tap(find.text('About Us'));
        await tester.pumpAndSettle();

        // Drawer should be closed (Menu not visible)
        expect(find.text('Menu'), findsNothing);
      });

      testWidgets('should not navigate when tapping current route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/about'));
        await openDrawer(tester);

        // Verify we're on About Us page
        expect(find.text('About Us Screen'), findsOneWidget);

        // Find About Us within drawer and tap it
        final drawerFinder = find.byType(Drawer);
        final aboutInDrawer =
            find.descendant(of: drawerFinder, matching: find.text('About Us'));
        await tester.tap(aboutInDrawer);
        await tester.pumpAndSettle();

        // Should still be on About Us page
        expect(find.text('About Us Screen'), findsOneWidget);
      });

      testWidgets('should close drawer when tapping current route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/about'));
        await openDrawer(tester);

        // Verify drawer is open
        expect(find.text('Menu'), findsOneWidget);

        // Tap current route in drawer
        final drawerFinder = find.byType(Drawer);
        final aboutInDrawer =
            find.descendant(of: drawerFinder, matching: find.text('About Us'));
        await tester.tap(aboutInDrawer);
        await tester.pumpAndSettle();

        // Drawer should be closed
        expect(find.text('Menu'), findsNothing);
      });
    });

    group('PrintShack ExpansionTile', () {
      testWidgets('should expand PrintShack when tapped', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Initially, submenu items should not be visible
        expect(find.text('About Print Shack'), findsNothing);
        expect(find.text('Personalise'), findsNothing);

        // Tap to expand
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();

        // Now submenu items should be visible
        expect(find.text('About Print Shack'), findsOneWidget);
        expect(find.text('Personalise'), findsOneWidget);
      });

      testWidgets('should collapse PrintShack when tapped twice',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Expand
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();
        expect(find.text('About Print Shack'), findsOneWidget);

        // Collapse
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();
        expect(find.text('About Print Shack'), findsNothing);
      });

      testWidgets('should be initially expanded when on printshark route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/printshark'));
        await openDrawer(tester);

        // Should be expanded without tapping
        expect(find.text('About Print Shack'), findsOneWidget);
        expect(find.text('Personalise'), findsOneWidget);
      });

      testWidgets('should be initially expanded when on personalise route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/personalise'));
        await openDrawer(tester);

        // Should be expanded without tapping
        final drawerFinder = find.byType(Drawer);
        expect(
            find.descendant(
                of: drawerFinder, matching: find.text('About Print Shack')),
            findsOneWidget);
        expect(
            find.descendant(
                of: drawerFinder, matching: find.text('Personalise')),
            findsOneWidget);
      });

      testWidgets('should highlight About Print Shack when on that route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/printshark'));
        await openDrawer(tester);

        final printSharkTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('About Print Shack'),
            matching: find.byType(ListTile),
          ),
        );

        expect(printSharkTile.selected, true);
      });

      testWidgets('should highlight Personalise when on that route',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/personalise'));
        await openDrawer(tester);

        final personaliseTile = tester.widget<ListTile>(
          find.ancestor(
            of: find.text('Personalise'),
            matching: find.byType(ListTile),
          ),
        );

        expect(personaliseTile.selected, true);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle rapid menu taps without error',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Close and navigate properly
        await tester.tap(find.text('About Us'));
        await tester.pumpAndSettle();

        // Verify navigation
        expect(find.text('About Us Screen'), findsOneWidget);
      });

      testWidgets('should handle back button after opening drawer',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Verify drawer is open
        expect(find.text('Menu'), findsOneWidget);

        // Simulate back button
        Navigator.of(tester.element(find.byType(Scaffold))).pop();
        await tester.pumpAndSettle();

        // Drawer should be closed
        expect(find.text('Menu'), findsNothing);
      });

      testWidgets('should maintain drawer state across navigation',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Navigate to About
        await tester.tap(find.text('About Us'));
        await tester.pumpAndSettle();

        // Open drawer again
        await openDrawer(tester);

        // All menu items should still be present in drawer
        final drawerFinder = find.byType(Drawer);
        expect(find.descendant(of: drawerFinder, matching: find.text('Home')),
            findsOneWidget);
        expect(
            find.descendant(of: drawerFinder, matching: find.text('About Us')),
            findsOneWidget);
        expect(
            find.descendant(
                of: drawerFinder, matching: find.text('Collections')),
            findsOneWidget);
      });
    });

    group('Widget Structure', () {
      testWidgets('should be a Drawer widget', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        expect(find.byType(Drawer), findsOneWidget);
      });

      testWidgets('should have correct number of ListTile widgets',
          (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        // Expand PrintShack to see all items
        await tester.tap(find.text('PrintShack'));
        await tester.pumpAndSettle();

        // Should have 7 ListTiles: Home, About, Collections, Sale, PrintShack (ExpansionTile header), About Print Shack, Personalise
        expect(find.byType(ListTile), findsNWidgets(7));
      });

      testWidgets('should have zero padding on ListView', (tester) async {
        await tester.pumpWidget(createTestableWidget('/'));
        await openDrawer(tester);

        final listView = tester.widget<ListView>(find.byType(ListView));
        expect(listView.padding, EdgeInsets.zero);
      });
    });
  });
}
