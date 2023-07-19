import 'package:flutter_shopping_app/Constants/Constants.dart';
import 'package:flutter_shopping_app/common/custom_button.dart';
import 'package:flutter_shopping_app/common/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String screenName = "/auth-screen";
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        CustomTextField(
                            hintText: "Name",
                            controller: _nameController,
                            callback: (value) {
                              _signUpFormKey.currentState!.validate();
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: "Email",
                            controller: _emailController,
                            callback: (value) {
                              _signUpFormKey.currentState!.validate();
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: "Password",
                            controller: _passwordController,
                            callback: (value) {
                              _signUpFormKey.currentState!.validate();
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "Sign up",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_signUpFormKey.currentState!.validate()) {
                              _authService.signupUser(
                                  context: context,
                                  username: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
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
                      children: [
                        CustomTextField(
                            hintText: "Email",
                            controller: _emailController,
                            callback: (value) {
                              _signInFormKey.currentState!.validate();
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: "Password",
                            controller: _passwordController,
                            callback: (value) {
                              _signInFormKey.currentState!.validate();
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: "Sign in",
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              // if (_signInFormKey.currentState!.validate()) {
                              //TODO: Remove this before commit;
                              _authService.signinUser(
                                  context: context,
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            })
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
