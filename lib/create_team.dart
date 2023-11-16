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
  final nameController = TextEditingController();
  String? selectedModalityValue;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  bool validateFields() {
    if (nameController.text.isEmpty) {
      return false;
    }
    if (selectedModalityValue == null || selectedModalityValue!.isEmpty) {
      return false;
    }
    return true;
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 90,
              ),
              labelStyle("Team Logo"),
              Container(
                height: 150.0,
                width: 250.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: const FlutterLogo(size: 70),
              ),
              Column(
                children: [
                  buildInputWithTitle(
                    "Team Name *",
                    inputFieldDecoration("Enter your team name", prefixIcon: Icons.badge_outlined),
                    nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildDropdownWithTitle(
                    "Sport Modality *",
                    Text("Pick a modality", style: inputStyle()),
                    ["Football", "Basketball", "Handball",
                      "Rugby", "Baseball", "Tennis"],
                    selectedModalityValue,
                    (String? selectedValue) {
                      setState(() {
                        selectedModalityValue = selectedValue;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: infoStyle(
                      "By creating a team you will receive a code that can be used to invite other members."
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: flatButtonStyle,
                onPressed: () async {
                  if (validateFields()) {
                    Singleton().addTeam(nameController.text, selectedModalityValue!);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                        createTeamDialog(context, nameController.text),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarStyle("Team name and modality are required", warning: true));
                  }
                },
                child: labelStyle("Confirm", size: 16.0),
              ),
            ],
          ),
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
          child: labelStyle("$teamName was created!", bold: true, black: true),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
                    "Copy this code and share it with other members to invite them to the team.",
                    black: true
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
