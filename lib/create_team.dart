import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'image_widget.dart';
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
  File? image;

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              labelStyle("Team Logo"),
              const SizedBox(height: 8),
              ImageWidget(
                image: image,
                defaultImagePath: 'assets/images/gallery.png',
                size: 130,
                onClicked: (source) => pickImage(source),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
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
                      ["Soccer", "Rugby"],
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
                  ]
                )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomBar(context, 0),
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
                              Navigator.of(context).pushReplacementNamed('/home');
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
