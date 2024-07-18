import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FrontScreen.dart';
import 'MenuScreen.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 200,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 0.0),
              child: Image.asset(
                'assets/logo.png',
                height: 120,
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
              ),
            ),
            Spacer(flex: 3,),
            Text(
              'View Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Spacer(flex: 5,),
            FloatingActionButton(
              onPressed: () {
                // Define the action to be taken when the button is pressed
                Navigator.pop(context);
              },
              child:Lottie.asset(
                'assets/addbutton.json',
                width: 120,
                height: 120,
                fit: BoxFit.fitWidth,
              ),
            ),
           SizedBox(width: 20,),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<Cart>(
                builder: (context, cart, child) => ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final CartItem cartItem = cart.items[index];
                    return Card(
                      child: ListTile(
                        leading: Image.asset(
                          cartItem.item.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartItem.item.name),
                        subtitle: Text('₹${cartItem.item.price.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cart.decreaseItem(cartItem.item);
                              },
                            ),
                            Container(
                                padding: EdgeInsets.all(16),
                                color: Colors.white,
                                child: Text(cartItem.quantity.toString(),style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.bold),)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cart.addItem(cartItem.item);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal: \₹${Provider.of<Cart>(context).subtotalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tax (5%): \₹${Provider.of<Cart>(context).taxAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600 ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Total: \₹${Provider.of<Cart>(context).totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.green.shade700,
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                        textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  padding: EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Lottie.asset(
                                        'assets/success.json',
                                        width: 150,
                                        height: 150,
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        'Order Placed successfully!',
                                        style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Provider.of<Cart>(context).clearCart();
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Frontscreen(),));
                                        },
                                        child: Text('OK', style: TextStyle(color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:Colors.green.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('Place Order',style: TextStyle(color: Colors.white,),),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),
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
