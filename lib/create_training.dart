import 'package:flutter/material.dart';
import 'package:trainlink/singleton.dart';

import 'utils.dart';
import 'create_field.dart';

class CreateTraining extends StatefulWidget {
  const CreateTraining({super.key});

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
  final nameController = TextEditingController();
  String? selectedModalityValue;
  String? selectDurationValue;
  List<FieldDTO> trainingFields = [];

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

  void setCurrentField(FieldDTO field) {
    setState(() {
      trainingFields.add(field);
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
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: buildInputWithTitle(
                      "Training Name *",
                      inputFieldDecoration("Enter your training name", prefixIcon: Icons.badge_outlined),
                      nameController,
                      charLimit: 20,
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
                          if (selectedValue != null) Singleton().modality = selectedValue;
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: selectedModalityValue != null ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        labelStyle(getFieldsAsString(), bold: true),
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
                            },
                            icon: const Icon(
                              Icons.add_circle_sharp,
                              color: Colors.black54,
                            ),
                            label: buttonLabelStyle("Add a Field"),
                          ),
                        ),
                      ],
                    ) : Container(),
                  ),
                ],
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
                      trainingFields
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBarStyle("Training successfully created")
                  );
                  Navigator.pushReplacementNamed(context, '/repertoire');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBarStyle("Name, modality and duration required", warning: true)
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
      bottomNavigationBar: bottomBarCoach(context, 1),
    );
  }

  String getFieldsAsString() {
    int length = trainingFields.length;
    if (length == 0) {
      return "Fields";
    }
    return "Fields ($length)";
  }

  String getFieldName(int index) {
    return trainingFields[index].name;
  }

  Widget createFieldDialog(BuildContext context) {
    return popup(
      context,
      widgets: [
        CreateField(onFieldCreated: setCurrentField),
      ]
    );
  }
}
