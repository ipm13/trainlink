import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';

class CreateTrain extends StatefulWidget {
  const CreateTrain({super.key});

  @override
  State<CreateTrain> createState() => _CreateTrainState();
}

class _CreateTrainState extends State<CreateTrain> {
  final nameController = TextEditingController();
  String? selectedModalityValue;
  String? selectDurationValue;
  List<Field> trainingFields = [];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  bool validateFields() {
    if (nameController.text.isEmpty) {
      return false;
    }
    if (selectedModalityValue == null || selectedModalityValue!.isEmpty) {
      return false;
    }
    if (selectDurationValue == null || selectDurationValue!.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Training'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundDecoration(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    buildInputWithTitle(
                      "Train Name *",
                      inputFieldDecoration("Enter your train name",
                          prefixIcon: Icons.badge_outlined),
                      nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildDropdownWithTitle(
                      "Sport Modality *",
                      Text("Pick a modality", style: inputStyle()),
                      [
                        "Football",
                        "Basketball",
                        "Handball",
                        "Rugby",
                        "Baseball",
                        "Tennis"
                      ],
                      selectedModalityValue,
                      (String? selectedValue) {
                        setState(() {
                          selectedModalityValue = selectedValue;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildDropdownWithTitle(
                      "Duration *",
                      Text("Pick train duration", style: inputStyle()),
                      ["30", "45", "60", "75", "90", "105", "120"],
                      selectDurationValue,
                      (String? selectedValue) {
                        setState(() {
                          selectDurationValue = selectedValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  final result =
                      await Navigator.of(context).pushNamed('/createField');

                  if (result != null && result is Field) {
                    setState(() {
                      trainingFields.add(result);
                    });
                  }
                },
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fields",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 7),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: trainingFields.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(trainingFields[index].name),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: flatButtonStyle,
                onPressed: () async {
                  if (validateFields()) {
                    Singleton().addTrain(
                        nameController.text,
                        selectedModalityValue!,
                        int.parse(selectDurationValue!),
                        trainingFields);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          createTrainDialog(context, nameController.text),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarStyle(
                        "Train name, modality and duration are required",
                        warning: true));
                  }
                },
                child: labelStyle("Create", size: 16.0),
              ),
            ],
          ),
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
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.add_card),
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

  Widget createTrainDialog(BuildContext context, String trainName) {
    return popup(context, route: '/training', widgets: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 30.0),
        child: Column(
          children: [
            labelStyle("$trainName was created!", bold: true, black: true),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ]);
  }
}
