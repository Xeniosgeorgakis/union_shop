import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/personalise_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_us_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/collection_one_page.dart'; // Import the new page
import 'package:union_shop/collection_two_page.dart';
import 'package:union_shop/printshark_page.dart';
import 'package:union_shop/cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const UnionShopApp(),
    ),
  );
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bearbrick Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutUsPage(),
        '/sale': (context) => const SalePage(),
        '/login': (context) => const LoginPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection/1': (context) => const CollectionOnePage(), // Add route
        '/collection/2': (context) => const CollectionTwoPage(),
        '/printshark': (context) => const PrintsharkPage(),
        '/personalise': (context) => const PersonalisePage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
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
                  // Top banner
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
                  // Main header
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigateToHome(context);
                            },
                            child: Image.network(
                              'assets/images/bearbricklogo.png',
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  width: 48,
                                  height: 48,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                navigateToHome(context);
                              },
                              child: const Text(
                                'Home',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/about');
                              },
                              child: const Text(
                                'About Us',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/collections');
                              },
                              child: const Text(
                                'Collections',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/sale');
                              },
                              child: const Text(
                                'Sale',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              Navigator.pushNamed(context, value);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: '/printshark',
                                child: Text('About Print Shack'),
                              ),
                              const PopupMenuItem(
                                value: '/personalise',
                                child: Text('Personalise'),
                              ),
                            ],
                            child: const MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                children: [
                                  Text(
                                    'Printshark',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.person_outline,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                ),
                                Consumer<CartProvider>(
                                  builder: (context, cart, child) => Stack(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.shopping_bag_outlined,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        constraints: const BoxConstraints(
                                          minWidth: 32,
                                          minHeight: 32,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/cart');
                                        },
                                      ),
                                      if (cart.itemCount > 0)
                                        Positioned(
                                          right: 4,
                                          top: 4,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 16,
                                              minHeight: 16,
                                            ),
                                            child: Text(
                                              '${cart.itemCount}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
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

            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'assets/images/bearbrickheader.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(115, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'OVER 20% OFF!',
                          style: TextStyle(
                            fontSize: 64, // Increased size
                            fontFamily: 'Arial', // Changed font
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 3),
                                blurRadius: 8,
                                color: Color.fromARGB(120, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Buy yours before they are gone!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40, // Increased size
                            fontFamily: 'Arial', // Changed font
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.2,
                            letterSpacing: 0.8,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 6,
                                color: Color.fromARGB(90, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/collections');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE OUR COLLECTIONS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'OVER 20% OFF ON SELECTED PRODUCTS!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 80,
                          mainAxisSpacing: 80,
                          childAspectRatio: 0.75,
                          children: const [
                            ProductCard(
                              title:
                                  'Bearbrick Garfield 100% & 400% Set (Gold)',
                              price: '£112.00',
                              originalPrice: '£140.00',
                              imageUrl:
                                  'https://images.stockx.com/images/Bearbrick-Garfield-100-400-Set-Gold-Chrome-Ver-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
                              description:
                                  'Celebrate one of pop culture’s most iconic characters with the limited-edition BE@RBRICK Garfield 100% & 400% Gold Set. \n\nFeaturing a striking chrome gold finish, this collector’s duo blends playful character design with the signature BE@RBRICK style.\n\n Perfect for display, gifting, or expanding your collection, each figure delivers high-quality craftsmanship, smooth detailing, and a bold visual presence that stands out in any room or shelf.\n\n A must-have collector’s piece for Garfield fans and Bearbrick enthusiasts alike.',
                            ),
                            ProductCard(
                              title: '1000% Bearbrick - Squid Game (Red)',
                              price: '£160.00',
                              originalPrice: '£200.00',
                              imageUrl:
                                  'https://cdn.webshopapp.com/shops/153/files/431539158/medicom-toy-1000-bearbrick-squid-game-square-guard.jpg',
                              description:
                                  'Step into the gripping world of Squid Game with this striking 1000% Bearbrick figure, inspired by the iconic Square Guard—the highest-ranking enforcer in the series’ hierarchy. Standing approximately 70 cm (27.5 inches) tall',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sale');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 20),
                      ),
                      child: const Text(
                        'VIEW ALL SALES',
                        style: TextStyle(fontSize: 14, letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      '🔥DECEMBER DROP🔥',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 80,
                          mainAxisSpacing: 80,
                          childAspectRatio: 0.75,
                          children: const [
                            ProductCard(
                              title:
                                  'Bearbrick x Nike Tech Fleece N98 100% & 400% Set (Grey)',
                              price: '£140.00',
                              imageUrl:
                                  'https://images.stockx.com/images/Bearbrick-x-Nike-Tech-Fleece-N98-100-400-Set-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
                              description:
                                  'The perfect fusion of streetwear and designer art toys, the Bearbrick x Nike Tech Fleece N98 Set brings Nike’s classic sportswear aesthetic into the world of collectible design. This limited-edition duo includes both the 100% (7 cm) and 400% (28 cm) Bearbrick figures, each dressed in the iconic Nike Tech Fleece N98 jacket',
                            ),
                            ProductCard(
                              title:
                                  '400% & 100% Bearbrick Set – LBWK x BAPE Green Camo (Black)',
                              price: '£140.00',
                              imageUrl:
                                  'https://szopex.blob.core.windows.net/shops/media/f1000/2024/medicom-toy/231848/medicom-bearbricks-100-400-set-anever-black-anever-black-2pack-6666f34da73b5.webp',
                              description:
                                  'Experience the perfect blend of streetwear culture and automotive lifestyle with the LBWK x BAPE Green Camo Bearbrick Set. This exclusive release features both the 400% (28 cm) and 100% (7 cm) figures, wrapped in BAPE’s iconic green camouflage pattern with bold LBWK (Liberty Walk) branding.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'Print Shack',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/personalise');
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Image.network(
                          'assets/images/tshirt.png',
                          height: 300,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              height: 300,
                              width: 300,
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: const Text(
                        'Print Shack is our personalised T-shirt service that lets you create unique, made-to-order shirts with your own text, artwork, or branding.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final String description;

  const ProductCard({
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
                    Row(
                      children: [
                        Text(
                          originalPrice!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red, // Highlight sale price
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
