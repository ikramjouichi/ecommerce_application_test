import 'dart:convert';
import 'package:ecommerce_application_test/consts/colors.dart';
import 'package:ecommerce_application_test/consts/const.dart';
import 'package:ecommerce_application_test/controllers/auth.dart';
import 'package:ecommerce_application_test/views/cart_screen/cart_screen.dart';
import 'package:ecommerce_application_test/views/order_screen/order_form.dart';
import 'package:ecommerce_application_test/views/order_screen/order_list_screen.dart';
import 'package:ecommerce_application_test/views/product_screen/product_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';


class Product {
  final int id;
  final String name;
  final String image;
  final double rating;
  final int numReviews;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.numReviews,
    required this.price,
    this.quantity = 1
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final Auth _auth = Auth();

  late List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      String data = await rootBundle.loadString('assets/products.json');
      List<dynamic> jsonList = jsonDecode(data);
      List<Product> loadedProducts = jsonList.map((json) => Product(
            id: json['id'],
            name: json['name'],
            image: json['image'],
            rating: json['rating'].toDouble(),
            numReviews: json['numReviews'],
            price: json['price'].toDouble(),
          )).toList();

      setState(() {
        products = loadedProducts;
      });
    } catch (e) {
      print('Erreur lors du chargement des produits: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavItem(Icons.home_filled, "Home"),
              buildNavItem(Icons.wallet, "Wallet"),
              buildNavItem(Icons.shopping_cart, "Cart"),
              buildNavItem(Icons.settings, "Settings"),
            ],
          ),
        ),
      ),
      */
      backgroundColor: Color(0xFFE9EBEA),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 18.0, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 170,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, size: 40, color: Colors.grey),
                          hintText: 'Search..',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToCartScreen(),
                          ),
                        );
                      },
                      child: Consumer<Cart>(
                        builder: (context, cart, child) => Badge(
                          label: Text(
                            cart.items.length.toString(), 
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(Icons.shopping_cart, size: 40, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderListScreen(),
                          ),
                        );
                      },
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, child) => Badge(
                          label:  Text(
                            orderProvider.orders.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(Icons.assignment, size: 40, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        _auth.signOut(context); // Appel à la méthode de déconnexion
                      },
                      child: Icon(Icons.logout_rounded, size: 40, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Image.asset(solde4, height: 200),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Best Sale Products', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                    Text('See more', style: TextStyle(fontSize: 17, color: green)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 225 / 260, 
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: products[index]),
                        ),
                      );
                    },
                    child: Container(
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              child: Image.asset(
                                products[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.orange, size: 18),
                                    SizedBox(width: 4),
                                    Text(
                                      '${products[index].rating} | ${products[index].numReviews}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${products[index].price.toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 22),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
