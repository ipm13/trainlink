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
    if (descriptionController.text.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Field'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundDecoration(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    buildInputWithTitle(
                      "Field Name *",
                      inputFieldDecoration("Enter train name",
                          prefixIcon: Icons.badge_outlined),
                      nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildInputWithTitle(
                      "Field Description *",
                      inputFieldDecoration("Enter description",
                          prefixIcon: Icons.badge_outlined),
                      descriptionController,
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
                  if (validateFields()) {
                    Field createdField = Field(nameController.text,
                        descriptionController.text, "field");
                    widget.onFieldCreated(createdField);
                    Navigator.pop(context, createdField);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBarStyle(
                        "Field name and description are required",
                        warning: true));
                  }
                },
                child: labelStyle("Create", size: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
