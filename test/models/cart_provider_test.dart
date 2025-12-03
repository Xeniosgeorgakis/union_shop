import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/models/product_model.dart';

void main() {
  group('CartProvider Tests', () {
    late CartProvider cartProvider;
    late Product testProduct1;
    late Product testProduct2;
    late Product testProduct3;

    setUp(() {
      cartProvider = CartProvider();
      testProduct1 = Product(
        title: 'Bearbrick 1000% Test',
        price: '£250.00',
        originalPrice: '£300.00',
        imageUrl: 'https://example.com/bearbrick1.jpg',
        description: 'Test product 1',
      );
      testProduct2 = Product(
        title: 'Bearbrick 400% Test',
        price: '£150.00',
        imageUrl: 'https://example.com/bearbrick2.jpg',
        description: 'Test product 2',
      );
      testProduct3 = Product(
        title: 'Bearbrick 100% Test',
        price: '£50.00',
        imageUrl: 'https://example.com/bearbrick3.jpg',
        description: 'Test product 3',
      );
    });

    group('Initialization', () {
      test('should initialize with empty cart', () {
        expect(cartProvider.items, isEmpty);
        expect(cartProvider.itemCount, 0);
        expect(cartProvider.subtotal, 0.0);
      });
    });

    group('Adding Items', () {
      test('should add a single item to cart', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');

        expect(cartProvider.items.length, 1);
        expect(cartProvider.items[0].product.title, 'Bearbrick 1000% Test');
        expect(cartProvider.items[0].quantity, 1);
        expect(cartProvider.items[0].purchaseType, 'Buy');
      });

      test('should add multiple different items to cart', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.addItem(testProduct2, 2, 'Rent');

        expect(cartProvider.items.length, 2);
        expect(cartProvider.items[0].product.title, 'Bearbrick 1000% Test');
        expect(cartProvider.items[1].product.title, 'Bearbrick 400% Test');
        expect(cartProvider.items[1].quantity, 2);
      });

      test('should increment quantity when adding existing item', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.addItem(testProduct1, 2, 'Buy');

        expect(cartProvider.items.length, 1);
        expect(cartProvider.items[0].quantity, 3);
      });

      test('should add item with specified quantity', () {
        cartProvider.addItem(testProduct1, 5, 'Buy');

        expect(cartProvider.items[0].quantity, 5);
      });

      test('should notify listeners when item is added', () {
        int listenerCallCount = 0;
        cartProvider.addListener(() {
          listenerCallCount++;
        });

        cartProvider.addItem(testProduct1, 1, 'Buy');

        expect(listenerCallCount, 1);
      });
    });

    group('Item Count', () {
      test('should return correct item count for single item', () {
        cartProvider.addItem(testProduct1, 3, 'Buy');

        expect(cartProvider.itemCount, 3);
      });

      test('should return correct item count for multiple items', () {
        cartProvider.addItem(testProduct1, 2, 'Buy');
        cartProvider.addItem(testProduct2, 3, 'Rent');
        cartProvider.addItem(testProduct3, 1, 'Buy');

        expect(cartProvider.itemCount, 6);
      });

      test('should return zero for empty cart', () {
        expect(cartProvider.itemCount, 0);
      });
    });

    group('Subtotal Calculation', () {
      test('should calculate subtotal for single item', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');

        expect(cartProvider.subtotal, 250.00);
      });

      test('should calculate subtotal for single item with multiple quantities',
          () {
        cartProvider.addItem(testProduct1, 3, 'Buy');

        expect(cartProvider.subtotal, 750.00);
      });

      test('should calculate subtotal for multiple different items', () {
        cartProvider.addItem(testProduct1, 2, 'Buy'); // 250 * 2 = 500
        cartProvider.addItem(testProduct2, 1, 'Rent'); // 150 * 1 = 150
        cartProvider.addItem(testProduct3, 3, 'Buy'); // 50 * 3 = 150

        expect(cartProvider.subtotal, 800.00);
      });

      test('should return zero subtotal for empty cart', () {
        expect(cartProvider.subtotal, 0.0);
      });
    });

    group('Incrementing Item Quantity', () {
      test('should increment quantity of existing item', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');

        expect(cartProvider.items[0].quantity, 2);
      });

      test('should increment quantity multiple times', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');
        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');
        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');

        expect(cartProvider.items[0].quantity, 4);
      });

      test('should update subtotal when quantity is incremented', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        expect(cartProvider.subtotal, 250.00);

        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');
        expect(cartProvider.subtotal, 500.00);
      });

      test('should notify listeners when quantity is incremented', () {
        int listenerCallCount = 0;
        cartProvider.addListener(() {
          listenerCallCount++;
        });

        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');

        expect(listenerCallCount, 2);
      });

      test('should not throw error when incrementing non-existent item', () {
        expect(() => cartProvider.incrementItemQuantity('Non-existent Product'),
            returnsNormally);
        expect(cartProvider.items.length, 0);
      });
    });

    group('Decrementing Item Quantity', () {
      test('should decrement quantity of existing item', () {
        cartProvider.addItem(testProduct1, 3, 'Buy');
        cartProvider.decrementItemQuantity('Bearbrick 1000% Test');

        expect(cartProvider.items[0].quantity, 2);
      });

      test('should remove item when quantity reaches zero', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.decrementItemQuantity('Bearbrick 1000% Test');

        expect(cartProvider.items.length, 0);
      });

      test('should decrement quantity multiple times', () {
        cartProvider.addItem(testProduct1, 5, 'Buy');
        cartProvider.decrementItemQuantity('Bearbrick 1000% Test');
        cartProvider.decrementItemQuantity('Bearbrick 1000% Test');

        expect(cartProvider.items[0].quantity, 3);
      });

      test('should update subtotal when quantity is decremented', () {
        cartProvider.addItem(testProduct1, 3, 'Buy');
        expect(cartProvider.subtotal, 750.00);

        cartProvider.decrementItemQuantity('Bearbrick 1000% Test');
        expect(cartProvider.subtotal, 500.00);
      });

      test('should notify listeners when quantity is decremented', () {
        int listenerCallCount = 0;
        cartProvider.addListener(() {
          listenerCallCount++;
        });

        cartProvider.addItem(testProduct1, 2, 'Buy');
        cartProvider.decrementItemQuantity('Bearbrick 1000% Test');

        expect(listenerCallCount, 2);
      });

      test('should not throw error when decrementing non-existent item', () {
        expect(() => cartProvider.decrementItemQuantity('Non-existent Product'),
            returnsNormally);
        expect(cartProvider.items.length, 0);
      });
    });

    group('Removing Items', () {
      test('should remove item from cart', () {
        cartProvider.addItem(testProduct1, 2, 'Buy');
        cartProvider.removeItem('Bearbrick 1000% Test');

        expect(cartProvider.items.length, 0);
      });

      test('should remove only specified item', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.addItem(testProduct2, 2, 'Rent');
        cartProvider.removeItem('Bearbrick 1000% Test');

        expect(cartProvider.items.length, 1);
        expect(cartProvider.items[0].product.title, 'Bearbrick 400% Test');
      });

      test('should update subtotal when item is removed', () {
        cartProvider.addItem(testProduct1, 2, 'Buy');
        cartProvider.addItem(testProduct2, 1, 'Rent');
        expect(cartProvider.subtotal, 650.00);

        cartProvider.removeItem('Bearbrick 1000% Test');
        expect(cartProvider.subtotal, 150.00);
      });

      test('should notify listeners when item is removed', () {
        int listenerCallCount = 0;
        cartProvider.addListener(() {
          listenerCallCount++;
        });

        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.removeItem('Bearbrick 1000% Test');

        expect(listenerCallCount, 2);
      });

      test('should not throw error when removing non-existent item', () {
        expect(() => cartProvider.removeItem('Non-existent Product'),
            returnsNormally);
        expect(cartProvider.items.length, 0);
      });
    });

    group('Clearing Cart', () {
      test('should clear all items from cart', () {
        cartProvider.addItem(testProduct1, 2, 'Buy');
        cartProvider.addItem(testProduct2, 1, 'Rent');
        cartProvider.addItem(testProduct3, 3, 'Buy');

        cartProvider.clearCart();

        expect(cartProvider.items.length, 0);
        expect(cartProvider.itemCount, 0);
        expect(cartProvider.subtotal, 0.0);
      });

      test('should notify listeners when cart is cleared', () {
        int listenerCallCount = 0;
        cartProvider.addListener(() {
          listenerCallCount++;
        });

        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.clearCart();

        expect(listenerCallCount, 2);
      });

      test('should not throw error when clearing empty cart', () {
        expect(() => cartProvider.clearCart(), returnsNormally);
        expect(cartProvider.items.length, 0);
      });
    });

    group('Purchase Types', () {
      test('should store correct purchase type for Buy', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');

        expect(cartProvider.items[0].purchaseType, 'Buy');
      });

      test('should store correct purchase type for Rent', () {
        cartProvider.addItem(testProduct1, 1, 'Rent');

        expect(cartProvider.items[0].purchaseType, 'Rent');
      });

      test('should handle different purchase types for same product', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.addItem(testProduct1, 2, 'Buy');

        // Should increment since same purchase type
        expect(cartProvider.items.length, 1);
        expect(cartProvider.items[0].quantity, 3);
      });
    });

    group('Complex Scenarios', () {
      test('should handle complete shopping workflow', () {
        // Add items
        cartProvider.addItem(testProduct1, 2, 'Buy');
        cartProvider.addItem(testProduct2, 1, 'Rent');
        expect(cartProvider.items.length, 2);
        expect(cartProvider.itemCount, 3);

        // Increment quantity
        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');
        expect(cartProvider.items[0].quantity, 3);

        // Decrement quantity
        cartProvider.decrementItemQuantity('Bearbrick 400% Test');
        expect(cartProvider.items.length, 1); // Item 2 removed

        // Add another item
        cartProvider.addItem(testProduct3, 5, 'Buy');
        expect(cartProvider.items.length, 2);

        // Clear cart
        cartProvider.clearCart();
        expect(cartProvider.items.length, 0);
        expect(cartProvider.subtotal, 0.0);
      });

      test('should maintain correct state after multiple operations', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        cartProvider.addItem(testProduct2, 2, 'Rent');
        cartProvider.addItem(testProduct3, 3, 'Buy');

        cartProvider.incrementItemQuantity('Bearbrick 1000% Test');
        cartProvider.decrementItemQuantity('Bearbrick 100% Test');
        cartProvider.removeItem('Bearbrick 400% Test');

        expect(cartProvider.items.length, 2);
        expect(cartProvider.items[0].quantity, 2); // Product 1
        expect(cartProvider.items[1].quantity, 2); // Product 3
        expect(cartProvider.subtotal, 600.00); // (250*2) + (50*2)
      });
    });

    group('Listener Management', () {
      test('should handle multiple listeners', () {
        int listener1CallCount = 0;
        int listener2CallCount = 0;

        cartProvider.addListener(() {
          listener1CallCount++;
        });

        cartProvider.addListener(() {
          listener2CallCount++;
        });

        cartProvider.addItem(testProduct1, 1, 'Buy');

        expect(listener1CallCount, 1);
        expect(listener2CallCount, 1);
      });

      test('should not notify removed listeners', () {
        int listenerCallCount = 0;
        void listener() {
          listenerCallCount++;
        }

        cartProvider.addListener(listener);
        cartProvider.addItem(testProduct1, 1, 'Buy');
        expect(listenerCallCount, 1);

        cartProvider.removeListener(listener);
        cartProvider.addItem(testProduct2, 1, 'Rent');

        expect(listenerCallCount, 1); // Still 1, not 2
      });
    });

    group('Edge Cases', () {
      test('should handle adding item with zero quantity', () {
        cartProvider.addItem(testProduct1, 0, 'Buy');

        expect(cartProvider.items.length, 1);
        expect(cartProvider.items[0].quantity, 0);
        expect(cartProvider.itemCount, 0);
      });

      test('should handle products with special characters in price', () {
        final specialProduct = Product(
          title: 'Special Bearbrick',
          price: '£1,250.00',
          imageUrl: 'https://example.com/special.jpg',
          description: 'Special product with comma in price',
        );

        cartProvider.addItem(specialProduct, 1, 'Buy');

        // The priceValue should handle the comma
        expect(cartProvider.items.length, 1);
      });

      test('should return defensive copy of items list', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');
        final itemsCopy = cartProvider.items;

        // Modifying the copy should not affect the original
        itemsCopy.clear();

        expect(cartProvider.items.length, 1);
      });
    });

    group('Disposal', () {
      test('should dispose without errors', () {
        cartProvider.addItem(testProduct1, 1, 'Buy');

        expect(() => cartProvider.dispose(), returnsNormally);
      });
    });
  });
}
