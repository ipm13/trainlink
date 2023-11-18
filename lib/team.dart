import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainlink/main.dart';

import 'utils.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
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
                  const FlutterLogo(size: 80),
                  const SizedBox(
                    height: 6,
                  ),
                  labelStyle(getTeamName()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: labelStyle("Invitation Code", size: 24.0, bold: true),
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
                          labelStyle("7b640ac5-ea97-45d0"),
                          IconButton(
                              icon: const Image(
                                  image: AssetImage("assets/images/copy.png")
                              ),
                              onPressed: () async {
                                Clipboard.setData(
                                    const ClipboardData(text: "7b640ac5-ea97-45d0")
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
              height: 20,
            ),
            labelStyle("Modality", size: 24.0, bold: true),
            const SizedBox(
                height: 6,
            ),
            labelStyle(getTeamModality()),
            const SizedBox(
              height: 20,
            ),
            labelStyle("Players", size: 24.0, bold: true),
            const CustomLine(),
            Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: 43,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
      bottomNavigationBar: bottomBar(context, 0),
    );
  }

  String getTeamName() {
    return Singleton().getTeam(Singleton().teamId)!.name;
  }

  String getTeamModality() {
    return Singleton().getTeam(Singleton().teamId)!.modality;
  }

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tapped Icon"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
