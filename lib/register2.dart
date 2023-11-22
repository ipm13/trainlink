import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/home.dart';
import 'package:trainlink/singleton.dart';

import 'utils.dart';

class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final _formKey = GlobalKey<FormState>();

  final birthDateController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  String? selectedGenderValue;

  UserDTO? user;

  @override
  void dispose() {
    birthDateController.dispose();
    mobilePhoneController.dispose();
    super.dispose();
  }

  void _setUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('birthdate', birthDateController.text);
      prefs.setString('gender', selectedGenderValue!);
      prefs.setString('phone', mobilePhoneController.text);
    });
  }

  void _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = UserDTO(
        prefs.getString('name')!,
        prefs.getString('email')!,
        prefs.getString('password')!,
        prefs.getString('birthdate')!,
        prefs.getString('gender')!,
        prefs.getString('phone')!,
        prefs.getString('role')!,
        prefs.getString('photo')!
    );
    Singleton().createUser(user!);
  }

  bool validateGender() {
    if (selectedGenderValue == null || selectedGenderValue!.isEmpty) {
      return false;
    }
    return true;
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        labelStyle(" Birth Date *"),
                      ],
                    ),
                    TextFormField(
                      style: inputStyle(),
                      controller: birthDateController,
                      decoration: inputFieldDecoration("Enter your birth date", prefixIcon: Icons.calendar_month),
                      validator: (value) => value!.isNotEmpty ? null : "Please enter a birth date",
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
                    const SizedBox(height: 8),
                    buildDropdownWithTitle(
                      "Gender *",
                      const Text("Choose your gender"),
                      ["Male", "Female", "Other"],
                      selectedGenderValue,
                      (String? selectedValue) {
                        setState(() {
                          selectedGenderValue = selectedValue;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        labelStyle(" Mobile Phone *"),
                      ],
                    ),
                    TextFormField(
                      style: inputStyle(),
                      controller: mobilePhoneController,
                      decoration: inputFieldDecoration("Enter your mobile phone", prefixIcon: Icons.phone),
                      validator: (value) => value!.length == 9 ? null : "Please enter a 9-digit number",
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(24, 231, 114, 1.0)
                            ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (validateGender()) {
                              _setUser();
                              _getUser();
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarStyle("Account successfully created")
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const Home()), (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarStyle("Invalid credentials", warning: true)
                              );
                            }
                          }
                        },
                        label: buttonLabelStyle("Register"),
                        icon: const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
