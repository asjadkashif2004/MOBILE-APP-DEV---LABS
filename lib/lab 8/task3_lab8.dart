import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

// ===== MODEL =====
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

// ===== CONTROLLER =====
class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price);
}

// ===== MAIN UI =====
class MyApp extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  final List<Product> products = [
    Product(id: 1, name: 'Apple', price: 1.99),
    Product(id: 2, name: 'Banana', price: 0.99),
    Product(id: 3, name: 'Grapes', price: 2.49),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shopping Cart with GetX',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Get.to(() => CartPage()),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);
                  Get.snackbar('Added', '${product.name} added to cart');
                },
                child: Text('Add'),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ===== CART PAGE =====
class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          cartController.removeFromCart(item);
                        },
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
