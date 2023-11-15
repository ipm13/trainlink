import 'package:flutter/material.dart';
import 'package:trainlink/utils.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final locationController = TextEditingController();

  String? selectedTeamValue;
  String? selectedTrainingValue;
  String? selectedDOWValue;
  String? selectedTODHValue;
  String? selectedTODMValue;

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  bool validateFields() {
    if (selectedTeamValue == null || selectedTeamValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (selectedTrainingValue == null || selectedTrainingValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (locationController.text.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (selectedDOWValue == null || selectedDOWValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (selectedTODHValue == null || selectedTODHValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (selectedTODMValue == null || selectedTODMValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create training schedule"),
        centerTitle: true,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdownWithTitle("Team *", "Choose a team",
                    ["Team A", "Team B", "Team C"], selectedTeamValue, (value) {
                  selectedTeamValue = value;
                }),

                // Vertical space
                const SizedBox(height: 20.0),

                // Dropdown for My Trainings
                _buildDropdownWithTitle(
                    "Trainings *",
                    "Choose a training",
                    ["Training 1", "Training 2", "Training 3"],
                    selectedTrainingValue, (value) {
                  selectedTrainingValue = value;
                }),

                // Vertical space
                const SizedBox(height: 20.0),

                // Input for Location
                _buildInputWithTitle(
                    "Location *", "Enter a location", locationController),

                // Vertical space
                const SizedBox(height: 20.0),

                // Dropdown for Day Of The Week
                _buildDropdownWithTitle(
                    "Week Day *",
                    "Choose a week day",
                    [
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                      "Saturday",
                      "Sunday"
                    ],
                    selectedDOWValue, (value) {
                  selectedDOWValue = value;
                }),

                // Vertical space
                const SizedBox(height: 20.0),

                // Two side-by-side dropdowns for Time Of The Day
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownWithTitle(
                          "Day Time *",
                          "Hour",
                          [
                            "9",
                            "10",
                            "11",
                            "12",
                            "13",
                            "14",
                            "15",
                            "16",
                            "17",
                            "18",
                            "19"
                          ],
                          selectedTODHValue, (value) {
                        selectedTODHValue = value;
                      }),
                    ),
                    const SizedBox(width: 8.0),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: _buildDropdownWithTitle("", "Minutes",
                          ["00", "15", "30", "45"], selectedTODMValue, (value) {
                        selectedTODMValue = value;
                      }),
                    ),
                  ],
                ),

                // Vertical space
                const SizedBox(height: 20.0),

                // Button to confirm
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (validateFields()) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content:
                              Text('A training was schedule with success.'),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      } else {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please fill out the fields!'),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: flatButtonStyle,
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
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
                    child: const Icon(Icons.home_outlined),
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

  Widget _buildInputWithTitle(
      String title, String hintValue, TextEditingController tController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelStyle(title),
        const SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            style: inputStyle(),
            controller: tController,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal),
              hintText: hintValue,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownWithTitle(
      String title,
      String hintValue,
      List<String> items,
      String? selectedVariable,
      void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelStyle(title),
        const SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButton<String>(
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? selectedValue) {
              setState(() {
                selectedVariable = selectedValue!;
              });
              onChanged(selectedValue!);
            },
            value: selectedVariable,
            hint: labelStyle(hintValue),
            isExpanded: true,
            underline: Container(),
          ),
        ),
      ],
    );
  }
}
