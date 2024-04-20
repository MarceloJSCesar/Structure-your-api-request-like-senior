import 'package:flutter/material.dart';

class LoginFieldComponent extends StatelessWidget {
  const LoginFieldComponent({
    super.key,
    this.controller,
    this.label,
    this.textInputAction,
    this.onChanged,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? label;

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      cursorColor: Colors.lightBlue,
      cursorHeight: 15,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        focusColor: Colors.lightBlue,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
      ),
    );
  }
}
