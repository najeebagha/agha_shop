import 'package:flutter/material.dart';

import 'agha_button.dart';

class AghaDialogue extends StatelessWidget {
  final String? title;
  const AghaDialogue({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        AghaButton(
          title: 'CLOSE',
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
