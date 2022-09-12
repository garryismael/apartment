import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final List<Widget> _widgets;
  const ItemWidget(this._widgets, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8))),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _widgets,
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.all(10));
  }
}
