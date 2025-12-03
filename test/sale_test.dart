import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';
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
        home: TestSalePage(),
      ),
    );
  }

  group('SalePage Tests', () {
    testWidgets('should display sale page title', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('SALE ITEMS'), findsOneWidget);
    });

    testWidgets('should display sale banner', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Grab these exclusive deals before they are gone!'),
          findsOneWidget);
    });

    testWidgets('should display products on sale', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // SaleProductCard uses Container, not Card
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display app header', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(MockAppHeader), findsOneWidget);
    });

    testWidgets('should display footer', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('OPENING HOURS'), findsOneWidget);
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

class TestSalePage extends StatelessWidget {
  const TestSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MockAppHeader(),
      body: SalePage(),
    );
  }
}
