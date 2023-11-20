import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/singleton.dart';

import 'home.dart';
import 'utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  void _setPlayer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('photo', "default");
      prefs.setString('name', playerDefault.name);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('birthdate', playerDefault.birthDate);
      prefs.setString('gender', playerDefault.gender);
      prefs.setString('phone', playerDefault.mobilePhone);
      prefs.setString('role', playerDefault.role);
    });
  }

  void _setCoach() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('photo', "default");
      prefs.setString('name', coachDefault.name);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('birthdate', coachDefault.birthDate);
      prefs.setString('gender', coachDefault.gender);
      prefs.setString('phone', coachDefault.mobilePhone);
      prefs.setString('role', coachDefault.role);
    });
  }

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200.0,
                width: 250.0,
                padding: const EdgeInsets.only(top: 120),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    Row(
                      children: [
                        labelStyle(" Email"),
                      ],
                    ),
                    TextFormField(
                      style: inputStyle(),
                      controller: emailController,
                      decoration:
                      inputFieldDecoration("Enter your email", prefixIcon: Icons.email),
                      validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    Row(
                      children: [
                        labelStyle(" Password"),
                      ],
                    ),
                    TextFormField(
                      style: inputStyle(),
                      controller: passwordController,
                      obscureText: true,
                      decoration: inputFieldDecoration("Enter your password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off),
                      validator: (value) => value!.length > 1 ? null : "Please enter a valid password",
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarStyle("Enter an email and a password")
                        );
                      },
                      child: labelStyle("Forgot Password?", size: 16.0),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (playerDefault.email == emailController.text && playerDefault.password == passwordController.text) {
                            _setPlayer();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const Home()), (route) => false,
                            );
                          } else {
                            if (coachDefault.email == emailController.text && coachDefault.password == passwordController.text) {
                              _setCoach();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => const Home()), (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarStyle("Invalid login credentials", warning: true)
                              );
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarStyle("Invalid login credentials", warning: true)
                          );
                        }
                      },
                      child: labelStyle("Sign In"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/role');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      labelStyle("Don't have an account?", size: 16.0),
                      labelStyle(" Sign up", size: 16.0, green: true),
                    ],
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}
