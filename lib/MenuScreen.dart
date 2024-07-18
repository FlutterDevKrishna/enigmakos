import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'CartScreen.dart';
import 'FrontScreen.dart';

// Model classes for Menu and Cart items
class MenuItem {
  final String name;
  final double price;
  final String image;

  MenuItem({
    required this.name,
    required this.price,
    required this.image,
  });
}

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  String _selectedCategory = 'Burgers'; // Initial category

  List<CartItem> get items => _items;
  String get selectedCategory => _selectedCategory;

  int get totalItems {
    int total = 0;
    _items.forEach((item) {
      total += item.quantity;
    });
    return total;
  }

  double get subtotalPrice {
    double subtotal = 0;
    _items.forEach((item) {
      subtotal += item.item.price * item.quantity;
    });
    return subtotal;
  }

  double get taxAmount {
    return subtotalPrice * 0.05;
  }

  double get totalPrice {
    return subtotalPrice + taxAmount;
  }

  void addItem(MenuItem menuItem) {
    bool found = false;
    for (var cartItem in _items) {
      if (cartItem.item.name == menuItem.name) {
        cartItem.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      _items.add(CartItem(item: menuItem));
    }
    notifyListeners();
  }

  void decreaseItem(MenuItem menuItem) {
    for (var cartItem in _items) {
      if (cartItem.item.name == menuItem.name) {
        cartItem.quantity--;
        if (cartItem.quantity <= 0) {
          _items.remove(cartItem); // Remove item if quantity is zero or less
        }
        notifyListeners();
        return;
      }
    }
  }

  void removeItem(CartItem cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void changeCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}


// Main MenuScreen widget
class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  final List<String> categories = [
    'Burgers',
    'Drinks',
    'Desserts',
    'Snacks',
    'Salads',
    'Breakfast'
  ];

  final Map<String, List<MenuItem>> items = {
    'Burgers': [
      MenuItem(name: 'Big Mac', price: 40.99, image: 'assets/items/a1.png'),
      MenuItem(name: 'McChicken', price: 320.49, image: 'assets/items/a2.png'),
      MenuItem(name: 'Cheeseburger', price: 200.99, image: 'assets/items/a3.png'),
      MenuItem(name: 'Double Cheeseburger', price: 500.49, image: 'assets/items/a4.png'),
    ],
    'Drinks': [
      MenuItem(name: 'Coke', price: 100.99, image: 'assets/items/a5.png'),
      MenuItem(name: 'Pepsi', price: 60.99, image: 'assets/items/a6.png'),
      MenuItem(name: 'Sprite', price: 50.99, image: 'assets/items/a7.png'),
      MenuItem(name: 'Fanta', price: 50.99, image: 'assets/items/a8.png'),
      MenuItem(name: 'Iced Tea', price: 20.49, image: 'assets/items/a9.png'),
    ],
    'Desserts': [
      MenuItem(name: 'McFlurry', price: 30.29, image: 'assets/items/a10.png'),
      MenuItem(name: 'Apple Pie', price: 10.49, image: 'assets/items/a11.png'),
      MenuItem(name: 'Ice Cream', price: 20.99, image: 'assets/items/a12.png'),
      MenuItem(name: 'Sundae', price: 30.49, image: 'assets/items/a13.png'),
    ],
    'Snacks': [
      MenuItem(name: 'Fries', price: 50.79, image: 'assets/items/a14.png'),
      MenuItem(name: 'Chicken Nuggets', price: 40.99, image: 'assets/items/a15.png'),
      MenuItem(name: 'Mozzarella Sticks', price: 30.99, image: 'assets/items/a16.png'),
      MenuItem(name: 'Onion Rings', price: 20.49, image: 'assets/items/a17.png'),
    ],
    'Salads': [
      MenuItem(name: 'Caesar Salad', price: 50.99, image: 'assets/items/a18.png'),
      MenuItem(name: 'Garden Salad', price: 40.99, image: 'assets/items/a19.png'),
      MenuItem(name: 'Greek Salad', price: 60.49, image: 'assets/items/a20.png'),
      MenuItem(name: 'Chef Salad', price: 50.79, image: 'assets/items/a21.png'),
    ],
    'Breakfast': [
      MenuItem(name: 'Egg McMuffin', price: 30.99, image: 'assets/items/a22.png'),
      MenuItem(name: 'Hotcakes', price: 40.49, image: 'assets/items/a23.png'),
      MenuItem(name: 'Sausage Biscuit', price: 30.29, image: 'assets/items/a24.png'),
      MenuItem(name: 'Hash Browns', price: 10.99, image: 'assets/items/a25.png'),
    ],
  };

  final Map<String, String> categoryImages = {
    'Burgers': 'assets/burger.png',
    'Drinks': 'assets/drink.png',
    'Desserts': 'assets/desserts.png',
    'Snacks': 'assets/snacks.png',
    'Salads': 'assets/salad.png',
    'Breakfast': 'assets/breakfast.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 200,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.0),
              child: Image.asset(
                'assets/logo.png',
                height: 120, // Adjust the height as needed
                fit: BoxFit.fitHeight,
              ),
            ),
            Spacer(flex: 3,),
            Text(
              'Minion Meal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: Consumer<Cart>(
                      builder: (context, cart, child) {
                        return ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final bool isSelected = categories[index] == cart.selectedCategory;
                            return ListTile(
                              title: Container(
                                height: 50,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(color: Colors.black12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isSelected ? Color.fromARGB(255, 255, 216, 0) : Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.3,
                                      blurRadius: 0.2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      categoryImages[categories[index]] ?? '',
                                      width: 30,
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      categories[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              selected: isSelected,
                              onTap: () {
                                Provider.of<Cart>(context, listen: false).changeCategory(categories[index]);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<Cart>(
                      builder: (context, cart, child) => GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: items[cart.selectedCategory]?.length ?? 0,
                        itemBuilder: (context, index) {
                          final MenuItem item = items[cart.selectedCategory]![index];
                          return Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Provider.of<Cart>(context, listen: false).addItem(item);
                              },
                              child: LayoutBuilder(
                                builder: (context, constraints) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      item.image,
                                      height: constraints.maxHeight * 0.5,
                                      width: constraints.maxWidth * 0.5,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '\₹${item.price.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<Cart>(
                      builder: (context, cart, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Items: ${cart.totalItems.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Subtotal: \₹${cart.subtotalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total: \₹${cart.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Consumer<Cart>(
                    builder: (context, cart, child) {
                      return ElevatedButton(
                        onPressed: cart.totalItems > 0
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartScreen()),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 216, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        child: const Text('View Cart',style: TextStyle(color: Colors.white),),
                      );
                    },
                  ),
                ],
              ),
            ),
          SizedBox(height: 20,),
          //  startover
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Cart cart = Provider.of<Cart>(context, listen: false);
                        cart.clearCart(); // Clear all items in the cart
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Frontscreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restart_alt, color: Colors.black54),
                              SizedBox(width: 8),
                              Text(
                                'Start Over',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        print('Accessibility tapped!');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_not_supported, color: Colors.black54),
                              SizedBox(width: 8),
                              Text(
                                'Accessibility',
                                style: TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
