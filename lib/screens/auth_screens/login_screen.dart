import 'package:agha_shop/screens/auth_screens/signup_screen.dart';
import 'package:agha_shop/services/firebase_services.dart';
import 'package:agha_shop/utils/styles.dart';
import 'package:agha_shop/widgets/agha_button.dart';
import 'package:agha_shop/widgets/agha_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailCont = TextEditingController();
  var passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login Screen"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const Text(
                'Please Login',
                style: AghaStyle.boldStyle,
              ),
              const SizedBox(
                height: 15,
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
              const SizedBox(
                height: 30,
              ),
              AghaButton(
                  isLoginButton: true,
                  onPress: () {
                    if (emailCont.text.isEmpty) {
                      return;
                    }
                    if (passCont.text.isEmpty) {
                      return;
                    }
                    FirebaseServices.signInAccount(
                        context, emailCont.text.trim(), passCont.text.trim());
                  },
                  title: "Log in"),
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Dont have an account ??  Signup",
              ),
              const SizedBox(
                height: 140,
              ),
              AghaButton(
                  isLoginButton: false,
                  onPress: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SignUpScreen();
                    }));
                  },
                  title: "Sign Up")
            ]),
          ),
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
