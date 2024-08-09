import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdbapp/components/form_validators.dart';

class UsernameForm extends StatelessWidget {
  final String hintTextName;
  final TextEditingController controllerNames;
  final void Function(String)? onChanged;
  final BorderRadius borderRads;

  const UsernameForm({
    super.key, 
    required this.hintTextName, 
    required this.controllerNames,
    this.borderRads = const BorderRadius.all(Radius.circular(10)),
    this.onChanged  
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerNames,
      validator: (value) => FormValidator.validateUsername(username: value),
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle, color: Colors.grey),
        hintText: hintTextName,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: borderRads,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRads,
          borderSide: const BorderSide(color: Colors.purpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRads,
          borderSide: const BorderSide(
            color: Colors.purpleAccent,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatelessWidget {
  final String hintTextName;
  final bool isPasswordVisible;
  final void Function(String)? onChanged;
  final void Function()? onPressedPassword;
  final TextEditingController controllerNames;
  final BorderRadius borderRads;

  const PasswordForm({
    super.key, 
    required this.hintTextName, 
    required this.controllerNames,
    required this.isPasswordVisible,
    required this.onPressedPassword,
    this.borderRads = const BorderRadius.all(Radius.circular(10)),
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerNames,
      obscureText: !isPasswordVisible,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
      ],
      validator: (value) => FormValidator.validateForms(contents: value),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        hintText: hintTextName,
        isDense: true,
        suffixIcon: IconButton(
          onPressed: onPressedPassword,
          icon: isPasswordVisible ? const Icon(Icons.visibility_off, color: Colors.grey) : const Icon(Icons.visibility, color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRads,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRads,
          borderSide: const BorderSide(color: Colors.purpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRads,
          borderSide: const BorderSide(
            color: Colors.purpleAccent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
