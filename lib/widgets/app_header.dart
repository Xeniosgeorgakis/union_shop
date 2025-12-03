import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/widgets/header_search_widget.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? currentPage;

  const AppHeader({super.key, this.currentPage});

  void navigateToHome(BuildContext context) {
    if (currentPage != '/') {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: LayoutBuilder(builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 900;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => navigateToHome(context),
                      child: Image.asset(
                        'assets/images/bearbricklogo.png',
                        height: 48,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    if (!isMobile) ...[
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildNavLink(context, 'Home', '/'),
                              const SizedBox(width: 24),
                              _buildNavLink(context, 'About Us', '/about'),
                              const SizedBox(width: 24),
                              _buildNavLink(
                                  context, 'Collections', '/collections'),
                              const SizedBox(width: 24),
                              _buildNavLink(context, 'SALE!', '/sale'),
                              const SizedBox(width: 24),
                              _buildPrintShackMenu(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HeaderSearchWidget(),
                        IconButton(
                          icon: const Icon(Icons.person_outline,
                              size: 18, color: Colors.black),
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
                                onPressed: () {
                                  Navigator.pushNamed(context, '/cart');
                                },
                              ),
                              if (cart.itemCount > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
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
                        if (isMobile)
                          Builder(
                            builder: (context) => IconButton(
                              icon: const Icon(Icons.menu,
                                  size: 18, color: Colors.black),
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                            ),
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.menu,
                                size: 18, color: Colors.grey),
                            onPressed: () {},
                          ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String title, String route) {
    final isCurrentPage = currentPage == route;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!isCurrentPage) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isCurrentPage ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPrintShackMenu(BuildContext context) {
    return PopupMenuButton<String>(
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
              'PrintShack',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
