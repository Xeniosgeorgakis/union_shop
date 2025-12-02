import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that basic UI elements are present

      expect(
        find.text(
            '🔥 Massive BE@RBRICK Sale Live Now — Limited Editions, Exclusive Drops, and Up to 20% Off While Stock Lasts!'),
        findsOneWidget,
      );

      expect(find.text('OVER 20% OFF!'), findsOneWidget);

      expect(find.text('OVER 20% OFF ON SELECTED PRODUCTS!'), findsOneWidget);
      expect(find.text('BROWSE OUR COLLECTIONS'), findsOneWidget);

      expect(find.text('VIEW ALL SALES'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that product cards are displayed

      expect(find.text('Bearbrick Garfield 100% & 400% Set (Gold)'),
          findsOneWidget);
      expect(find.text('1000% Bearbrick - Squid Game (Red)'), findsOneWidget);
      expect(
          find.text('Bearbrick x Nike Tech Fleece N98 100% & 400% Set (Grey)'),
          findsOneWidget);
      expect(
          find.text(
              '400% & 100% Bearbrick Set – LBWK x BAPE Green Camo (Black)'),
          findsOneWidget);

      // Check prices are displayed

      expect(find.text('£112.00'), findsOneWidget);
      expect(find.text('£160.00'), findsOneWidget);
      expect(find.text('£140.00'), findsNWidgets(2)); // Two items at £140.00
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Check that header icons are present
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      expect(find.text('OPENING HOURS'), findsOneWidget);
      expect(find.text('INFORMATION'), findsOneWidget);
      expect(find.text('HELP'), findsOneWidget);
    });
  });
}
