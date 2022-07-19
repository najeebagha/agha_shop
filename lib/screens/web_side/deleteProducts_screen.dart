// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({Key? key}) : super(key: key);
  static const String id = "deleteproduct";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "DELETE PRODUCT",
        style: AghaStyle.boldStyle,
      ),
    );
  }
}
