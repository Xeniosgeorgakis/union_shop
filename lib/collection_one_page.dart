import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/models/product_model.dart';

class CollectionOnePage extends StatefulWidget {
  const CollectionOnePage({super.key});

  @override
  State<CollectionOnePage> createState() => _CollectionOnePageState();
}

class _CollectionOnePageState extends State<CollectionOnePage> {
  late List<Product> _products;
  late List<Product> _filteredProducts;
  String _sortOption = 'Default';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _products = [
      Product(
        title: 'KAWS Companion Bearbrick 1000% (Blue)',
        price: '£200.00',
        imageUrl:
            'https://images.stockx.com/images/KAWS-Companion-Bearbrick-1000-Grey-Blue.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1620338070',
        description:
            'The KAWS Companion Bearbrick 1000% Grey/Blue – GB is a standout collectible that merges the iconic Bearbrick silhouette with the unmistakable artistry of KAWS. Standing at an impressive 70 cm (27.5 inches), this oversized figure showcases the classic Companion character with its signature crossed-out eyes, detailed sculpting, and expressive posture.',
      ),
      Product(
        title: '1000% Bearbrick - Squid Game (Red)',
        price: '£160.00',
        originalPrice: '£200.00',
        imageUrl:
            'https://cdn.webshopapp.com/shops/153/files/431539158/medicom-toy-1000-bearbrick-squid-game-square-guard.jpg',
        description:
            'Step into the gripping world of Squid Game with this striking 1000% Bearbrick figure, inspired by the iconic Square Guard—the highest-ranking enforcer in the series’ hierarchy. Standing approximately 70 cm (27.5 inches) tall',
      ),
      Product(
        title: 'Bearbrick PAC-MAN 1000% (Black)',
        price: '£200.00',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOssIj6bikkRwl1sBE0u0ZK22FUihgjtlaPw&s',
        description:
            'The Bearbrick PAC-MAN 1000% – GB pays tribute to one of the most iconic video games of all time, blending nostalgic arcade culture with the modern collectible design of Bearbrick. Standing at approximately 70 cm tall, this oversized figure showcases vibrant PAC-MAN graphics wrapped around the classic Bearbrick form.',
      ),
    ];
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

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
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
      appBar: const AppHeader(currentPage: '/collection/1'),
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
                    '1000% BEARBRICKS',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Exclusive Selection',
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
                    '3 products',
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

class CollectionProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final String description;

  const CollectionProductCard({
    super.key,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'title': title,
            'price': price,
            'originalPrice': originalPrice,
            'imageUrl': imageUrl,
            'description': description,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(13, 0, 0, 0),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: imageUrl.startsWith('http')
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          imageUrl,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (originalPrice != null)
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          originalPrice!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
