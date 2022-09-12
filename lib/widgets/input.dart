import 'package:flutter/material.dart';
import 'package:prestation/utils/input.dart';

class TextFormWidget extends StatelessWidget {
  final InputField field;
  const TextFormWidget(this.field, {super.key});

  @override
  Widget build(BuildContext context) => _widget();

  TextFormField _widget() {
    return TextFormField(
      keyboardType: field.type,
      validator: (value) {
        return field.validators();
      },
    );
  }
}
