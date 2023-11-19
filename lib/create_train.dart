import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';
import 'create_field.dart';

class CreateTrain extends StatefulWidget {
  const CreateTrain({super.key});

  @override
  State<CreateTrain> createState() => _CreateTrainState();
}

class _CreateTrainState extends State<CreateTrain> {
  Field? currentField;
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

  void setCurrentField(Field field) {
    setState(() {
      currentField = field;
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: buildInputWithTitle(
                      "Train Name *",
                      inputFieldDecoration("Enter your train name",
                          prefixIcon: Icons.badge_outlined),
                      nameController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: buildDropdownWithTitle(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: buildDropdownWithTitle(
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
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 85,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Fields:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 250,
                      child: ListView.builder(
                        itemCount: trainingFields.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Center(
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Text("$index"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: InkWell(
                        onTap: () async {
                          createFieldDialog(context);
                          if (currentField != null) {
                            setState(
                              () {
                                trainingFields.add(currentField!);
                                currentField = null;
                              },
                            );
                          }
                        },
                        child: Container(
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
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
            const SizedBox(
              height: 40,
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

  void createFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the AlertDialog with specific size
        return AlertDialog(
          content: SizedBox(
            width: 400.0, // Set the width as needed
            height: 400.0, // Set the height as needed
            child: CreateField(onFieldCreated: setCurrentField),
          ),
        );
      },
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
