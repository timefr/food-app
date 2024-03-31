import 'food_item.dart';

class CartItem extends FoodItem {
  int count;

  CartItem({
    required super.title,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.category,
    this.count = 1,
  });
}
