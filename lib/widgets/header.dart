import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  String? title;
  Header({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        title!,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
