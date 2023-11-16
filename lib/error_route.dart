import 'package:flutter/material.dart';

class ErrorRoute extends StatefulWidget {
  const ErrorRoute({super.key});

  @override
  State<ErrorRoute> createState() => _ErrorRouteState();
}

class _ErrorRouteState extends State<ErrorRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Page"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Not yet implemented",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}