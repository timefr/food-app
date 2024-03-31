import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'bottom_sheet.dart';

class FoodItemWidget extends StatelessWidget {
  final FoodItem foodItem;

  const FoodItemWidget({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Set the background color to white
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return FoodItemBottomSheet(foodItem: foodItem);
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Image.network(
                foodItem.imageUrl,
                width: MediaQuery.of(context).size.width *
                    0.4, // Increase image size to 50% of width
                height: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      foodItem.title,
                      style: const TextStyle(fontSize: 20, height: 1.0),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical:
                              12.0), // Add a margin of 16 pixels on the top and bottom
                      child: Text(
                        foodItem.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(
                              0.6), // Change description text color to light gray
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(
                        foodItem.price,
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red
                          .shade100, // Change background color to a light shade of red
                      shape: const StadiumBorder(
                        // Make the chip pill-shaped
                        side: BorderSide.none, // Remove the white border
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
