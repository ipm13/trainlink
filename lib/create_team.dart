import 'package:flutter/material.dart';

import 'styles.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _TeamState();
}

class _TeamState extends State<CreateTeam> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  String modality = 'Football';

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
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child:
                Column(
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
                                labelStyle("      Team Name*"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: TextFormField(
                                  style: inputStyle(),
                                  controller: nameController,
                                  decoration: inputFieldDecoration(
                                      "Enter your team name")),
                            ),
                            Row(
                              children: [
                                labelStyle("      Sport Modality*"),
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
                                    child: infoStyle("By creating a team you will receive a code that can be used to invite other members."),
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
                          /*
                          if (_formKey.currentState!.validate()) {
                              String email = emailController.text;
                              String password = passwordController.text;
                              await getAccount(email, password).then((value) {
                                if (!value){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Your credentials are incorrect")));
                                }else{
                                  Navigator.of(context).pushReplacementNamed('/profiles');
                                }
                              });
                            }*/
                        },
                        child: labelStyle("Confirm", size: 16.0),
                      )
                    ]
                )
        )
    );
  }
}
