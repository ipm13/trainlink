import 'package:flutter/material.dart';

import 'image_widget.dart';
import 'main.dart';
import 'utils.dart';

class Training extends StatefulWidget {
  const Training({super.key});

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trainings"),
        centerTitle: true,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            labelStyle("All Trainings", size: 24.0, bold: true),
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
                        children: getTrains(),
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
                    width: 250,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(24, 231, 114, 1.0)
                          )
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/createTrain');
                      },
                      icon: const Icon(
                        Icons.add_circle_sharp,
                        color: Colors.black54,
                      ),
                      label: buttonLabelStyle("Create Training"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(context, 1),
    );
  }
  List<Widget> getTrains() {
    List<Widget> widgets = [];
    if (Singleton().getTrains()!.isEmpty) {
      widgets.add(labelStyle("You have", size:25.0));
      widgets.add(labelStyle("0",size:200.0, bold:true));
      widgets.add(labelStyle("Trains", size:25.0));
    } else {
      Singleton().getTrains()?.forEach((id, train) {
        String name = train.name;
        widgets.add(
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(175, 50)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              Singleton().trainId = id;
              Navigator.of(context).pushNamed('/train');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
}
