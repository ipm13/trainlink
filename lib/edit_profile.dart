import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'image_widget.dart';
import 'utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  String? selectedGenderValue;
  File? image;

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    mobilePhoneController.dispose();
    super.dispose();
  }

  bool validateFields() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundDecoration(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWidget(
                  image: image,
                  defaultImagePath: 'assets/images/profile.png',
                  size: 130,
                  onClicked: (source) => pickImage(source),
                ),
                buildInputWithTitle(
                  "Name",
                  inputFieldDecoration("Enter a new name"),
                  nameController,
                ),
                const SizedBox(height: 20.0),
                buildDropdownWithTitle(
                  "Gender",
                  Text("Pick a new gender", style: inputStyle()),
                  ["Male", "Female", "Other"],
                  selectedGenderValue,
                      (String? selectedValue) {
                    setState(() {
                      selectedGenderValue = selectedValue;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                buildInputWithTitle(
                  "Birthday",
                  inputFieldDecoration("Enter a new birth date"),
                  birthDateController,
                ),
                const SizedBox(height: 20.0),
                buildInputWithTitle(
                  "Mobile Phone",
                  inputFieldDecoration("Enter a new phone number"),
                  mobilePhoneController,
                ),
                const SizedBox(height: 80.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (validateFields()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarStyle("Successfully edited your profile")
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarStyle("No changes detected", warning: true)
                        );
                      }
                    },
                    style: flatButtonStyle,
                    child: labelStyle("Confirm", size: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomBar(context, 3),
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
