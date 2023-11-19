import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';
import 'create_field.dart';

class CreateTraining extends StatefulWidget {
  const CreateTraining({super.key});

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
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
              margin: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: buildInputWithTitle(
                      "Training Name *",
                      inputFieldDecoration("Enter your training name",
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
                      ["Soccer", "Rugby",],
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
                      Text("Pick duration", style: inputStyle()),
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
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        labelStyle("Fields", bold: true),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: 180,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(24, 231, 114, 1.0)
                                )
                            ),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      createFieldDialog(context)
                              );
                              //createFieldDialog(context);
                              if (currentField != null) {
                                setState(
                                      () {
                                    trainingFields.add(currentField!);
                                    currentField = null;
                                  },
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.add_circle_sharp,
                              color: Colors.black54,
                            ),
                            label: buttonLabelStyle("Add a Field"),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      width: 300,
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
                                  color: Color.fromRGBO(24, 231, 114, 1.0),
                                ),
                                child: Center(
                                  child: Text("$index"),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                            ],
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
                  Singleton().addTraining(
                      nameController.text,
                      selectedModalityValue!,
                      int.parse(selectDurationValue!),
                      trainingFields);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        createTrainingDialog(context, nameController.text),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(snackBarStyle(
                      "Name, modality and duration required",
                      warning: true)
                  );
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
      bottomNavigationBar: bottomBar(context, 1),
    );
  }

  /*void createFieldDialog(BuildContext context) {
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
  }*/

  Widget createFieldDialog(BuildContext context) {
    return popup(
      context,
      widgets: [
        CreateField(onFieldCreated: setCurrentField),
      ]
    );
  }

  Widget createTrainingDialog(BuildContext context, String trainingName) {
    return popup(context, route: '/repertoire', widgets: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 30.0),
        child: Column(
          children: [
            labelStyle("$trainingName was created!", bold: true, black: true),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ]);
  }
}
