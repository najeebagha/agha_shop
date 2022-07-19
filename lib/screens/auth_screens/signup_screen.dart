import 'package:agha_shop/services/firebase_services.dart';
import 'package:agha_shop/utils/styles.dart';
import 'package:agha_shop/widgets/agha_button.dart';
import 'package:agha_shop/widgets/agha_textfield.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameCont = TextEditingController();

  var emailCont = TextEditingController();

  var passCont = TextEditingController();

  var rePassCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("SignUp Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const Text(
              'Please Sign Up',
              style: AghaStyle.boldStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            AghaTextField(
              controller: nameCont,
              validate: validat,
              hintText: "User Name",
            ),
            AghaTextField(
              controller: emailCont,
              validate: validat,
              hintText: "Email",
            ),
            AghaTextField(
              validate: validat,
              controller: passCont,
              hintText: "Password",
            ),
            AghaTextField(
              validate: validat,
              controller: rePassCont,
              hintText: "Retype Password",
            ),
            const SizedBox(
              height: 30,
            ),
            AghaButton(
                onPress: () {
                  if (!emailCont.text.contains('@')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Email bad Format")));
                    return;
                  }
                  if (passCont.text != rePassCont.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password Not MaTCH")));
                    return;
                  } else {
                    FirebaseServices.createAccount(
                        context, emailCont.text, rePassCont.text);
                  }
                },
                title: "Sign Up"),
            const SizedBox(
              height: 50,
            ),
            AghaButton(
                onPress: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
                title: "Back to Login Page"),
          ]),
        ),
      ),
    );
  }

  String? validat(String? txt) {
    if (txt!.isEmpty) {
      return "Please Provide Info";
    }
    return null;
  }
}
