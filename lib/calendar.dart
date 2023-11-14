import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    List<DateTime> nextSevenDays = getWeeklyOrder();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Calendar"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                itemCount: nextSevenDays.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      DayCard(
                          date: nextSevenDays[index],
                          eventInfo:
                              "Event details for ${nextSevenDays[index]}"),
                      if (index < nextSevenDays.length - 1) const CustomLine(),
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
                  width: 150,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    icon: const Icon(Icons.remove_red_eye),
                    label: const Text('Month View'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/schedule');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Schedule'),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                    showPopup('Home Icon Tapped');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.home),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showPopup('Training Icon Tapped');
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.add_card)),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showPopup('Calendar Icon Tapped');
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
                    showPopup('Profile Icon Tapped');
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

  void showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tapped Icon"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class DayCard extends StatelessWidget {
  final DateTime date;
  final String eventInfo;

  const DayCard({super.key, required this.date, required this.eventInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Selected Date"),
              content: Text(
                  "Date: ${DateFormat('EEEE, d MMMM yyyy').format(date.toLocal())}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      },
      child: Column(
        children: [
          Text(
            DateFormat('EEEE').format(date.toLocal()),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4 * MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 35),
    );
  }
}
