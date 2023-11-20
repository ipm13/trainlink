import 'package:flutter/material.dart';
import 'package:trainlink/singleton.dart';

import 'utils.dart';

class CreateField extends StatefulWidget {
  final Function(FieldDTO) onFieldCreated;
  const CreateField({super.key, required this.onFieldCreated});

  @override
  State<CreateField> createState() => _CreateFieldState();
}

class _CreateFieldState extends State<CreateField> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool validateFields() {
    if (nameController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: labelStyle("Add a Field", bold: true, black: true),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              buildInputWithTitle(
                "Field Name *",
                inputFieldDecoration(
                    "Enter field name",
                    prefixIcon: Icons.badge_outlined
                ),
                nameController,
                black: true
              ),
              const SizedBox(
                height: 20,
              ),
              buildInputWithTitle(
                "Field Description",
                inputFieldDecoration(
                    "Enter a description",
                    prefixIcon: Icons.description
                ),
                descriptionController,
                black: true
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 180,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(50, 49, 103, 0.0)
              )
            ),
            onPressed: () async {
              Navigator.pushNamed(context, '/field');
            },
            icon: const Icon(
              Icons.edit_location_alt_rounded,
              color: Colors.white,
            ),
            label: buttonLabelStyle("Prepare Field", white: true),
          ),
        ),
        const SizedBox(
          height: 25
        ),
        ElevatedButton(
          style: flatButtonStyle,
          onPressed: () async {
            if (validateFields()) {
              FieldDTO field = FieldDTO(
                nameController.text,
                descriptionController.text.isNotEmpty ? descriptionController.text : "No description",
                "field"
              );
              widget.onFieldCreated(field);
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBarStyle("Field successfully created")
              );
              Navigator.pop(context, field);
              //Navigator.pushReplacementNamed(context, '/createTraining');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBarStyle("Field name is required", warning: true)
              );
            }
          },
          child: labelStyle("Create", size: 16.0),
        ),
      ],
    );
  }
}
