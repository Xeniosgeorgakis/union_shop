import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_us_page.dart';
import 'package:union_shop/sale_page.dart'; // { changed code } Import SalePage
import 'package:union_shop/footer.dart';

void main() {
  runApp(const UnionShopApp());
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
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutUsPage(),
        '/sale': (context) =>
            const SalePage(), // { changed code } Add Sale route
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
                      // { changed code } Make top banner text bold
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
                          // { changed code } Add Spacer to push nav links to center
                          const Spacer(),
                          GestureDetector(
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
                          const SizedBox(width: 24),
                          GestureDetector(
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
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              // { changed code } Navigate to Sale page
                              Navigator.pushNamed(context, '/sale');
                            },
                            child: const Text(
                              'Sale',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                // { changed code } Change color to black
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // { changed code } Add Spacer to push icons to right
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
                                    Icons.shopping_bag_outlined,
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
                        // { changed code } Use const BoxDecoration with Color.fromARGB for performance
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
                        // { changed code } larger, bolder, with letter spacing and shadow for better visibility
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
                        // { changed code } slightly larger subtitle with subtle shadow
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
                          onPressed: placeholderCallbackForButtons,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
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
                        // { changed code } Make section header bold
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // { changed code } Constrain width to make cards smaller, and use 2 columns for "2 up 2 down"
                    Center(
                      child: ConstrainedBox(
                        // { changed code } Increased maxWidth to 900 to make cards bigger
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // { changed code } Keep 2 columns but increase spacing significantly
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
                              title: 'Placeholder Product 2',
                              price: '£15.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                              description:
                                  'A classic Portsmouth city magnet to remember your time at the university. Durable and stylish, perfect for your fridge.',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 3',
                              price: '£20.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                              description:
                                  'Essential university hoodie in navy blue. Comfortable, warm, and perfect for lectures or lounging at home.',
                            ),
                            ProductCard(
                              title: 'Placeholder Product 4',
                              price: '£25.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                              description:
                                  'Reusable water bottle with university branding. Eco-friendly and keeps your drinks cold for hours.',
                            ),
                          ],
                        ),
                      ),
                    ),
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
      // { changed code } Added styling container with shadow and rounded corners
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(13, 0, 0, 0), // ~0.05 opacity black
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // { changed code } Clip image to match rounded corners
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                // { changed code } Add padding to make the image smaller inside the card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: imageUrl.startsWith('http')
                      ? Image.network(
                          imageUrl,
                          // { changed code } Use contain to show the full image without cropping
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
                          // { changed code } Use contain to show the full image without cropping
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
            // { changed code } Added padding for text content
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
                      // { changed code } Make product title bold
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
