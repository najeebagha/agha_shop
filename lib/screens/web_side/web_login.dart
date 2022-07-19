import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/agha_button.dart';
import '../../widgets/agha_dialogue.dart';
import '../../widgets/agha_textfield.dart';
import 'web_main.dart';

class WebLoginScreen extends StatefulWidget {
  static const String id = "weblogin";

  const WebLoginScreen({Key? key}) : super(key: key);
  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  // const WebLoginScreen({Key? key}) : super(key: key);
  TextEditingController userNameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirebaseServices.adminSignIn(userNameC.text).then((value) async {
        if (value['username'] == userNameC.text &&
            value['password'] == passwordC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            // ignore: unnecessary_null_comparison
            if (user != null) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, WebMainScreen.id);
            }
          } catch (e) {
            setState(() {
              formStateLoading = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return AghaDialogue(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "WELCOME ADMIN",
                      style: AghaStyle.boldStyle,
                    ),
                    const Text(
                      "Log in to your Account",
                      style: AghaStyle.boldStyle,
                    ),
                    AghaTextField(
                      controller: userNameC,
                      hintText: "UserName...",
                      maxLines: 1,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "email should not be empty";
                        }
                        return null;
                      },
                    ),
                    AghaTextField(
                      controller: passwordC,
                      isPassowrd: true,
                      maxLines: 1,
                      hintText: "Password...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "password should not be empty";
                        }
                        return null;
                      },
                    ),
                    AghaButton(
                      isLoginButton: true,
                      isLoading: formStateLoading,
                      onPress: () {
                        submit(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
