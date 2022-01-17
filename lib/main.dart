
import 'package:agri_app/login_register.dart';
import 'package:agri_app/provider/check_out_provider.dart';
import 'package:agri_app/provider/customer_orders.dart';
import 'package:agri_app/provider/notification_provider.dart';
import 'package:agri_app/provider/order_provider.dart';
import 'package:agri_app/provider/product_provider.dart';
import 'package:agri_app/provider/review_cart_provider.dart';
import 'package:agri_app/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ReviewProvider>(
          create: (context) => ReviewProvider(),
        ),
        ChangeNotifierProvider< CheckoutProvider>(
          create: (context) =>  CheckoutProvider(),
        ),
        ChangeNotifierProvider<OrdersProvider>(
          create: (context) =>  OrdersProvider(),
        ),
        ChangeNotifierProvider<CustomerOrdersProvider>(
          create: (context) =>  CustomerOrdersProvider(),
        ),
        ChangeNotifierProvider<Notification_provider>(
          create: (context) => Notification_provider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: AuthPage(),
      ),
    );
  }
}


