import 'package:flutter/material.dart';

class AghaWidget extends StatefulWidget {
  const AghaWidget({Key? key}) : super(key: key);

  @override
  State<AghaWidget> createState() => _AghaWidgetState();
}

class _AghaWidgetState extends State<AghaWidget> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(),
    );
  }
}
