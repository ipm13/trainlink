import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'utils.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _TeamState();
}

class _TeamState extends State<CreateTeam> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  String modality = '--';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Team'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            labelStyle("Team Logo"),
            Container(
              height: 150.0,
              width: 250.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: const Center(
                child: FlutterLogo(size: 80),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      labelStyle("      Team Name *"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      style: inputStyle(),
                      controller: nameController,
                      decoration: inputFieldDecoration("Enter your team name")
                    ),
                  ),
                  Row(
                    children: [
                      labelStyle("      Sport Modality *"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButtonFormField<String>(
                          value: modality,
                          onChanged: (String? newValue) {
                            setState(() {
                              modality = newValue!;
                            });
                          },
                          decoration: inputFieldDecoration(""),
                          items: <String>[
                            '--',
                            'Football',
                            'Basketball',
                            'Handball',
                            'Rugby',
                            'Tennis',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: inputStyle(),
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2.0, 15.0, 0.0, 20.0),
                          child: infoStyle(
                            "By creating a team you will receive a code that can be used to invite other members."
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: flatButtonStyle,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String teamName = nameController.text;
                  if (teamName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarStyle("Team name is required")
                    );
                  }
                  if (modality == '--') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarStyle("Sport modality is required")
                    );
                  }
                  if (teamName.isNotEmpty && modality != '--') {
                    Singleton().addTeam(teamName, modality);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                        createTeamDialog(context, teamName),
                    );
                  }
                }
              },
              child: labelStyle("Confirm", size: 16.0),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.home),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/training");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.add_card)
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/calendar");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.account_box),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createTeamDialog(BuildContext context, String teamName) {
    return popup(
      context,
      route: '/home',
      widgets: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
          child: labelStyle("$teamName was created!", bold: true),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    color: Colors.black54,
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
                              Navigator.of(context).pushNamed('/home');
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarStyle("Team code copied to clipboard")
                              );
                            });
                          }
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  infoStyle(
                    "Copy this code and share it with other members to invite them to the team."
                  ),
                ],
              ),
            ),
          ],
        ),
      ]
    );
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
