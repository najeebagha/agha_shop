import 'package:agha_shop/screens/auth_screens/login_screen.dart';
import 'package:agha_shop/screens/bottom_screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class FirebaseServices {
  static Future<DocumentSnapshot> adminSignIn(id) async {
    var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;
  }

  static Future<String?> createAccount(
    BuildContext context,
    String email,
    String password,
  ) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Signing Up'),
      message: const Text('Please wait'),
    );

    progressDialog.show();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
        progressDialog.dismiss();
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "email already in user";
      } else if (e.code == "weak-password") {
        return "password is too weak";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<String?> signInAccount(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password Not MaTCH")));
    }

    // request to firebase auth

    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Logging In'),
      message: const Text('Please wait'),
    );

    progressDialog.show();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        progressDialog.dismiss();
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
