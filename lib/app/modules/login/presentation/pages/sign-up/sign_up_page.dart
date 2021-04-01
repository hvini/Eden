import 'package:eden/app/modules/login/presentation/pages/sign-up/sign_up_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController> {
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
                  "Sign Up",
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
                          controller.setEmail(val);
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
                            controller.setPassword(val);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(children: [
                          ElevatedButton(
                            child: Text(
                              "Sign Up".toUpperCase(),
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen,
                              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                            ),
                            onPressed: controller.signUp,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(text: "Have an account? "),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Modular.to.pushNamed("/login");
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}