import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:eden/controllers/authentications.dart';
import 'package:eden/pages/loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleSignup() {
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      signUp(email.trim(), password, context).then((value) {
        if(value != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
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
              FlutterLogo(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Signup here",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.90,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field is required"),
                            MinLengthValidator(
                                6, errorText: "Minimum 6 characters required")
                          ]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      RaisedButton(
                        onPressed: handleSignup,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          "Sign up",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}