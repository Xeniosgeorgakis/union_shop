import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_provider.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/widgets/app_drawer.dart';
import 'package:union_shop/widgets/app_header.dart';

enum LineOption { one, two, three }

class PersonalisePage extends StatefulWidget {
  const PersonalisePage({super.key});

  @override
  State<PersonalisePage> createState() => _PersonalisePageState();
}

class _PersonalisePageState extends State<PersonalisePage> {
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _line3Controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _customText = '';
  String _selectedFont = 'Arial';
  final List<String> _fonts = [
    'Arial',
    'Verdana',
    'Georgia',
    'Courier',
    'Times New Roman'
  ];
  int _quantity = 1;
  LineOption _selectedLineOption = LineOption.one;

  @override
  void initState() {
    super.initState();
    _line1Controller.addListener(_updateCustomText);
    _line2Controller.addListener(_updateCustomText);
    _line3Controller.addListener(_updateCustomText);
  }

  void _updateCustomText() {
    setState(() {
      final lines = [_line1Controller.text];
      if (_selectedLineOption == LineOption.two ||
          _selectedLineOption == LineOption.three) {
        lines.add(_line2Controller.text);
      }
      if (_selectedLineOption == LineOption.three) {
        lines.add(_line3Controller.text);
      }
      _customText = lines.where((line) => line.isNotEmpty).join('\n');
    });
  }

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _line3Controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(currentPage: '/personalise'),
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Content
            Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personalise Your T-Shirt',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 800;
                          if (isMobile) {
                            return Column(
                              children: [
                                _buildPreviewArea(),
                                const SizedBox(height: 40),
                                _buildCustomisationOptions(),
                              ],
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1, child: _buildPreviewArea()),
                                const SizedBox(width: 40),
                                Expanded(
                                    flex: 1,
                                    child: _buildCustomisationOptions()),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Footer
            Footer(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewArea() {
    return Container(
      height: 400,
      color: Colors.grey[300],
      child: Center(
        child: _customText.isEmpty
            ? const Text(
                'Preview Area',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                _customText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: _selectedFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildCustomisationOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customisation',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Number of lines',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<LineOption>(
          initialValue: _selectedLineOption,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(
              value: LineOption.one,
              child: Text('One Line'),
            ),
            DropdownMenuItem(
              value: LineOption.two,
              child: Text('Two Lines'),
            ),
            DropdownMenuItem(
              value: LineOption.three,
              child: Text('Three Lines'),
            ),
          ],
          onChanged: (LineOption? newValue) {
            setState(() {
              _selectedLineOption = newValue!;
              _updateCustomText();
            });
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Font',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _selectedFont,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: _fonts.map((String font) {
            return DropdownMenuItem<String>(
              value: font,
              child: Text(font),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedFont = newValue!;
            });
          },
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _line1Controller,
          decoration: const InputDecoration(
            labelText: 'Enter your text (Line 1)',
            border: OutlineInputBorder(),
          ),
        ),
        if (_selectedLineOption == LineOption.two ||
            _selectedLineOption == LineOption.three)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextFormField(
              controller: _line2Controller,
              decoration: const InputDecoration(
                labelText: 'Enter your text (Line 2)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        if (_selectedLineOption == LineOption.three)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextFormField(
              controller: _line3Controller,
              decoration: const InputDecoration(
                labelText: 'Enter your text (Line 3)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        const SizedBox(height: 24),
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (_customText.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter some text to personalise.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final product = Product(
                title: 'Personalised T-Shirt',
                price: '£25.00',
                imageUrl: 'assets/images/tshirt.png',
                description:
                    'Custom Text: "$_customText"\nFont: $_selectedFont',
              );

              Provider.of<CartProvider>(context, listen: false)
                  .addItem(product, _quantity, 'Personal');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${product.title} has been added to your cart.'),
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
            child: const Text('ADD TO CART'),
          ),
        ),
      ],
    );
  }
}
