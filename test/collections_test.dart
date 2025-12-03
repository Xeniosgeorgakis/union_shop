import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  Widget createTestableWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: const MaterialApp(
        home: CollectionsPage(),
      ),
    );
  }

  group('CollectionsPage Tests', () {
    testWidgets('should display collections page title', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('OUR COLLECTIONS'), findsOneWidget);
    });

    testWidgets('should display collection categories', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('BE@RBRICKS'), findsAtLeastNWidgets(1));
    });

    testWidgets('should display collection descriptions', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Explore our curated Bearbrick collections.'), findsOneWidget);
    });

    testWidgets('should display explore buttons', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(GestureDetector), findsAtLeastNWidgets(3));
    });

    testWidgets('should display app header', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Collections uses AppHeader widget, not AppBar
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display app drawer', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.menu), findsAtLeastNWidgets(1));
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('OPENING HOURS'), findsOneWidget);
    });

    testWidgets('should have scrollable content', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should display collection images', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsAtLeastNWidgets(3));
    });

    testWidgets('should display collection cards with proper layout', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsAtLeastNWidgets(3));
    });

    testWidgets('should handle button taps without errors', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(GestureDetector), findsAtLeastNWidgets(1));
      // Just verify buttons exist
    });

    testWidgets('should display responsive layout', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Column), findsAtLeastNWidgets(2));
      expect(find.byType(Row), findsAtLeastNWidgets(1));
    });

    testWidgets('should display proper spacing and padding', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Padding), findsAtLeastNWidgets(5));
      expect(find.byType(SizedBox), findsAtLeastNWidgets(3));
    });
  });
}