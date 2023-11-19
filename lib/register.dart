import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/image_widget.dart';

import 'utils.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? image;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _setUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('name', nameController.text);
      prefs.setString('email', emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        decoration: backgroundDecoration(),
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                children: [
                  const SizedBox(height: 20),
                  labelStyle("Profile Photo"),
                  const SizedBox(height: 8),
                  ImageWidget(
                    image: image,
                    defaultImagePath: 'assets/images/profile.png',
                    size: 130,
                    onClicked: (source) => pickImage(source),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            labelStyle(" Name *"),
                          ],
                        ),
                        TextFormField(
                          style: inputStyle(),
                          controller: nameController,
                          decoration: inputFieldDecoration("Enter your name", prefixIcon: Icons.person),
                          validator: (value) => value!.length > 1 ? null : "Name is too short",
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            labelStyle(" Email *"),
                          ],
                        ),
                        TextFormField(
                          style: inputStyle(),
                          controller: emailController,
                          decoration:
                          inputFieldDecoration("Enter your email", prefixIcon: Icons.email),
                          validator: (value) => EmailValidator.validate(value!) ? null : "Email is not valid",
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            labelStyle(" Password *"),
                          ],
                        ),
                        TextFormField(
                          style: inputStyle(),
                          controller: passwordController,
                          obscureText: true,
                          decoration: inputFieldDecoration("Enter your password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off),
                          validator: (value) => value!.length > 1 ? null : "Please enter a stronger password",
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            labelStyle(" Confirm Password *"),
                          ],
                        ),
                        TextFormField(
                          style: inputStyle(),
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: inputFieldDecoration("Confirm your password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off),
                          validator: (value) => value! == passwordController.text ? null : "Password mismatch",
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 40)),
                        SizedBox(
                          width: 180,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(24, 231, 114, 1.0)
                                )
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _setUser();
                                Navigator.of(context).pushNamed('/register2');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarStyle("Invalid credentials", warning: true)
                                );
                              }
                            },
                            label: buttonLabelStyle("Next"),
                            icon: const Icon(
                              Icons.navigate_next,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

}
