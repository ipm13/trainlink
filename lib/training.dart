import 'package:flutter/material.dart';
import 'package:trainlink/singleton.dart';

import 'utils.dart';

class Training extends StatefulWidget {
  const Training({super.key});

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  @override
  Widget build(BuildContext context) {
    int numFields = getNumFields();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Menu'),
        centerTitle: true,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                labelStyle(getTrainingName(), size: 22.0),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            labelStyle("Modality", size: 24.0, bold: true),
            const SizedBox(
              height: 6,
            ),
            labelStyle(getTrainingModality()),
            const SizedBox(
              height: 20,
            ),
            labelStyle("Duration", size: 24.0, bold: true),
            const SizedBox(
              height: 6,
            ),
            labelStyle("${getTrainingDuration()} minutes"),
            const SizedBox(
              height: 20,
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
                        children: getTrainings(),
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
      bottomNavigationBar: bottomBarCoach(context, 1),
    );
  }

  String getTrainingName() {
    return Singleton().getTraining(Singleton().trainingId)!.name;
  }

  String getTrainingModality() {
    return Singleton().getTraining(Singleton().trainingId)!.modality;
  }

  int getTrainingDuration() {
    return Singleton().getTraining(Singleton().trainingId)!.duration;
  }

  List<FieldDTO> getTrainingFields() {
    return Singleton().getTraining(Singleton().trainingId)!.fields;
  }

  int getNumFields() {
    return Singleton().getTraining(Singleton().trainingId)!.fields.length;
  }

  List<Widget> getTrainings() {
    List<Widget> widgets = [];
    if (getTrainingFields().isEmpty) {
      widgets.add(labelStyle("This train has no field added"));
    } else {
      for (FieldDTO field in getTrainingFields()) {
        String name = field.name;
        widgets.add(
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(175, 50)),
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
            child: labelStyle(name, size: 16.0),
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
