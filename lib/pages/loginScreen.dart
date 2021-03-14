import 'package:eden/pages/feedScreen.dart';
import 'package:eden/pages/signupScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eden/controllers/authentications.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() {
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      signIn(email, password, context).then((value) {
        if(value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => FeedScreen(uid: value.uid)
              ));
          }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FlutterLogo(
                  size: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 30.0
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "This field is required"),
                            EmailValidator(errorText: "Invalid email address"),
                          ]),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Password is required"),
                              MinLengthValidator(6, errorText: "Minimum 6 character required"),
                            ]),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                        ),
                        RaisedButton(
                          onPressed: login,
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Text(
                            "Login",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}