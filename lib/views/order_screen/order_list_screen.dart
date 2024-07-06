import 'package:ecommerce_application_test/consts/colors.dart';
import 'package:ecommerce_application_test/views/order_screen/order_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          List<Order> orders = orderProvider.orders;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      child: Icon(Icons.shopping_cart, color: Colors.green),
                    ),
                    title: Text(
                      'Order ID: ${order.id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Date: ${order.orderDate.toString()}'),
                        SizedBox(height: 5),
                        Text('Products:'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order.products.map((product) {
                            return Text('- ${product.name}');
                          }).toList(),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.green, size: 30.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



class OrderDetailScreen extends StatelessWidget {
  final Order order;

  OrderDetailScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Full Name: ${order.fullName}'),
            Text('Address: ${order.address}, ${order.city}'),
            Text('Phone Number: ${order.phoneNumber}'),
            Text('Payment Method: ${order.paymentMethod}'),
            Text('Order Date: ${order.orderDate.toString()}'),
            SizedBox(height: 16),
            Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: order.products.length,
                itemBuilder: (context, index) {
                  final product = order.products[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Image.asset(
                        product.image, // Assuming imageUrl is part of Product model
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text('Price: \$${product.price.toString()}'),
                      trailing: Text('Quantity: ${product.quantity}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
