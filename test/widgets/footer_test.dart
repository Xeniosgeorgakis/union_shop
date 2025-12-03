import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  // Helper to create a testable widget with necessary providers and routes
  Widget createTestableWidget(
      {required Widget child, MockNavigatorObserver? navigatorObserver}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
        routes: {
          '/about': (_) => const Scaffold(body: Text('About Page')),
        },
        navigatorObservers:
            navigatorObserver != null ? [navigatorObserver] : [],
      ),
    );
  }

  group('Footer Tests', () {
    testWidgets('should display all footer sections and text', (tester) async {
      await tester.pumpWidget(createTestableWidget(child: const Footer()));

      // Check for section headers
      expect(find.text('OPENING HOURS'), findsOneWidget);
      expect(find.text('INFORMATION'), findsOneWidget);
      expect(find.text('HELP'), findsOneWidget);

      // Check for links
      expect(find.text('About Us'), findsOneWidget);
      expect(find.text('Shipping & Returns'), findsOneWidget);
      expect(find.text('FAQ'), findsOneWidget);
      expect(find.text('Contact Us'), findsOneWidget);
      expect(find.text('Terms & Conditions'), findsOneWidget);

      // Check for copyright text
      expect(find.text('© 2024 Bearbrick Shop. All rights reserved.'),
          findsOneWidget);
    });

    testWidgets('should navigate to About Us page when link is tapped',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(createTestableWidget(
        child: const Footer(),
        navigatorObserver: mockObserver,
      ));

      await tester.tap(find.text('About Us'));
      await tester.pumpAndSettle();

      // Verify that a push event happened
      expect(mockObserver.pushed, isTrue);
      // Verify we are on the About Page
      expect(find.text('About Page'), findsOneWidget);
    });

    testWidgets('should not display search icon if scrollController is null',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(child: const Footer()));

      expect(find.byIcon(Icons.search), findsNothing);
    });

    testWidgets(
        'should display search icon and scroll to top when scrollController is provided',
        (tester) async {
      final scrollController = ScrollController(initialScrollOffset: 500);
      final searchProvider = SearchProvider();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: searchProvider),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 1000), // To make it scrollable
                    // Use a Consumer to get the latest provider state
                    Consumer<SearchProvider>(
                      builder: (context, listenedProvider, child) {
                        return Footer(scrollController: scrollController);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Check that scroll position is not at the top
      expect(scrollController.offset, 500);

      // Find the search icon inside the footer and tap it
      final searchIcon = find.descendant(
        of: find.byType(Footer),
        matching: find.byIcon(Icons.search),
      );
      expect(searchIcon, findsOneWidget);

      // Ensure the icon is visible before tapping
      await tester.ensureVisible(searchIcon);
      await tester.pumpAndSettle();

      await tester.tap(searchIcon);
      await tester.pumpAndSettle(); // Wait for scroll and provider update

      // Verify search provider was activated
      expect(searchProvider.isSearchVisible, isTrue);

      // Verify scroll position is at the top
      expect(scrollController.offset, 0);
    });
  });
}

// A mock navigator observer to verify navigation events.
class MockNavigatorObserver extends NavigatorObserver {
  bool pushed = false;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushed = true;
  }
}
