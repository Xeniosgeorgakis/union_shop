import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/collection_one_page.dart'; // Reusing CollectionProductCard
import 'package:union_shop/models/product_model.dart';

class CollectionTwoPage extends StatefulWidget {
  const CollectionTwoPage({super.key});

  @override
  State<CollectionTwoPage> createState() => _CollectionTwoPageState();
}

class _CollectionTwoPageState extends State<CollectionTwoPage> {
  late List<Product> _products;
  late List<Product> _filteredProducts;
  String _sortOption = 'Default';

  @override
  void initState() {
    super.initState();
    _products = [
      Product(
        title: 'Bearbrick Garfield 100% & 400% Set (Gold)',
        price: '£112.00',
        originalPrice: '£140.00',
        imageUrl:
            'https://images.stockx.com/images/Bearbrick-Garfield-100-400-Set-Gold-Chrome-Ver-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
        description:
            'Celebrate one of pop culture’s most iconic characters with the limited-edition BE@RBRICK Garfield 100% & 400% Gold Set. \n\nFeaturing a striking chrome gold finish, this collector’s duo blends playful character design with the signature BE@RBRICK style.',
      ),
      Product(
        title: 'BEARBRICK Steven Harrington -Magic Hour 400% & 100%(Blue)',
        price: '£112.00',
        originalPrice: '£140.00',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYU2LL4F-Vf2TAKMJJrZT68wQl35a1dPfWUg&s',
        description:
            'Step into Steven Harrington’s vibrant, psychedelic world with the “Magic Hour” Bearbrick set, featuring both the 400% (28 cm) and 100% (7 cm) figures. Known for his playful, California-inspired pop-art style, Harrington brings his signature characters, bold linework, and surreal color palettes to the iconic Bearbrick silhouette.',
      ),
      Product(
        title: 'Bearbrick Sesame Street Elmo 100% & 400% Set (Red)',
        price: '£112.00',
        originalPrice: '£140.00',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyr6-IoGvAsyZM7ImVK5gFN7h9UtnCGWslfA&s',
        description:
            'Bring a touch of nostalgia and playful charm to your collection with the Bearbrick Sesame Street Elmo Set, featuring both the 100% (7 cm) and 400% (28 cm) figures. Designed with Elmo’s bright red fur, cheerful expression, and lovable character, this set captures the heartwarming spirit of the iconic Sesame Street star.',
      ),
      Product(
        title: '400% & 100% Bearbrick set - Camo Tiger by BAPE(Orange)',
        price: '£112.00',
        originalPrice: '£140.00',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1KIOJcTyN0CcpZTQ0zcoB_6TMEx3nE8C3Ig&s',
        description:
            'Elevate your collection with the iconic BAPE Camo Tiger Bearbrick Set, featuring the 400% (28 cm) and 100% (7 cm) figures. Wrapped in BAPE’s legendary Tiger Camo pattern, this set delivers the bold, high-energy aesthetic that has defined A Bathing Ape’s streetwear legacy.',
      ),
      Product(
        title: 'Bearbrick x Nike Tech Fleece N98 100% & 400% Set (Grey)',
        price: '£140.00',
        imageUrl:
            'https://images.stockx.com/images/Bearbrick-x-Nike-Tech-Fleece-N98-100-400-Set-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
        description:
            'The perfect fusion of streetwear and designer art toys, the Bearbrick x Nike Tech Fleece N98 Set brings Nike’s classic sportswear aesthetic into the world of collectible design. This limited-edition duo includes both the 100% (7 cm) and 400% (28 cm) Bearbrick figures, each dressed in the iconic Nike Tech Fleece N98 jacket',
      ),
      Product(
        title: '400% & 100% Bearbrick Set – LBWK x BAPE Green Camo (Black)',
        price: '£140.00',
        imageUrl:
            'https://szopex.blob.core.windows.net/shops/media/f1000/2024/medicom-toy/231848/medicom-bearbricks-100-400-set-anever-black-anever-black-2pack-6666f34da73b5.webp',
        description:
            'Experience the perfect blend of streetwear culture and automotive lifestyle with the LBWK x BAPE Green Camo Bearbrick Set. This exclusive release features both the 400% (28 cm) and 100% (7 cm) figures, wrapped in BAPE’s iconic green camouflage pattern with bold LBWK (Liberty Walk) branding.',
      ),
    ];
    _filteredProducts = List.from(_products);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.black,
                    child: const Text(
                      '🔥 Massive BE@RBRICK Sale Live Now — Limited Editions, Exclusive Drops, and Up to 20% Off While Stock Lasts!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => navigateToHome(context),
                            child: Image.network(
                              'assets/images/bearbricklogo.png',
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const Spacer(),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => navigateToHome(context),
                              child: const Text('Home',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/about'),
                              child: const Text('About Us',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/collections'),
                              child: const Text('Collections',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/sale'),
                              child: const Text('Sale',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/printshark');
                              },
                              child: const Text('Printshark',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const Spacer(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      size: 18, color: Colors.grey),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.person_outline,
                                      size: 18, color: Colors.black),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.shopping_bag_outlined,
                                      size: 18, color: Colors.grey),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      size: 18, color: Colors.grey),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                mainAxisAlignment: MainAxisAlignment.end,
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
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 40.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 40,
                        childAspectRatio: 0.75,
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
                    ),
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
