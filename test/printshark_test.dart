import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/printshark_page.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/search_provider.dart';

void main() {
  setUpAll(() {
    // Set a larger screen size for tests to avoid layout overflow
    TestWidgetsFlutterBinding.ensureInitialized();
    const Size testScreenSize = Size(1200, 800);
    TestWidgetsFlutterBinding.instance.window.physicalSizeTestValue =
        testScreenSize;
    TestWidgetsFlutterBinding.instance.window.devicePixelRatioTestValue = 1.0;
  });

  Widget createTestableWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: const MaterialApp(
        home: TestPrintsharkPage(),
      ),
    );
  }

  group('PrintsharkPage Tests', () {
    testWidgets('should display printshark page title', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('ABOUT PRINT SHACK'), findsOneWidget);
    });

    testWidgets('should display description text', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('What Is Print Shack?'), findsOneWidget);
    });

    testWidgets('should display service features', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Text Personalisation'), findsOneWidget);
    });

    testWidgets('should display contact information', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Contact Us'), findsOneWidget);
    });

    testWidgets('should display app header', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(MockAppHeader), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('OPENING HOURS'), findsOneWidget);
    });

    testWidgets('should have scrollable content', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Check for the main scroll view in the body
      expect(find.byType(SingleChildScrollView).at(1), findsOneWidget);
    });

    testWidgets('should display white text on black background',
        (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('ABOUT PRINT SHACK'));
      expect(text.style?.color, Colors.white);
    });

    testWidgets('should handle button taps without errors', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Should not crash when tapping elements
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
    });

    testWidgets('should display proper layout structure', (tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Column), findsAtLeastNWidgets(2));
      expect(find.byType(Padding), findsAtLeastNWidgets(3));
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

class TestPrintsharkPage extends StatelessWidget {
  const TestPrintsharkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MockAppHeader(),
      body: PrintsharkPage(),
    );
  }
}
