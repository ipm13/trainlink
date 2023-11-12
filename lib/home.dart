import 'package:flutter/material.dart';

import 'styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                )
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
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FlutterLogo(size: 40),
                          labelStyle("Team ${index + 1}", size: 16.0),
                        ],
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
              child: labelStyle("Create Team", size: 16.0),
            ),
            const SizedBox(
              height: 20,
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
