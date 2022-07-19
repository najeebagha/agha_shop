import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'add_products_screen.dart';
import 'dashboard_screen.dart';
import 'deleteProducts_screen.dart';
import 'update_product_screen.dart';

class WebMainScreen extends StatefulWidget {
  const WebMainScreen({Key? key}) : super(key: key);
  static const String id = "webmain";

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedSCreen = const DashBoardScreen();

  chooseScreens(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          selectedSCreen = const DashBoardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedSCreen = const AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedSCreen = const UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedSCreen = const DeleteProductScreen();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("ADMIN"),
        ),
        sideBar: SideBar(
            backgroundColor: Colors.black,
            textStyle: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
            onSelected: (item) {
              chooseScreens(item);
            },
            items: const [
              AdminMenuItem(
                title: "DASHBOARD",
                icon: Icons.dashboard,
                route: DashBoardScreen.id,
              ),
              AdminMenuItem(
                title: "ADD PRODUCTS",
                icon: Icons.add,
                route: AddProductScreen.id,
              ),
              AdminMenuItem(
                title: "UPDATE PRODUCTS",
                icon: Icons.update,
                route: UpdateProductScreen.id,
              ),
              AdminMenuItem(
                title: "DELETE PRODUCTS",
                icon: Icons.delete,
                route: DeleteProductScreen.id,
              ),
              AdminMenuItem(
                title: "CART ITEMS",
                icon: Icons.shop,
              ),
            ],
            selectedRoute: WebMainScreen.id),
        body: selectedSCreen);
  }
}
