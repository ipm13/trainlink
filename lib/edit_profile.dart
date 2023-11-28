import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/profile.dart';

import 'image_widget.dart';
import 'utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  File? image;

  SharedPreferences? prefs;
  String? _user;
  String? _gender;
  String? _birthdate;
  String? _phone;
  String? _photo;
  bool isCoach = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs!.getString('role') == "Coach" ? isCoach = true : isCoach = false;
      _user = prefs!.getString('name')!;
      _gender = prefs!.getString('gender')!;
      _birthdate = prefs!.getString('birthdate')!;
      _phone = prefs!.getString('phone')!;
      _photo = prefs!.getString('photo');
    });
  }

  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  String? selectedGenderValue;

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    mobilePhoneController.dispose();
    super.dispose();
  }

  bool validateFields() {
    bool toReturn = false;
    if (nameController.text.isNotEmpty && nameController.text != _user) {
      prefs!.setString('name', nameController.text);
      toReturn = true;
    }
    if (selectedGenderValue != null && selectedGenderValue!.isNotEmpty && selectedGenderValue != _gender) {
      prefs!.setString('gender', selectedGenderValue!);
      toReturn = true;
    }
    if (birthDateController.text.isNotEmpty && birthDateController.text != _birthdate) {
      prefs!.setString('birthdate', birthDateController.text);
      toReturn = true;
    }
    if (mobilePhoneController.text.isNotEmpty && mobilePhoneController.text.length == 9 && mobilePhoneController.text != _phone) {
      prefs!.setString('phone', mobilePhoneController.text);
      toReturn = true;
    }
    if (image != null && image?.path != _photo) {
      prefs!.setString('photo', image!.path);
      toReturn = true;
    }
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    File? img;
    if (image != null || _photo == "default" || _photo == null) {
      img = image;
    } else {
      img = File(_photo!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageWidget(
                    image: img,
                    defaultImagePath: 'assets/images/profile.png',
                    size: 130,
                    onClicked: (source) => pickImage(source),
                  ),
                  buildInputWithTitle(
                    "Name",
                    inputFieldDecoration(_user ?? "", prefixIcon: Icons.person),
                    nameController,
                    charLimit: 20,
                  ),
                  const SizedBox(height: 20.0),
                  buildDropdownWithTitle(
                    "Gender",
                    Text(_gender ?? "", style: inputStyle()),
                    ["Male", "Female", "Other"],
                    selectedGenderValue,
                    (String? selectedValue) {
                      setState(() {
                        selectedGenderValue = selectedValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      labelStyle(" Birth Date"),
                    ],
                  ),
                  TextFormField(
                    style: inputStyle(),
                    controller: birthDateController,
                    decoration: inputFieldDecoration(_birthdate ?? "", prefixIcon: Icons.calendar_month),
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
                  const SizedBox(height: 20.0),
                  buildInputWithTitle(
                    "Mobile Phone",
                    inputFieldDecoration(_phone ?? "", prefixIcon: Icons.phone),
                    mobilePhoneController,
                    charLimit: 9,
                  ),
                  const SizedBox(height: 40.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateFields()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarStyle("Successfully edited your profile"));
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const Profile()), (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarStyle("No changes detected", warning: true));
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
      ),
        bottomNavigationBar: isCoach ? bottomBarCoach(context, 3) : bottomBarPlayer(context, 2)
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
