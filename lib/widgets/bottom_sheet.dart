import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';
import '../models/cart_list.dart';

class FoodItemBottomSheet extends StatelessWidget {
  final FoodItem foodItem;

  const FoodItemBottomSheet({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListModel>(
      builder: (context, model, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 0,
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.network(
                            foodItem.imageUrl,
                            width: 250,
                            height: 250,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            foodItem.title,
                            style: const TextStyle(fontSize: 22, height: 1.2),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              foodItem.description,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.2,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          // ... other content
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: Container(
                    height: 46, // Adjust the height as needed
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        final item = CartItem(
                          title: foodItem.title,
                          description: foodItem.description,
                          price: foodItem.price,
                          imageUrl: foodItem.imageUrl,
                          category: foodItem.category, // Set the count to 1
                        );

                        // Call the addProduct method from the model
                        model.addProduct(item);

                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        foregroundColor: Colors.red.shade900, // Text color
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      child: Text('Добавить в корзину ${foodItem.price}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
