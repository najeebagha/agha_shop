import 'package:flutter/cupertino.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required String category}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('ProductScreen'));
  }
}
