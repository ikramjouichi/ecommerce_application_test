import 'package:ecommerce_application_test/views/order_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard_screen/dashboard_screen.dart'; // Assurez-vous que le chemin d'importation est correct pour votre classe Cart
import 'package:flutter/foundation.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  Cart cart = Cart(); // Initialisez votre gestionnaire de panier ici (ou utilisez Provider pour obtenir le panier)

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          Product product = cart.items[index];
          return ListTile(
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('\$${product.price.toStringAsFixed(2)}'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          cart.decreaseQuantity(product);
                        });
                      },
                    ),
                    Text('${product.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          cart.increaseQuantity(product);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Supprimer le produit du panier
                setState(() {
                  cart.removeFromCart(product);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} removed from cart'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total: \$${cart.totalAmount().toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  List<Product> productsInCart = cart.items;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderScreen(productsInCart: productsInCart)),
                  );
                },
                child: Text('Proceed to Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cart extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;

  void addToCart(Product product) {
    // Vérifier si le produit existe déjà dans le panier
    int index = _items.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _items[index].quantity++; // Augmenter la quantité si le produit est déjà dans le panier
    } else {
      _items.add(product); // Ajouter le produit au panier s'il n'existe pas encore
    }
    notifyListeners(); // Notifie les écouteurs du changement
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    notifyListeners(); // Notifie les écouteurs du changement
  }

  void increaseQuantity(Product product) {
    int index = _items.indexOf(product);
    _items[index].quantity++;
    notifyListeners(); // Notifie les écouteurs du changement
  }

  void decreaseQuantity(Product product) {
    int index = _items.indexOf(product);
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners(); // Notifie les écouteurs du changement
    }
  }

  double totalAmount() {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity; // Calculer le montant total en tenant compte de la quantité
    }
    return total;
  }
}

