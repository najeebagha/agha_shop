import 'package:agha_shop/screens/bottom_screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_screens/cart_screen.dart';
import 'bottom_screens/favourite_screen.dart';
import 'bottom_screens/home_screen.dart';
import 'bottom_screens/product_screen.dart';

class BottomPage extends StatelessWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shop)),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: HomeScreen());
              }));
            case 1:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(
                    child: ProductScreen(
                  category: '',
                ));
              }));
            case 2:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: CartScreen());
              }));
            case 3:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: FavouriteScreen());
              }));
            case 4:
              return CupertinoTabView(builder: ((context) {
                return const CupertinoPageScaffold(child: ProfileScreen());
              }));

            default:
          }
          return const HomeScreen();
        });
  }
}
