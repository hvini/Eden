import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

showErrorDialog(BuildContext context, String err) {
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

Future<User> signIn(String email, String password, BuildContext context) async {
  try {
    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return Future.value(user);
  } on FirebaseAuthException catch(error) {
    switch(error.code) {
      case 'invalid-email':
        showErrorDialog(context, "Invalid email address");
        break;
      case 'wrong-password':
        showErrorDialog(context, "Invalid password");
        break;
      case 'user-not-found':
        showErrorDialog(context, "User not found");
        break;
      case 'user-disabled':
        showErrorDialog(context, "User disabled");
        break;
    }
    return Future.value(null);
  }
}

Future<User> signUp(String email, String password, BuildContext context) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return Future.value(user);
  } on FirebaseAuthException catch(error) {
    switch(error.code) {
      case 'email-already-in-use':
        showErrorDialog(context, "Email already exists");
        break;
      case 'invalid-email':
        showErrorDialog(context, "Invalid email address");
        break;
      case 'weak-password':
        showErrorDialog(context, "Please choose a stronger password");
        break;
    }
    return Future.value(null);
  }
}