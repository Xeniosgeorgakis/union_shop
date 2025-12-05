import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/fixtures.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/models/search_provider.dart';

class HeaderSearchWidget extends StatefulWidget {
  final bool isMobile;
  const HeaderSearchWidget({super.key, this.isMobile = false});

  @override
  State<HeaderSearchWidget> createState() => _HeaderSearchWidgetState();
}

class _HeaderSearchWidgetState extends State<HeaderSearchWidget> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  List<Product> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _searchController.text.isNotEmpty) {
      _showSuggestions();
    } else {
      _removeOverlay();
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      _suggestions = [];
      _removeOverlay();
    } else {
      _suggestions = ProductFixtures.allProducts
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();
      if (_focusNode.hasFocus) {
        _showSuggestions();
      }
    }
  }

  void _showSuggestions() {
    _removeOverlay();
    if (_suggestions.isEmpty) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final product = _suggestions[index];
                return ListTile(
                  title: Text(product.title),
                  onTap: () {
                    _selectProduct(product);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _selectProduct(Product product) {
    _searchController.text = product.title;
    _removeOverlay();
    _focusNode.unfocus();
    Navigator.pushNamed(context, '/product/${product.id}');
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return searchProvider.isSearchVisible
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: widget.isMobile ? 100 : 150,
                height: 36,
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, size: 18, color: Colors.black),
                onPressed: () {
                  if (_suggestions.isNotEmpty) {
                    _selectProduct(_suggestions.first);
                  }
                },
              ),
            ],
          )
        : IconButton(
            icon: const Icon(Icons.search, size: 18, color: Colors.black),
            onPressed: () {
              searchProvider.setSearch(true);
            },
          );
  }
}
