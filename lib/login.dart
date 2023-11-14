import 'package:flutter/material.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200.0,
                width: 250.0,
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        labelStyle("      Email"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: emailController,
                          decoration:
                          inputFieldDecoration("Enter your email")),
                    ),
                    Row(
                      children: [
                        labelStyle("      Password"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: passwordController,
                          obscureText: true,
                          decoration: inputFieldDecoration(
                              "Enter your password")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextButton(
                        onPressed: () {},
                        child: labelStyle("Forgot Password?", size: 16.0),
                      ),
                    ),
                    ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () async {
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
                height: 100,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
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
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
