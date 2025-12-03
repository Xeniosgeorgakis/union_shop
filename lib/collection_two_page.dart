import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/collection_one_page.dart'; // Reusing CollectionProductCard
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/fixtures.dart';

class CollectionTwoPage extends StatefulWidget {
  const CollectionTwoPage({super.key});

  @override
  State<CollectionTwoPage> createState() => _CollectionTwoPageState();
}

class _CollectionTwoPageState extends State<CollectionTwoPage> {
  late List<Product> _products;
  late List<Product> _filteredProducts;
  String _sortOption = 'Default';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _products = ProductFixtures.collection2Products;
    _filteredProducts = List.from(_products);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void _sortProducts(String? option) {
    setState(() {
      _sortOption = option ?? 'Default';
      switch (_sortOption) {
        case 'Price: Low to High':
          _filteredProducts
              .sort((a, b) => a.priceValue.compareTo(b.priceValue));
          break;
        case 'Price: High to Low':
          _filteredProducts
              .sort((a, b) => b.priceValue.compareTo(a.priceValue));
          break;
        default:
          _filteredProducts = List.from(_products);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(currentPage: '/collection/2'),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Collection Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              color: const Color.fromARGB(255, 245, 245, 245),
              child: const Column(
                children: [
                  Text(
                    '400% AND 100% BE@RBRICKS',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The classic collector\'s set.',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Filter and Sort section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '6 products',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      const Text('Sort by:'),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: _sortOption,
                        items: <String>[
                          'Default',
                          'Price: Low to High',
                          'Price: High to Low'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: _sortProducts,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 40.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 600;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : 3,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 40,
                            childAspectRatio: isMobile ? 1.2 : 0.75,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return CollectionProductCard(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              originalPrice: product.originalPrice,
                              imageUrl: product.imageUrl,
                              description: product.description,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Footer(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
