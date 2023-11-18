import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          padding: EdgeInsets.symmetric(horizontal: 30),
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
                    Padding(padding: EdgeInsets.only(bottom: 20)),
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
                      validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: labelStyle("Forgot Password?", size: 16.0),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Home()),
                          (route) => false,
                        );
                        /*
                    if (_formKey.currentState!.validate()) {
                      String email = emailController.text;
                      String password = passwordController.text;
                      await getAccount(email, password).then((value) {
                        if (!value){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Your credentials are incorrect")));
                        }else{
                          Navigator.of(context).pushReplacementNamed('/profiles');
                        }
                      });
                    }*/
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
