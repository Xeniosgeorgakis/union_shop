import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void setSearch(bool isSearching) {
    if (_isSearching != isSearching) {
      _isSearching = isSearching;
      notifyListeners();
    }
  }
}
