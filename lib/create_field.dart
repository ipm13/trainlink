import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';

class CreateField extends StatefulWidget {
  final Function(Field) onFieldCreated;
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
          height: 20,
        ),
        ElevatedButton(
          style: flatButtonStyle,
          onPressed: () async {
            Navigator.pushNamed(context, '/field');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.edit),
              labelStyle(" Prepare Field", size: 16.0),
            ]
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: flatButtonStyle,
          onPressed: () async {
            if (validateFields()) {
              Field createdField = Field(
                  nameController.text,
                  descriptionController.text.isNotEmpty ? descriptionController.text : "No description",
                  "field"
              );
              widget.onFieldCreated(createdField);
              Navigator.pop(context, createdField);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(snackBarStyle(
                  "Field name is required",
                  warning: true));
            }
          },
          child: labelStyle("Create", size: 16.0),
        ),
      ],
    );
  }
}
