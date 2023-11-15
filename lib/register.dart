import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

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
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final mobilePhoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                    Row(
                      children: [
                        labelStyle("      Name"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: nameController,
                          decoration:
                          inputFieldDecoration("Enter your name", prefixIcon: Icons.person)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      children: [
                        labelStyle("      Email"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: emailController,
                          decoration:
                            inputFieldDecoration("Enter your email", prefixIcon: Icons.email),
                          validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      children: [
                        labelStyle("      Password"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: passwordController,
                          obscureText: true,
                          decoration: inputFieldDecoration("Enter your password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off),
                          validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      children: [
                        labelStyle("      Confirm Password"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: inputFieldDecoration("Confirm your password", prefixIcon: Icons.lock, suffixIcon: Icons.visibility_off),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      children: [
                        labelStyle("      Birth Date"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: birthDateController,
                          decoration:
                            inputFieldDecoration("Enter your birth date", prefixIcon: Icons.calendar_month),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime.now().subtract(const Duration(days: 100 * 365)),
                                lastDate: DateTime.now()
                            );
                            if (pickedDate != null) {
                              birthDateController.text = DateFormat('dd MMMM yyyy').format(pickedDate);
                            }
                          },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      children: [
                        labelStyle("      Gender"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: genderController,
                          decoration:
                          inputFieldDecoration("Choose your gender", prefixIcon: Icons.male, suffixIcon: Icons.arrow_drop_down)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      children: [
                        labelStyle("      Mobile Phone"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                          style: inputStyle(),
                          controller: mobilePhoneController,
                          decoration:
                            inputFieldDecoration("Enter your mobile phone", prefixIcon: Icons.phone),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () async {
                        Navigator.of(context).pushReplacementNamed('/home');
                      },
                      child: labelStyle("Register"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
