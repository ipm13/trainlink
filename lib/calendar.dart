import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/singleton.dart';
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

  bool isCoach = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getString('role')! == "Coach" ? isCoach = true : isCoach = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> nextSevenDays = getWeeklyOrder();
    return Scaffold(
        body: Container(
          decoration: backgroundDecoration(),
          child: Column(
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
                          Text(
                            DateFormat('d/M - EEEE')
                              .format(nextSevenDays[index].toLocal()),
                            style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                          ),
                          DayCard(
                            date: nextSevenDays[index],
                            role: isCoach ? "Coach" : "Player",
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
                  mainAxisAlignment: isCoach
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(24, 231, 114, 1.0))),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/monthlyView");
                        },
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.black54,
                        ),
                        label: buttonLabelStyle('Monthly View'),
                      ),
                    ),
                    if (isCoach)
                      SizedBox(
                        width: 180,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(24, 231, 114, 1.0))),
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
          ),
        ),
        bottomNavigationBar: isCoach ? bottomBarCoach(context, 2) : bottomBarPlayer(context, 1)
    );
  }
}

class DayCard extends StatefulWidget {
  final DateTime date;
  final String role;

  const DayCard({super.key, required this.date, required this.role});

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  final justificationController = TextEditingController();

  List<ScheduleDTO> getDaySchedules() {
    String weekDay = DateFormat('EEEE').format(widget.date.toLocal());
    return Singleton().getSchedulesByWeekDay(weekDay);
  }

  String calculateFinalTime(int hours, int minutes){
    // Add 60 minutes
    minutes += 60;

    // Check if adding 60 minutes causes an overflow to the next hour
    if (minutes >= 60) {
      hours += minutes ~/ 60; // Add the overflowed hours
      minutes %= 60; // Set minutes to the remainder after dividing by 60
    }

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes";
  }

  @override
  Widget build(BuildContext context) {
    List<ScheduleDTO> schedules = getDaySchedules();
    return Column(
      children: schedules.map((schedule) {
        String formattedHours = schedule.hours.toString().padLeft(2, '0');
        String formattedMinutes = schedule.minutes.toString().padLeft(2, '0');
        return GestureDetector(
          onTap: () {
            showPopup(
              schedule.teamName,
              schedule.hours,
              schedule.minutes,
              context,
            );
          },
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Ajuste o valor conforme necessário
              ),
              width: 0.8 * MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(
                    schedule.teamName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.timer_sharp, size: 25),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$formattedHours:$formattedMinutes - "
                            "${calculateFinalTime(schedule.hours, schedule.minutes)}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 25),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        schedule.location,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void showPopup(
      String teamName, int hours, int minutes, BuildContext context) {
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

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
                      Navigator.of(context).pop();
                    },
                    alignment: Alignment.centerRight,
                    icon: const Icon(Icons.close, size: 35),
                  ),
                ],
              ),
              Text(teamName, textAlign: TextAlign.center),
            ],
          ),
          content: Text("$formattedHours:$formattedMinutes - "
              "${calculateFinalTime(hours, minutes)}", textAlign: TextAlign.center),
          actions: [
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("Not Implemented");
                    },
                    style: flatButtonStyle,
                    child: Text(widget.role.contains("Coach")
                        ? "Reschedule"
                        : "Check Training"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.role.contains("Coach")) {
                        Navigator.of(context).pushNamed("Not Implemented");
                      } else {
                        showCancelAttendance(context);
                      }
                    },
                    style: flatButtonStyle,
                    child: Text(widget.role.contains("Coach")
                        ? "Check Attendance"
                        : "Cancel Attendance"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.role.contains("Coach"))
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

  void showCancelAttendance(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Text("Cancel Attendance",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: buildInputWithTitle(
                    "Justification *",
                    inputFieldDecoration("Enter justification"),
                    justificationController,
                    black: true),
              ),
              ElevatedButton(
                onPressed: () {
                  if (justificationController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snackBarStyle("Please write a justification!"));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snackBarStyle("Successfully canceled the training."));
                    Navigator.of(context).pop();
                  }
                },
                style: flatButtonStyle,
                child: const Text("Confirm"),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
