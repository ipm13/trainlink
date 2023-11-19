import 'dart:io';

import 'package:flutter/foundation.dart';
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
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
                            labelStyle(" Name"),
                          ],
                        ),
                        TextFormField(
                            style: inputStyle(),
                            controller: nameController,
                            decoration:
                            inputFieldDecoration("Enter your name", prefixIcon: Icons.person)
                        ),
                        const SizedBox(height: 8),
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
                          //validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                        ),
                        const SizedBox(height: 8),
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
                          //validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            labelStyle(" Confirm Password"),
                          ],
                        ),
                        TextFormField(
                          style: inputStyle(),
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: inputFieldDecoration("Confirm your password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off),
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
                              _setUser();
                              Navigator.of(context).pushNamed('/register2');
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
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

}
