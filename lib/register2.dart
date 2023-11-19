import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:trainlink/home.dart';

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

  @override
  void dispose() {
    birthDateController.dispose();
    mobilePhoneController.dispose();
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        labelStyle(" Birth Date"),
                      ],
                    ),
                    TextFormField(
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
                    const SizedBox(height: 8),
                    buildDropdownWithTitle(
                      "Gender",
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
                        labelStyle(" Mobile Phone"),
                      ],
                    ),
                    TextFormField(
                      style: inputStyle(),
                      controller: mobilePhoneController,
                      decoration:
                        inputFieldDecoration("Enter your mobile phone", prefixIcon: Icons.phone),
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
                            )
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const Home()),
                            (route) => false,
                          );
                        },
                        label: buttonLabelStyle("Register"),
                        icon: const Icon(
                          Icons.add_circle,
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
