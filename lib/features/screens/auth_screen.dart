import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/common/CustomTextField.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val ?? Auth.signup;
                      });
                    },
                  ),
                  const Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (_auth == Auth.signup)
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: const [
                      CustomTextField(
                        hintText: "Name",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Email",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val ?? Auth.signin;
                      });
                    },
                  ),
                  const Text(
                    "Sign in",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (_auth == Auth.signin)
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: const [
                      CustomTextField(
                        hintText: "Email",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        )));
  }
}
