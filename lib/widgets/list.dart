import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final List<Widget> widgets;
  final Text text;
  const ListWidget(this.text, this.widgets, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        children: widgets,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }
}
