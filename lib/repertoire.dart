import 'package:flutter/material.dart';
import 'package:trainlink/singleton.dart';
import 'utils.dart';

class Repertoire extends StatefulWidget {
  const Repertoire({super.key});

  @override
  State<Repertoire> createState() => _RepertoireState();
}

class _RepertoireState extends State<Repertoire> {
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
            const SizedBox(height: 40),
            labelStyle("Training Repertoire", size: 24.0, bold: true),
            const CustomLine(),
            Expanded(
              flex: 6,
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
                    width: 190,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(24, 231, 114, 1.0)
                          )
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/createTraining');
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
      bottomNavigationBar: bottomBarCoach(context, 1),
    );
  }
  List<Widget> getTrains() {
    List<Widget> widgets = [];
    if (Singleton().getTrainings()!.isEmpty) {
      /*widgets.add(labelStyle("You have", size:25.0));
      widgets.add(labelStyle("0",size:200.0, bold:true));
      widgets.add(labelStyle("Train Plans", size:25.0));*/
      widgets.add(const SizedBox(height: 180));
      widgets.add(labelStyle("You have no training plans"));
      widgets.add(const SizedBox(height: 8));
      widgets.add(labelStyle("Try creating one"));
    } else {
      Singleton().getTrainings()?.forEach((id, train) {
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
              Singleton().trainingId = id;
              Navigator.of(context).pushNamed('/training');
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
