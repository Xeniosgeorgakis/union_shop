import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  bool _isSearchVisible = false;

  bool get isSearchVisible => _isSearchVisible;

  void setSearch(bool isVisible) {
    _isSearchVisible = isVisible;
    notifyListeners();
  }
}
