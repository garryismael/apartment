import 'package:flutter/material.dart';
import 'package:prestation/models/model.dart';

class SelectField<T extends IModel> extends StatefulWidget {
  final List<T> list;
  const SelectField(this.list, {super.key});
  @override
  State<SelectField<T>> createState() => _SelectFieldState();
}

class _SelectFieldState<T extends IModel> extends State<SelectField<T>> {
  late T value;
  _SelectFieldState() {
    value = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (T? value) {
        setState(() {
          value = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.getValue()),
        );
      }).toList(),
    );
  }
}
