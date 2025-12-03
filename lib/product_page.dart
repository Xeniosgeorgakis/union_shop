import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/fixtures.dart';

class ProductPage extends StatefulWidget {
  final String? productId;

  const ProductPage({super.key, this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product? _product;
  int _quantity = 1;
  String? _selectedImage;
  List<String> _productImages = [];
  bool _isInit = true;
  String _purchaseType = 'Personal Use';
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      // Try to load product from fixtures using productId
      if (widget.productId != null) {
        _product = ProductFixtures.findById(widget.productId!);
      }

      // Fallback to route arguments if no productId or product not found
      if (_product == null) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        if (args != null) {
          _product = Product(
            id: args['id'] ?? 'unknown',
            title: args['title'] ?? 'Product',
            price: args['price'] ?? '£0.00',
            originalPrice: args['originalPrice'],
            imageUrl: args['imageUrl'] ?? '',
            description: args['description'] ?? '',
          );
        }
      }

      // If still no product, show error
      if (_product == null) {
        return;
      }

      final imageUrl = _product!.imageUrl;
      final title = _product!.title;

      _selectedImage = imageUrl;
      _productImages = [imageUrl];

      if (title.contains('Garfield') || imageUrl.contains('garfield.png')) {
        _productImages
            .add('https://i.ebayimg.com/images/g/hL0AAOSwLtljjLNk/s-l1200.jpg');
      }

      if (title.toString().contains('Squid Game')) {
        _productImages.add(
            'https://cdn.webshopapp.com/shops/153/files/431539156/500x500x2/image.jpg');
      }
      if (title.toString().contains('Nike Tech Fleece')) {
        _productImages.add(
            'https://katanakicks.store/cdn/shop/files/IMG_4634_f4c96d33-3652-4f58-94a6-f923e27934e7.jpg?v=1697551016&width=1445');
      }

      _isInit = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  Widget _buildImage(String url) {
    if (url.startsWith('http')) {
      return Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(currentPage: '/product'),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Product details
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(40.0), // Increased padding
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 800;
                  if (isMobile) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageSide(context),
                        const SizedBox(height: 40),
                        _buildInfoSide(context),
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildImageSide(context)),
                        const SizedBox(
                            width: 48), // Space between image and text
                        Expanded(child: _buildInfoSide(context)),
                      ],
                    );
                  }
                },
              ),
            ),

            // Footer
            Footer(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSide(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Align(
            alignment: Alignment.topLeft,
            child: _buildImage(_selectedImage ?? ''),
          ),
        ),
        const SizedBox(height: 16),
        // { changed code } Thumbnails list
        if (_productImages.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _productImages.map((img) {
              final isSelected = img == _selectedImage;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImage = img;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(color: Colors.black, width: 2)
                        : Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: _buildImage(img),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildInfoSide(BuildContext context) {
    if (_product == null) {
      return const Center(
        child: Text('Product not found'),
      );
    }

    final title = _product!.title;
    final price = _product!.price;
    final originalPrice = _product!.originalPrice;
    final description = _product!.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product name
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 12),

// Product price
        if (originalPrice != null)
          Row(
            children: [
              Text(
                originalPrice,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          )
        else
          Text(
            price,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

        const SizedBox(height: 24),

        // Quantity Selector
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Purchase Type Dropdown
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            const Text(
              'Purchase as:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _purchaseType,
                underline: const SizedBox(),
                items: <String>['Personal Use', 'Gift'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _purchaseType = newValue!;
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Summary Text
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              'Quantity: $_quantity',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const Text(
              '·',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              'Purchase as: $_purchaseType',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Add to Cart Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (_product == null) return;

              Provider.of<CartProvider>(context, listen: false)
                  .addItem(_product!, _quantity, _purchaseType);

              // Show a confirmation SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${_product!.title} has been added to your cart.'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'VIEW CART',
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    textColor: Colors.yellow,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Product description
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
