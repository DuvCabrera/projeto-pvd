import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      this.onValidate,
      this.onSave,
      this.initialValue})
      : super(key: key);
  final String label;
  final String? Function(String? text)? onValidate;
  final void Function(String? text)? onSave;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: onValidate,
      onSaved: onSave,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration:
          InputDecoration(border: const OutlineInputBorder(), labelText: label),
    );
  }
}
