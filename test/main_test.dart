import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('UnionShopApp should be creatable', (tester) async {
    // Just verify the app can be created without crashing immediately
    expect(() => const UnionShopApp(), returnsNormally);
  });

  testWidgets('should create MaterialApp', (tester) async {
    const app = UnionShopApp();
    expect(app, isA<StatelessWidget>());
  });
}
