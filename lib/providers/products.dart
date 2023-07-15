import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String? authToken;

  final String? userId;

  Products({this.authToken, this.userId, List<Product>? items})
      : _items = items ?? [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-01-efce4-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      await http
          .post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          },
        ),
      )
          .then(
        (response) {
          final newProduct = Product(
              id: json.decode(response.body)['name'],
              title: product.title,
              description: product.description,
              price: product.price,
              imageUrl: product.imageUrl);
          _items.add(newProduct);
          notifyListeners();
        },
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String? id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-01-efce4-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String? id) async {
    final url = Uri.parse(
        'https://flutter-01-efce4-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: 'Could not delete product!');
    }
    existingProduct = null;
  }

  Future<void> fetchAndSetProducts([bool filterbyUser = false]) async {
    final filterString =
        filterbyUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://flutter-01-efce4-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      url =
          'https://flutter-01-efce4-default-rtdb.asia-southeast1.firebasedatabase.app/userFavourites/$userId.json?auth=$authToken';
      final favouriteResponse = await http.get(Uri.parse(url));
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: favouriteData == null
                ? false
                : favouriteData['$prodId'] ?? false));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
