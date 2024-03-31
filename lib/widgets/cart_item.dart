import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/cart_list.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final CartItem cart_item;

  const CartItemWidget({
    super.key,
    // ignore: non_constant_identifier_names
    required this.cart_item,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListModel>(
      builder: (context, productListModel, child) {
        // Check if the count is zero and hide the widget if true
        if (cart_item.count <= 0) {
          return const SizedBox
              .shrink(); // Return an empty SizedBox to take up no space
        }

        // Compute the total price
        int price = int.parse(cart_item.price.replaceAll(' ₽', ''));
        int totalPrice = cart_item.count * price;

        return Material(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.network(
                  cart_item.imageUrl,
                  width: MediaQuery.of(context).size.width * 0.37,
                  height: MediaQuery.of(context).size.width * 0.37,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cart_item.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 8),
                        child: Text(
                          cart_item.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40, // Adjust the height as needed
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // This makes the row take only as much space as its children need
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                size: 24.0, // Set the icon size
                              ),
                              onPressed: () {
                                productListModel.removeProduct(cart_item);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.red.shade100,
                                ),
                                iconColor: MaterialStateProperty.all(
                                  Colors.red.shade900,
                                ), // Set the background color of the IconButton
                              ),
                            ),
                            Text(
                              cart_item.count.toString(),
                              style: TextStyle(
                                fontSize: 22, // Increase the font size
                                color:
                                    Colors.red.shade900, // Set the text color
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 24.0, // Set the icon size
                              ),
                              onPressed: () {
                                productListModel.addProduct(cart_item);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.red.shade100,
                                ),
                                iconColor: MaterialStateProperty.all(
                                  Colors.red.shade900,
                                ), // Set the background color of the IconButton
                              ),
                            ),
                            const Spacer(), // Push the text to the right
                            Text(
                              '$totalPrice ₽', // Display the total price
                              style: TextStyle(
                                fontSize: 16, // Set the font size
                                color:
                                    Colors.red.shade900, // Set the text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
