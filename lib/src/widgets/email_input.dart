import 'package:flutter/material.dart';

class EmailInput extends StatefulWidget {
  const EmailInput({
    super.key,
    required this.controller,
    this.type = TextInputType.text,
  });

  final TextEditingController controller;
  final TextInputType type;

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.type,
      decoration: InputDecoration(
                            label: Text('Correo', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(230, 1, 180, 228)
                            ),)
                          ),                   
    );
  }
}