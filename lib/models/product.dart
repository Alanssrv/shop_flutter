import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  var product_base_url = const String.fromEnvironment('PRODUCT_BASE_URL');
  // var product_base_url = 'url/products';

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    _toggleFavorite();

    final response = await http.patch(
      Uri.parse('$product_base_url/$id.json'),
      body: jsonEncode({'isFavorite': isFavorite}),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
    }
  }
}
