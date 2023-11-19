import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/utils.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<DateTime> getWeeklyOrder() {
    DateTime currentDate = DateTime.now();

    List<DateTime> nextSevenDays = List.generate(7, (index) {
      return currentDate.add(Duration(days: index));
    });

    return nextSevenDays;
  }

  Future<String> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedRole = prefs.getString("role");
    return storedRole ?? "";
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> nextSevenDays = getWeeklyOrder();

    return Scaffold(
        body: Container(
          decoration: backgroundDecoration(),
          child: FutureBuilder<String>(
              future: getRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Assign the value to 'role' after the Future completes
                  String role = snapshot.data ?? "";
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      const SizedBox(height: 40),
                      labelStyle("My Calendar", size: 24.0, bold: true),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ListView.builder(
                            itemCount: nextSevenDays.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  DayCard(
                                    date: nextSevenDays[index],
                                    eventInfo:
                                        "Event details for ${nextSevenDays[index]}",
                                    role: role,
                                  ),
                                  if (index < nextSevenDays.length - 1)
                                    const CustomLine(),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 180,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(
                                                24, 231, 114, 1.0))),
                                onPressed: () {
                                  // Add functionality for the button
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black54,
                                ),
                                label: buttonLabelStyle('Monthly View'),
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(
                                                24, 231, 114, 1.0))),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/schedule');
                                },
                                icon: const Icon(
                                  Icons.add_circle_sharp,
                                  color: Colors.black54,
                                ),
                                label: buttonLabelStyle('Schedule'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Show a loading indicator while the Future is still running
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        bottomNavigationBar: bottomBar(context, 2));
  }
}

class DayCard extends StatelessWidget {
  final DateTime date;
  final String eventInfo;
  final String role;

  const DayCard(
      {super.key,
      required this.date,
      required this.eventInfo,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopup(date, eventInfo, context);
      },
      child: Column(
        children: [
          Text(
            DateFormat('EEEE').format(date.toLocal()),
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Center(
            child: Container(
              width: 0.8 * MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    eventInfo,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showPopup(DateTime date, String eventInfo, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.only(top: 5, right: 5),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      // Add functionality for the "X" icon button
                      Navigator.of(context).pop();
                    },
                    alignment: Alignment.centerRight,
                    icon: const Icon(Icons.close, size: 35),
                  ),
                ],
              ),
              const Text("Team Name", textAlign: TextAlign.center),
            ],
          ),
          content: const Text("Training Time", textAlign: TextAlign.center),
          actions: [
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("Not Implemented");
                    },
                    style: flatButtonStyle,
                    child: Text(role.contains("Coach")
                        ? "Reschedule"
                        : "Check Training"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (role.contains("Coach")) {
                        Navigator.of(context).pushNamed("Not Implemented");
                      } else {
                        // Another Popup
                      }
                    },
                    style: flatButtonStyle,
                    child: Text(role.contains("Coach")
                        ? "Check Attendance"
                        : "Cancel Attendance"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("Not Implemented");
                    },
                    icon: const Icon(Icons.delete, size: 35),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
