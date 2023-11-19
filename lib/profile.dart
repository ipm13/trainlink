import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'image_widget.dart';
import 'utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;

  String? _user;
  String? _email;
  String? _phone;
  String? _birthdate;
  String? _gender;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = prefs.getString('name')!;
      _email = prefs.getString('email')!;
      _phone = prefs.getString('phone')!;
      _birthdate = prefs.getString('birthdate')!;
      _gender = prefs.getString('gender')!;
    });
  }

  int calculateAge() {
    DateTime birthDate = DateFormat('dd MMMM yyyy').parse(_birthdate!);
    Duration diff = DateTime.now().difference(birthDate);
    return (diff.inDays / 365).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            const SizedBox(height: 40.0),
            labelStyle("My Profile", size: 24.0, bold: true),
            const SizedBox(height: 100.0),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 80.0,
                          child: Column(
                            children: [
                              labelStyle("Age", size: 20.0, bold: true),
                              labelStyle(calculateAge().toString()),
                            ],
                          ),
                        ),
                        ImageWidget(
                          image: image,
                          defaultImagePath: 'assets/images/profile.png',
                          size: 130.0,
                        ),
                        SizedBox(
                          width: 80.0,
                          child: Column(
                            children: [
                              labelStyle("Gender", size: 20.0, bold: true),
                              labelStyle("$_gender"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  labelStyle("$_user", size: 24.0, bold: true),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6.0),
                      labelStyle("$_email"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6.0),
                      labelStyle("$_phone"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cake_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6.0),
                      labelStyle("$_birthdate"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 160.0,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(24, 231, 114, 1.0)
                          )
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/editProfile');
                      },
                      icon: const Icon(
                        Icons.edit_note_sharp,
                        color: Colors.black54,
                      ),
                      label: buttonLabelStyle("Edit Profile"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 110.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 17.0, 17.0),
                    child: SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          logout();
                        },
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Color.fromRGBO(24, 231, 114, 1.0),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(context, 3),
    );
  }

  void logout() {
    Navigator.of(context).pushNamed('/login');
  }
}
