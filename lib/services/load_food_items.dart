import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_dostavka/models/food_item.dart';
import 'package:collection/collection.dart'; // Import the collection package

Future<Map<String, List<FoodItem>>> loadFoodItems() async {
  final jsonString = await rootBundle.loadString('assets/food_items.json');
  final jsonData = await json.decode(jsonString);
  final foodItems =
      jsonData.map<FoodItem>((item) => FoodItem.fromJson(item)).toList();
  // Group the food items by category
  return groupBy(foodItems, (FoodItem item) => item.category);
}
