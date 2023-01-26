import 'package:amazon_clone/Constants/Constants.dart';
import 'package:amazon_clone/common/custom_button.dart';
import 'package:amazon_clone/common/custom_text_field.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Container(
                color: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                child: Row(
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
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        const CustomTextField(
                          hintText: "Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomTextField(
                          hintText: "Email",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomTextField(
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "Login",
                          onTap: () {},
                          color: GlobalVariables.secondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              Container(
                color: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                child: Row(
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
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
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
                ),
            ],
          ),
        )));
  }
}

void onTap() {}
