import 'package:flutter/material.dart';

Text labelStyle(label, {double size = 18.0, bool bold = false, bool green = false}) {
  return Text(
      label,
      style: TextStyle(
          color: green ? const Color.fromRGBO(24, 231, 114, 1.0) : Colors.white,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      )
  );
}

Text infoStyle(info) {
  return Text(
      info,
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

InputDecoration inputFieldDecoration(hint) {
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