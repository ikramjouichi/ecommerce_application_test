import 'package:ecommerce_application_test/views/dashboard_screen/dashboard_screen.dart';
import 'package:ecommerce_application_test/views/order_screen/order_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderForm extends StatefulWidget {
  final List<Product> productsInCart;

  OrderForm({required this.productsInCart});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _paymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(labelText: 'Full Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _paymentMethod,
            decoration: InputDecoration(labelText: 'Payment Method'),
            items: ['Cash on Delivery', 'Credit Card'].map((String method) {
              return DropdownMenuItem<String>(
                value: method,
                child: Text(method),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _paymentMethod = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose a payment method';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              int orderId = DateTime.now().millisecondsSinceEpoch;
              DateTime orderDate = DateTime.now();

              Order order = Order(
                id: orderId,
                fullName: _fullNameController.text,
                address: _addressController.text,
                city: _cityController.text,
                phoneNumber: _phoneNumberController.text,
                paymentMethod: _paymentMethod,
                orderDate: orderDate,
                products: widget.productsInCart,
              );

              Provider.of<OrderProvider>(context, listen: false).addOrder(order);

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Order Confirmation'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thank you for your order, ${order.fullName}!'),
                        SizedBox(height: 16),
                        Text('Your order details:'),
                        Text('ID: ${order.id}'),
                        Text('Date: ${order.orderDate}'),
                        Text('Address: ${order.address}, ${order.city}'),
                        Text('Phone Number: ${order.phoneNumber}'),
                        Text('Payment Method: ${order.paymentMethod}'),
                        Text('Products:'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order.products.map((product) {
                            return Text('- ${product.name}');
                          }).toList(),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Ferme la boîte de dialogue
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Submit Order'),
        ),

        ],
      ),
    );
  }
}



class Order extends ChangeNotifier {

  int id;
  String fullName;
  String address;
  String city;
  String phoneNumber;
  String paymentMethod;
  DateTime orderDate;
  List<Product> products;

  Order({
    required this.id,
    required this.fullName,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.paymentMethod,
    required this.orderDate,
    required this.products,
  });

}
class OrderProvider extends ChangeNotifier {
  List<Order> _orders = []; // Liste locale des commandes

  List<Order> get orders => _orders;

  // Méthode pour ajouter une commande
  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}