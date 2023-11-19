import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {

  void _setRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Choose your Role'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: backgroundDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _setRole("Coach");
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        labelStyle("Coach", size: 24.0, bold: true),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                        ClipRRect(
                            child: Image.asset('assets/images/coach.png', width: 180, height: 180),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _setRole("Player");
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        labelStyle("Player", size: 24.0, bold: true),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                        ClipRRect(
                            child: Image.asset('assets/images/player.png', width: 180, height: 180),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
