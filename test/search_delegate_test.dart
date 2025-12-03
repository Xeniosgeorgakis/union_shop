import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/search_delegate.dart';

void main() {
  group('CustomSearchDelegate Tests', () {
    testWidgets('should build search delegate', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate);
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('should display search results', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate, query: 'Bearbrick');
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should display suggestions when no query', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate);
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should clear query when clear button pressed', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate, query: 'test');
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // Query should be cleared
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should close search when back button pressed', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate);
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('should display product titles in results', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate, query: 'Bearbrick');
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsAtLeastNWidgets(1));
    });

    testWidgets('should handle empty search results', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate, query: 'nonexistentproduct12345');
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('should perform case-insensitive search', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate, query: 'bearbrick');
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(ListTile), findsAtLeastNWidgets(1));
    });

    testWidgets('should display suggestions with product titles', (tester) async {
      final delegate = CustomSearchDelegate();

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showSearch(context: context, delegate: delegate, query: 'BAPE');
                },
                child: const Text('Search'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.textContaining('BAPE'), findsAtLeastNWidgets(1));
    });
  });
}