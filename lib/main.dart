import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/food_list_widget.dart';
import 'screens/cart.dart';
import 'package:food_dostavka/models/cart_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductListModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Dostavka',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(
          primary: const Color(0xFFEE2C21),
          secondary: const Color(0xFFD68438),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/icon/icon.png',
                width: 30.0,
                height: 30.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Food Dostavka',
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.black,
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          FoodListWidget(),
          // Replace with your CartWidget
          CartView(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant,
                color: _currentIndex == 0
                    ? Colors.red.shade900
                    : Colors.red.shade100,
              ),
              label: 'Меню',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: _currentIndex == 1
                    ? Colors.red.shade900
                    : Colors.red.shade100,
              ),
              label: 'Корзина',
            ),
          ],
          selectedItemColor: Colors.red.shade900,
          unselectedItemColor: Colors.red.shade200,
          elevation: 0.5,
          backgroundColor: Colors.red.shade50,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          iconSize: 30,
        ),
      ),
    );
  }
}
