import 'package:flutter/material.dart';
import 'package:trainlink/utils.dart';

import 'main.dart';

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

  List<String> getTeams() {
    List<String> teams = [];
    Singleton().getTeams()?.forEach((id, team) {
      teams.add(team.name);
    });
    return teams;
  }

  List<String> getTrainings() {
    List<String> trainings = [];
    Singleton().getTrainings()?.forEach((id, training) {
      trainings.add(training.name);
    });
    return trainings;
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
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: backgroundDecoration(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDropdownWithTitle(
                    "Team *",
                    Text("Pick your team", style: inputStyle()),
                    getTeams(),
                    selectedTeamValue,
                    (String? selectedValue) {
                      setState(() {
                        selectedTeamValue = selectedValue;
                      });
                    },
                  ),

                  // Vertical space
                  const SizedBox(height: 20.0),

                  // Dropdown for My Trainings
                  buildDropdownWithTitle(
                    "Trainings *",
                    Text("Pick your training", style: inputStyle()),
                    getTrainings(),
                    selectedTrainingValue,
                    (String? selectedValue) {
                      setState(() {
                        selectedTrainingValue = selectedValue;
                      });
                    },
                  ),

                  // Vertical space
                  const SizedBox(height: 20.0),

                  // Input for Location
                  buildInputWithTitle(
                    "Location *",
                    inputFieldDecoration("Enter a location"),
                    locationController,
                  ),

                  // Vertical space
                  const SizedBox(height: 20.0),

                  // Dropdown for Day Of The Week
                  buildDropdownWithTitle(
                    "Week Day *",
                    Text("Pick a day", style: inputStyle()),
                    [
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                      "Saturday",
                      "Sunday"
                    ],
                    selectedDOWValue,
                    (String? selectedValue) {
                      setState(() {
                        selectedDOWValue = selectedValue;
                      });
                    },
                  ),

                  // Vertical space
                  const SizedBox(height: 20.0),

                  // Two side-by-side dropdowns for Time Of The Day
                  Row(
                    children: [
                      Expanded(
                        child: buildDropdownWithTitle(
                          "Day Time *",
                          Text("Hour", style: inputStyle()),
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
                            "19",
                            "20",
                            "21"
                          ],
                          selectedTODHValue,
                          (String? selectedValue) {
                            setState(() {
                              selectedTODHValue = selectedValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: labelStyle(":", size: 26.0),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: buildDropdownWithTitle(
                          "",
                          Text("Minute", style: inputStyle()),
                          ["00", "15", "30", "45"],
                          selectedTODMValue,
                          (String? selectedValue) {
                            setState(() {
                              selectedTODMValue = selectedValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  // Vertical space
                  const SizedBox(height: 30.0),

                  // Button to confirm
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateFields()) {
                          Singleton().addSchedule(
                              selectedTeamValue!,
                              selectedTrainingValue!,
                              locationController.text,
                              selectedDOWValue!,
                              selectedTODHValue as int,
                              selectedTODMValue as int);

                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBarStyle(
                                  "Successfully scheduled a training"));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBarStyle("Please fill out the fields",
                                  warning: true));
                        }
                      },
                      style: flatButtonStyle,
                      child: labelStyle("Confirm", size: 16.0),
                    ),
                  ),
                ],
              ),
              ),
            ),
          ),
      ),
      bottomNavigationBar: bottomBar(context, 2),
    );
  }
}
