import 'package:ecommerce_application_test/views/dashboard_screen/dashboard_screen.dart';
import 'package:ecommerce_application_test/views/login_screen/Login_screen.dart';
import 'package:ecommerce_application_test/views/order_screen/order_form.dart';
import 'package:ecommerce_application_test/views/order_screen/order_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/cart_screen/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()), // Gestionnaire de panier existant
        ChangeNotifierProvider(create: (context) => OrderProvider()), // Nouveau gestionnaire de commandes
      ],
      child: MaterialApp(
        home: LoginScreen(),
        //home: DashboardScreen(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
      ),
    );
  }
}




