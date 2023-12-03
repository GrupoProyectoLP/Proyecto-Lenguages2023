import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.obscure = false,
  });
  
  final TextEditingController controller;
  final bool obscure;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool showPassword = false;
  @override
  void initState() {
    showPassword = widget.obscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: showPassword,
      decoration: InputDecoration(
        suffixIcon: widget.obscure
            ? IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
              )
            : null,
        label: Text('Contraseña', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 1, 180, 228)
                            ),),
        ),
      );
  }
}