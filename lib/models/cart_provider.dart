import 'package:flutter/foundation.dart';
import 'package:union_shop/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  final String purchaseType;

  CartItem({
    required this.product,
    required this.quantity,
    required this.purchaseType,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get subtotal {
    return _items.fold(
        0.0, (sum, item) => sum + (item.product.priceValue * item.quantity));
  }

  void addItem(Product product, int quantity, String purchaseType) {
    final existingIndex =
        _items.indexWhere((item) => item.product.title == product.title);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product,
        quantity: quantity,
        purchaseType: purchaseType,
      ));
    }
    notifyListeners();
  }

  void incrementItemQuantity(String productTitle) {
    final existingIndex =
        _items.indexWhere((item) => item.product.title == productTitle);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
      notifyListeners();
    }
  }

  void decrementItemQuantity(String productTitle) {
    final existingIndex =
        _items.indexWhere((item) => item.product.title == productTitle);
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        removeItem(productTitle);
      }
      notifyListeners();
    }
  }

  void removeItem(String productTitle) {
    _items.removeWhere((item) => item.product.title == productTitle);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
