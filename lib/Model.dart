class MenuItem {
  final String name;
  final double price;
  final String image; // Path to the image asset

  MenuItem({required this.name, required this.price, required this.image});
}

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});
}