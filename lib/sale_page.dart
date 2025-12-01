import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
                          const Text(
                            'Sale',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 24),
                          PopupMenuButton<int>(
                            onSelected: (value) {
                              Navigator.pushNamed(
                                context,
                                '/printshark',
                                arguments: {'initialTabIndex': value},
                              );
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 0,
                                child: Text('About Print Shack'),
                              ),
                              const PopupMenuItem(
                                value: 1,
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
                                  icon: const Icon(Icons.search,
                                      size: 18, color: Colors.grey),
                                  onPressed: placeholderCallbackForButtons,
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
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.menu,
                                      size: 18, color: Colors.grey),
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

            // Sale Banner Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              color: Colors.red.shade50,
              child: const Column(
                children: [
                  Text(
                    'SALE ITEMS',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Grab these exclusive deals before they are gone!',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                      childAspectRatio: 0.75,
                      children: const [
                        SaleProductCard(
                          title: 'Bearbrick Garfield 100% & 400% Set (Gold)',
                          price: '£112.00',
                          originalPrice: '£140.00',
                          imageUrl:
                              'https://images.stockx.com/images/Bearbrick-Garfield-100-400-Set-Gold-Chrome-Ver-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1738193358',
                          description:
                              'Celebrate one of pop culture’s most iconic characters with the limited-edition BE@RBRICK Garfield 100% & 400% Gold Set. \n\nFeaturing a striking chrome gold finish, this collector’s duo blends playful character design with the signature BE@RBRICK style.',
                        ),
                        SaleProductCard(
                          title: '1000% Bearbrick - Squid Game (Red)',
                          price: '£160.00',
                          originalPrice: '£200.00',
                          imageUrl:
                              'https://cdn.webshopapp.com/shops/153/files/431539158/medicom-toy-1000-bearbrick-squid-game-square-guard.jpg',
                          description:
                              'Step into the gripping world of Squid Game with this striking 1000% Bearbrick figure, inspired by the iconic Square Guard—the highest-ranking enforcer in the series’ hierarchy. Standing approximately 70 cm (27.5 inches) tall',
                        ),
                        SaleProductCard(
                          title:
                              'BEARBRICK Steven Harrington -Magic Hour 400% & 100%(Blue)',
                          price: '£112.00',
                          originalPrice: '£140.00',
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYU2LL4F-Vf2TAKMJJrZT68wQl35a1dPfWUg&s',
                          description:
                              'Step into Steven Harrington’s vibrant, psychedelic world with the “Magic Hour” Bearbrick set, featuring both the 400% (28 cm) and 100% (7 cm) figures. Known for his playful, California-inspired pop-art style, Harrington brings his signature characters, bold linework, and surreal color palettes to the iconic Bearbrick silhouette.',
                        ),
                        SaleProductCard(
                          title:
                              'Bearbrick Sesame Street Elmo 100% & 400% Set (Red)',
                          price: '£112.00',
                          originalPrice: '£140.00',
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyr6-IoGvAsyZM7ImVK5gFN7h9UtnCGWslfA&s',
                          description:
                              'Bring a touch of nostalgia and playful charm to your collection with the Bearbrick Sesame Street Elmo Set, featuring both the 100% (7 cm) and 400% (28 cm) figures. Designed with Elmo’s bright red fur, cheerful expression, and lovable character, this set captures the heartwarming spirit of the iconic Sesame Street star.',
                        ),
                        SaleProductCard(
                          title:
                              '400% & 100% Bearbrick set - Camo Tiger by BAPE(Orange)',
                          price: '£112.00',
                          originalPrice: '£140.00',
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1KIOJcTyN0CcpZTQ0zcoB_6TMEx3nE8C3Ig&s',
                          description:
                              'Elevate your collection with the iconic BAPE Camo Tiger Bearbrick Set, featuring the 400% (28 cm) and 100% (7 cm) figures. Wrapped in BAPE’s legendary Tiger Camo pattern, this set delivers the bold, high-energy aesthetic that has defined A Bathing Ape’s streetwear legacy.',
                        ),
                      ],
                    ),
                  ),
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

class SaleProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final String description;

  const SaleProductCard({
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
