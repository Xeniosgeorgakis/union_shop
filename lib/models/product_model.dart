class Product {
  final String title;
  final String price;
  final String? originalPrice;
  final String imageUrl;
  final String description;

  Product({
    required this.title,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.description,
  });

  double get priceValue {
    return double.tryParse(price.replaceAll('£', '')) ?? 0.0;
  }
}
