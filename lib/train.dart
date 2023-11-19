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
    int numFields = getNumFields();
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
              height: 10,
            ),
            labelStyle("Modality", size: 24.0, bold: true),
            const SizedBox(
              height: 6,
            ),
            labelStyle(getTrainModality()),
            const SizedBox(
              height: 10,
            ),
            labelStyle("Duration", size: 24.0, bold: true),
            const SizedBox(
              height: 6,
            ),
            labelStyle(getTrainDuration().toString()),
            const SizedBox(
              height: 10,
            ),
            labelStyle("Fields ($numFields)", size: 24.0, bold: true),
            const CustomLine(),
            Expanded(
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

  List<Field> getTrainFields() {
    return Singleton().getTrain(Singleton().trainId)!.fields;
  }

  int getNumFields() {
    return Singleton().getTrain(Singleton().trainId)!.fields.length;
  }

  List<Widget> getTrains() {
    List<Widget> widgets = [];
    if (getTrainFields().isEmpty) {
      widgets.add(labelStyle("This train has no field added"));
    } else {
      for (Field field in getTrainFields()) {
        String name = field.name;
        widgets.add(
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(175, 0)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () {
              //Decide what to do with clicking on field
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
      }
    }
    return widgets;
  }
}
