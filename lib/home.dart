import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'image_widget.dart';
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

  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email')!;
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
              child: labelStyle("Hello, $_email"),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(context, 0)
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
      widgets.add(labelStyle("Try creating one"));
    } else {
      Singleton().getTeams()?.forEach((id, team) {
        String name = team.name;
        widgets.add(
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(175, 90)),
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
                const ImageWidget(
                  image: null,
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
}
