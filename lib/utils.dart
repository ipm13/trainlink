import 'package:flutter/material.dart';

Text labelStyle(String label, {double size = 18.0, bool bold = false, bool green = false}) {
  return Text(label,
    style: TextStyle(
      color: green ? const Color.fromRGBO(24, 231, 114, 1.0) : Colors.white,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    )
  );
}

Text buttonLabelStyle(String label, {double size = 16.0}) {
  return Text(label,
      style: TextStyle(
        color: Colors.black54,
        fontSize: size,
        fontWeight: FontWeight.bold,
      )
  );
}

Text infoStyle(String info) {
  return Text(info,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 12,
    )
  );
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

BoxDecoration backgroundDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/background.png"),
      fit: BoxFit.cover,
    ),
  );
}

InputDecoration inputFieldDecoration(String hint) {
  return InputDecoration(
    labelStyle: const TextStyle(color: Colors.black54),
    contentPadding: const EdgeInsets.only(left: 25),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    filled: true,
    fillColor: Colors.white,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.black54));
}

AlertDialog popup(context, {String route = '', required List<Widget> widgets}) {
  return AlertDialog(
    backgroundColor: const Color.fromRGBO(24, 231, 114, 0.85),
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

SnackBar snackBarStyle(String label) {
  return SnackBar(
    content: Text(
        label,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )
    ),
    backgroundColor: const Color.fromRGBO(24, 231, 114, 1.0),
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
