import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/Button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: "Add a new Task"),
              ),
      actions: [
        TextButton(child: const Text("Cancel"), onPressed: onCancel),
        ElevatedButton(child: const Text("Save"), onPressed: onSave),
      ]
    );
  }
}
