import 'package:flutter/material.dart';
import 'package:food_dostavka/models/food_item.dart';
import 'package:food_dostavka/services/load_food_items.dart';
import 'package:food_dostavka/widgets/food_item.dart';

class FoodListWidget extends StatelessWidget {
  const FoodListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, List<FoodItem>>>(
        future: loadFoodItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final foodItemsByCategory = snapshot.data;
            return ListView.builder(
              itemCount: foodItemsByCategory?.keys.length ?? 0,
              itemBuilder: (context, index) {
                final category = foodItemsByCategory?.keys.elementAt(index);
                final foodItems = foodItemsByCategory?[category];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        category ?? '',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: foodItems?.length ?? 0,
                      itemBuilder: (context, innerIndex) {
                        final foodItem = foodItems?[innerIndex];
                        if (foodItem != null) {
                          return FoodItemWidget(foodItem: foodItem);
                        } else {
                          return Container(); // or any other placeholder widget
                        }
                      },
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
