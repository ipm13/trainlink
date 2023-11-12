import 'package:flutter/material.dart';
import 'package:trainlink/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrainLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/calendar",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.white,
    minimumSize: const Size(250, 50),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    backgroundColor: const Color.fromRGBO(86, 94, 109, 1.0),
  );

  InputDecoration inputFieldStyle(label, hint) {
    return InputDecoration(
        labelStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.only(left: 25),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                height: 200.0,
                width: 250.0,
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                          style: const TextStyle(color: Colors.black54),
                          controller: emailController,
                          decoration:
                          inputFieldStyle("Email", "Enter your email")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                          style: const TextStyle(color: Colors.black54),
                          controller: passwordController,
                          obscureText: true,
                          decoration: inputFieldStyle(
                              "Password", "Enter your password")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
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
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(
                            color: Color.fromRGBO(24, 231, 114, 1.0),
                            fontSize: 15),
                      ),
                    ],
                  )
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
