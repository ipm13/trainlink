import 'package:flutter/material.dart';

import 'utils.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                      print("Coach");
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
                      print("Player");
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
