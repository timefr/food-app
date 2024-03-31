import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_dostavka/models/cart_list.dart';
import 'package:food_dostavka/widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isPhoneValid = false;
  bool _isAddressValid = false;
  bool _isFormValid = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _showSuccessModal(BuildContext context, ProductListModel cartList) {
    cartList.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Заказ сделан успешно'),
          content: const Text('Ожидайте звонок'),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              child: const Text('ОК'),
              onPressed: () {
                Navigator.pop(
                    context); // This will close the dialog and navigate back
              },
            ),
          ],
        );
      },
    );
  }

  bool _validatePhone(String value) {
    // Regular expression for a phone number with an optional country code
    RegExp phoneRegExp = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneRegExp.hasMatch(value);
  }

  bool _validateAddress(String value) {
    // Address should not be empty
    return value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<ProductListModel>(context, listen: true);

    int totalPriceAllProducts = 0;
    for (var cartItem in cartList.products) {
      int price = int.parse(cartItem.price.replaceAll(' ₽', ''));
      int totalPrice = cartItem.count * price;
      totalPriceAllProducts += totalPrice;
    }

    _isFormValid =
        _isPhoneValid && _isAddressValid && totalPriceAllProducts > 0;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Text(
            'Заказ',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          ...cartList.products
              .map((foodItem) => CartItemWidget(cart_item: foodItem)),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Телефон',
                    hintText: '+79093334477',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red.shade900),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red.shade900),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red.shade900),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isPhoneValid = _validatePhone(value);
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Адрес',
                    hintText: 'ул. Космонавтов, д. 5, кв 12',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red.shade900),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red.shade900),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.red.shade900),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isAddressValid = _validateAddress(value);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Divider(
              color: Colors.red.shade100,
              thickness: 2,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Итого: $totalPriceAllProducts ₽',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                        color: _isFormValid ? Colors.red : Colors.grey),
                  ),
                  onPressed: _isFormValid
                      ? () => _showSuccessModal(context, cartList)
                      : null,
                  child: Text(
                    'Заказать',
                    style: TextStyle(
                        color: _isFormValid ? Colors.red : Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
