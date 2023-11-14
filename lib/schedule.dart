import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  final titleController = TextEditingController();
  final locationController = TextEditingController();

  String? selectedTeamValue;
  String? selectedTrainingValue;
  String? selectedDOWValue;
  String? selectedTODHValue;
  String? selectedTODMValue;

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    super.dispose();
  }

  bool validateFields() {

    if (titleController.text.isEmpty){
      // Show an error message or handle the validation failure
      return false;
    }

    if (selectedTeamValue == null || selectedTeamValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (selectedTrainingValue == null || selectedTrainingValue!.isEmpty) {
      // Show an error message or handle the validation failure
      return false;
    }

    if (locationController.text.isEmpty){
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Schedule Training'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input for Title
                _buildInputWithTitle("Title", titleController),

                // Vertical space
                const SizedBox(height: 20.0),

                _buildDropdownWithTitle("Team", "Choose a team",
                    ["Team A", "Team B", "Team C"], selectedTeamValue, (value) {
                  selectedTeamValue = value;
                }),

                // Vertical space
                const SizedBox(height: 20.0),

                // Dropdown for My Trainings
                _buildDropdownWithTitle(
                    "Trainings",
                    "Choose a training",
                    ["Training 1", "Training 2", "Training 3"],
                    selectedTrainingValue, (value) {
                  selectedTrainingValue = value;
                }),

                // Vertical space
                const SizedBox(height: 20.0),

                // Input for Location
                _buildInputWithTitle("Location", locationController),

                // Vertical space
                const SizedBox(height: 20.0),

                // Dropdown for Day Of The Week
                _buildDropdownWithTitle(
                    "Week Day",
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
                          "Day Time",
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

                const SizedBox(height: 10.0),
                
                const Text("* All fields are mandatory to fill out"),

                // Vertical space
                const SizedBox(height: 20.0),

                // Button to confirm
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (validateFields()) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('A training was schedule with success.'),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }else{
                        const snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please fill out the fields!'),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                    ),
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
    );
  }

  Widget _buildInputWithTitle(String title, TextEditingController tController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18.0)),
        const SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: tController,
            decoration: InputDecoration(
              hintText: "Enter $title",
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
        Text(title, style: const TextStyle(fontSize: 18.0)),
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
            hint: Text(hintValue),
            isExpanded: true,
            underline: Container(),
          ),
        ),
      ],
    );
  }
}
