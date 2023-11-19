import 'dart:io';

import 'package:flutter/material.dart';
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
                              labelStyle("24"),
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
                              labelStyle("Male"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  labelStyle("João Lázaro", size: 24.0, bold: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6.0),
                      labelStyle("lazaro0ntheroad@gmail.com"),
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
                      labelStyle("911111111"),
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
                      labelStyle("24-04-1999"),
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
            const SizedBox(height: 120.0),
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
