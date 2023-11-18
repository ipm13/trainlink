import 'package:flutter/material.dart';
import 'package:trainlink/main.dart';

import 'utils.dart';

class Train extends StatefulWidget {
  const Train({super.key});

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train Menu'),
        centerTitle: true,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140.0,
              width: 450.0,
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 80),
                  const SizedBox(
                    height: 6,
                  ),
                  labelStyle(getTrainName()),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            labelStyle("Modality", size: 24.0, bold: true),
            const SizedBox(
              height: 6,
            ),
            labelStyle(getTrainModality()),
            const SizedBox(
              height: 20,
            ),
            labelStyle("Fields", size: 24.0, bold: true),
            const CustomLine(),
            const CustomLine(),
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
                    Navigator.pushNamed(context, "/home");
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
                    Navigator.pushNamed(context, "/training");
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.add_card)),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/calendar");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.account_box),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTrainName() {
    return Singleton().getTrain(Singleton().trainId)!.name;
  }

  String getTrainModality() {
    return Singleton().getTrain(Singleton().trainId)!.modality;
  }

  int getTrainDuration() {
    return Singleton().getTrain(Singleton().trainId)!.duration;
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
