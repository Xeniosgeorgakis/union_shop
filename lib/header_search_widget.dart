import 'package:flutter/material.dart';
import 'package:union_shop/models/all_products.dart';
import 'package:union_shop/models/product_model.dart';

class HeaderSearchWidget extends StatefulWidget {
  const HeaderSearchWidget({super.key});

  @override
  State<HeaderSearchWidget> createState() => _HeaderSearchWidgetState();
}

class _HeaderSearchWidgetState extends State<HeaderSearchWidget> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      return;
    }

    Product? foundProduct;
    try {
      foundProduct = allProducts.firstWhere(
        (product) => product.title.toLowerCase().contains(query.toLowerCase()),
      );
    } catch (e) {
      foundProduct = null;
    }

    if (foundProduct != null) {
      Navigator.pushNamed(
        context,
        '/product',
        arguments: {
          'title': foundProduct.title,
          'price': foundProduct.price,
          'originalPrice': foundProduct.originalPrice,
          'imageUrl': foundProduct.imageUrl,
          'description': foundProduct.description,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No product found.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          height: 36,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search...',
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _performSearch(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search, size: 18, color: Colors.grey),
          onPressed: _performSearch,
        ),
      ],
    );
  }
}
