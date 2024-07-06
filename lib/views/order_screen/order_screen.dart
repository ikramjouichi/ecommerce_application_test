import 'package:ecommerce_application_test/consts/const.dart';
import 'package:ecommerce_application_test/views/dashboard_screen/dashboard_screen.dart';
import 'package:ecommerce_application_test/views/order_screen/order_form.dart';

class OrderScreen extends StatelessWidget {
  final List<Product> productsInCart;

  OrderScreen({required this.productsInCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrderForm(productsInCart: productsInCart),
      ),
    );
  }
}


