import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/singleton.dart';

import 'image_widget.dart';
import 'utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();

  String? _user;
  bool isCoach = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _user = prefs.getString('name')!;
      prefs.getString('role')! == "Coach" ? isCoach = true : isCoach = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            Container(
              height: 120.0,
              width: 250.0,
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Transform.scale(
                  scale: 0.75,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
              child: labelStyle("Hello, $_user"),
            ),
            labelStyle("My Teams", size: 24.0, bold: true),
            const CustomLine(),
            Expanded(
              flex: 4,
              child: Center(
                heightFactor: 200.0,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: getTeams(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const CustomLine(),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: isCoach ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(24, 231, 114, 1.0)
                          )
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => joinTeamDialog(context),
                        );
                      },
                      icon: const Icon(
                        Icons.supervised_user_circle_sharp,
                        color: Colors.black54,
                      ),
                      label: buttonLabelStyle("Join Team"),
                    ),
                  ),
                  isCoach ?
                    SizedBox(
                      width: 180,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(24, 231, 114, 1.0)
                          )
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/createTeam');
                        },
                        icon: const Icon(
                          Icons.add_circle_sharp,
                          color: Colors.black54,
                        ),
                        label: buttonLabelStyle("Create Team"),
                      ),
                    )
                  : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isCoach ? bottomBarCoach(context, 0) : bottomBarPlayer(context, 0)
    );
  }

  int? getTeamCount() {
    return Singleton().getTeamCount();
  }

  List<Widget> getTeams() {
    List<Widget> widgets = [];
    if (Singleton().getTeams()!.isEmpty) {
      widgets.add(const SizedBox(height: 120));
      widgets.add(labelStyle("You're not part of any team"));
      widgets.add(const SizedBox(height: 8));
      widgets.add(labelStyle("Try ${isCoach == true ? "creating" : "join"} one"));
    } else {
      Singleton().getTeams()?.forEach((id, team) {
        String name = team.name;
        widgets.add(
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(230, 90)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              Singleton().teamId = id;
              Navigator.of(context).pushNamed('/team');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(
                  image: team.logoPath != null ? File(team.logoPath!) : null,
                  defaultImagePath: 'assets/images/gallery.png',
                  size: 40,
                ),
                const SizedBox(height: 6,),
                labelStyle(name, size: 16.0),
              ],
            ),
          ),
        );
        widgets.add(
          const SizedBox(
            height: 8,
          ),
        );
      });
    }
    return widgets;
  }

  Widget joinTeamDialog(BuildContext context) {
    return popup(
      context,
      widgets: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
          child: labelStyle("Join Team", bold: true, black: true),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  labelStyle("     Team Code *", black: true),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      style: inputStyle(),
                      controller: codeController,
                      decoration: inputFieldDecoration("Enter the code", prefixIcon: Icons.content_paste_go),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String code = codeController.text;
                          if (code.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarStyle("Team code is required", warning: true)
                            );
                          } else {
                            if (code == teamDefault.code) {
                              if (Singleton().getTeams() != null && Singleton().getTeams()!.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarStyle("You already belong to this team", warning: true)
                                );
                              } else {
                                Singleton().addTeam(teamDefault.name, teamDefault.modality, _user ?? "", teamDefault.logoPath);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarStyle("Welcome to the team")
                                );
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacementNamed('/home');
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarStyle("Team code is invalid", warning: true)
                              );
                            }
                          }
                        }
                      },
                      child: labelStyle("Confirm", size: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}
