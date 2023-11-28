import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/singleton.dart';

import 'image_widget.dart';
import 'utils.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {

  bool isCoach = false;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getString('role')! == "Coach" ? isCoach = true : isCoach = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var team = getTeam();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Menu'),
        centerTitle: true,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140.0,
              width: 250.0,
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWidget(
                    image: team.logoPath != null ? File(team.logoPath!) : null,
                    defaultImagePath: 'assets/images/gallery.png',
                    size: 80,
                  ),
                  const SizedBox(height: 6),
                  labelStyle(team.name, size: 22.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: labelStyle("Invitation Code", size: 20, bold: true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          labelStyle(team.code),
                          IconButton(
                              icon: const Image(
                                  image: AssetImage("assets/images/copy.png")
                              ),
                              onPressed: () async {
                                Clipboard.setData(
                                    ClipboardData(text: team.code)
                                ).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBarStyle("Team code copied to clipboard")
                                  );
                                });
                              }
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            labelStyle("Modality", size: 20, bold: true),
            const SizedBox(
                height: 6,
            ),
            labelStyle(team.modality),
            const SizedBox(
              height: 10,
            ),
            labelStyle("Coach", size: 20, bold: true),
            const SizedBox(
              height: 6,
            ),
            labelStyle(team.coachName),
            const SizedBox(
              height: 10,
            ),
            labelStyle("Players", size: 20, bold: true),
            const CustomLine(),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: 43,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          labelStyle("Athlete ${index + 1}", size: 16.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const CustomLine(),
          ],
        ),
      ),
      bottomNavigationBar: isCoach ? bottomBarCoach(context, 0) : bottomBarPlayer(context, 0)
    );
  }

  TeamDTO getTeam() {
    return Singleton().getTeam(Singleton().teamId)!;
  }
}
