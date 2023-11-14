import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              child: labelStyle("Hello, John Doe"),
            ),
            labelStyle("My Teams", size: 24.0, bold: true),
            const CustomLine(),
            Expanded(
              child: Center(
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
            ElevatedButton(
              style: flatButtonStyle,
              onPressed: () async {
                Navigator.of(context).pushNamed('/createTeam');
              },
              child: labelStyle("Create Team", size: 16.0),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: flatButtonStyle,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => joinTeamDialog(context),
                );
              },
              child: labelStyle("Join Team", size: 16.0),
            ),
            const SizedBox(
              height: 20,
            ),
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
                child: InkWell(
                  onTap: () {
                    showPopup('Home Icon Tapped');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.home),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showPopup('Search Icon Tapped');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showPopup('Favorite Icon Tapped');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.favorite),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showPopup('Settings Icon Tapped');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.settings),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? getTeamCount() {
    return Singleton().getTeamCount();
  }

  List<Widget> getTeams() {
    List<Widget> widgets = [];
    if (Singleton().getTeams()!.isEmpty) {
      widgets.add(
        labelStyle("You're not part of any team")
      );
    } else {
      Singleton().getTeams()?.forEach((id, team) {
        String name = team.name;
        widgets.add(
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(175, 0)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent),
            ),
            onPressed: () {
              Singleton().teamId = id;
              Navigator.of(context).pushNamed('/team');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 40),
                const SizedBox(
                  height: 6,
                ),
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
          child: labelStyle("Join Team", bold: true),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  labelStyle("     Team Code*"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      style: inputStyle(),
                      controller: codeController,
                      decoration: inputFieldDecoration("Enter the code"),
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
                              snackBarStyle("Team code is required")
                            );
                          } else {
                            // TODO
                            // Add a team by code
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarStyle("Welcome to the team")
                            );
                            Navigator.of(context).pop();
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