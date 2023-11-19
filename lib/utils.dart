import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Text labelStyle(String label,
    {double size = 18.0,
    bool bold = false,
    bool green = false,
    bool black = false}) {
  return Text(label,
      style: TextStyle(
        color: green
            ? const Color.fromRGBO(24, 231, 114, 1.0)
            : black
                ? Colors.black54
                : Colors.white,
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ));
}

Text buttonLabelStyle(String label, {double size = 16.0}) {
  return Text(label,
      style: TextStyle(
        color: Colors.black54,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ));
}

Text infoStyle(String info, {bool black = false}) {
  return Text(info,
      style: TextStyle(
        color: black ? Colors.black54 : Colors.white,
        fontSize: 14,
      ));
}

TextStyle inputStyle() {
  return const TextStyle(
    color: Colors.black54,
    fontSize: 16,
  );
}

ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.white,
  minimumSize: const Size(250, 50),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  backgroundColor: const Color.fromRGBO(86, 94, 109, 1.0),
);

SnackBar snackBarStyle(String label, {bool warning = false}) {
  return SnackBar(
    content: Text(
      label,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor:
        warning ? Colors.redAccent : const Color.fromRGBO(24, 231, 114, 1.0),
  );
}

BoxDecoration backgroundDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/background.png"),
      fit: BoxFit.cover,
    ),
  );
}

InputDecoration inputFieldDecoration(String hint,
    {IconData? prefixIcon, IconData? suffixIcon}) {
  return InputDecoration(
      labelStyle: const TextStyle(color: Colors.black54),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(),
              child: Icon(
                prefixIcon,
                color: Colors.black54,
              ),
            )
          : null,
      suffixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(),
              child: Icon(
                suffixIcon,
                color: Colors.black54,
              ),
            )
          : null,
      contentPadding: const EdgeInsets.only(left: 25),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      filled: true,
      fillColor: Colors.white,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: hint,
      hintStyle: inputStyle());
}

AlertDialog popup(context, {String route = '', required List<Widget> widgets}) {
  return AlertDialog(
    backgroundColor: const Color.fromRGBO(24, 231, 114, 1.0),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  if (route.isNotEmpty) {
                    Navigator.of(context).pushNamed(route);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.black54),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildInputWithTitle(String title, InputDecoration inputDecoration,
    TextEditingController tController,
    {bool black = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      black ? labelStyle(" $title", black: true) : labelStyle(" $title"),
      TextField(
        style: inputStyle(),
        controller: tController,
        decoration: inputDecoration,
      ),
    ],
  );
}

Widget buildDropdownWithTitle(String title, Text hint, List<String> items,
    String? selectedVariable, void Function(String?) onValueChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      labelStyle(" $title"),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButton<String>(
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? selectedValue) {
            onValueChanged(selectedValue);
          },
          value: selectedVariable,
          style: inputStyle(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
          hint: hint,
          isExpanded: true,
        ),
      ),
    ],
  );
}

class CustomLine extends StatelessWidget {
  const CustomLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4 * MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 25),
    );
  }
}

Future<String> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('role', "Coach");
  String? storedRole = prefs.getString("role");
  return storedRole ?? "";
}

FutureBuilder<String> bottomBar(BuildContext context, int currentIndex) {
  return FutureBuilder<String>(
    future: getRole(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        String role = snapshot.data ?? "";
        bool coach = role.contains("Coach");
        if (!coach && currentIndex > 1) {
          currentIndex -= 1;
        }
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex != index) {
              if (index == 0) {
                Navigator.pushReplacementNamed(context, "/home");
              } else if (index == 1) {
                Navigator.pushReplacementNamed(
                    context, coach ? "/repertoire" : "/calendar");
              } else if (index == 2) {
                Navigator.pushReplacementNamed(
                    context, coach ? "/calendar" : "/profile");
              } else if (coach && index == 3) {
                Navigator.pushReplacementNamed(context, "/profile");
              }
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          iconSize: 30,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            if (coach)
              const BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: "Training",
              ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendar",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Profile",
            ),
          ],
        );
      } else {
        // Handle the loading state
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Invisible placeholder
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Invisible placeholder
              label: "",
            ),
          ],
        );
      }
    },
  );
}
