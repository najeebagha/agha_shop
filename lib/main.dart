import 'package:agha_shop/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/web_side/add_products_screen.dart';
import 'screens/web_side/dashboard_screen.dart';
import 'screens/web_side/deleteProducts_screen.dart';
import 'screens/web_side/update_product_screen.dart';
import 'screens/web_side/web_login.dart';
import 'screens/web_side/web_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: const WebLoginScreen(),
      routes: {
        WebLoginScreen.id: (context) => const WebLoginScreen(),
        WebMainScreen.id: (context) => const WebMainScreen(),
        AddProductScreen.id: (context) => const AddProductScreen(),
        UpdateProductScreen.id: (context) => const UpdateProductScreen(),
        DeleteProductScreen.id: (context) => const DeleteProductScreen(),
        DashBoardScreen.id: (context) => const DashBoardScreen(),
      },
    );
  }
}
