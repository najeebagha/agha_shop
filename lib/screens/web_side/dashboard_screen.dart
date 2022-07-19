import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class DashBoardScreen extends StatelessWidget {
  // const DashBoardScreen({Key? key}) : super(key: key);
  static const String id = "dashboard";

  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "DASHBOARD",
        style: AghaStyle.boldStyle,
      ),
    );
  }
}
