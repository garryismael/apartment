import 'package:flutter/material.dart';

class InputField {
  TextInputType type;
  String Function() validators;
  InputField(this.type, this.validators);
}
