import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class ProductListModel extends ChangeNotifier {
  final List<CartItem> _products = [];

  List<CartItem> get products => _products;

  void addProduct(CartItem product) {
    bool productExists = false;

    // Check if the product already exists in the list
    for (var existingProduct in _products) {
      if (existingProduct.title == product.title &&
          existingProduct.description == product.description &&
          existingProduct.price == product.price &&
          existingProduct.imageUrl == product.imageUrl &&
          existingProduct.category == product.category) {
        // If the product exists, increase the count
        if (existingProduct.count < 20) {
          existingProduct.count++;
        }

        productExists = true;
        break;
      }
    }

    //If the product does not exist, add it to the list with count 1
    if (!productExists) {
      _products.add(product..count = 1);
    }

    //Notify listeners about the change
    notifyListeners();
  }

  void removeProduct(CartItem product) {
    // Decrease the count of the product
    product.count--;

    // If the count reaches 0, remove the product from the list
    if (product.count == 0) {
      _products.remove(product);
    }

    // Notify listeners about the change
    notifyListeners();
  }

  void clear() {
    _products.clear();

    notifyListeners();
  }
}
