import 'package:flutter/material.dart';

/*
* Formulaire[création et edition]
*/
class FormWidget extends StatefulWidget {
  final List<Widget> children;
  final String buttonText;
  const FormWidget(this.children, {super.key, this.buttonText = "Créer"});

  @override
  State<StatefulWidget> createState() => _FormWidget();
}

class _FormWidget extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.children,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: Text(widget.buttonText),
            ),
          )
        ],
      ),
    );
  }
}
