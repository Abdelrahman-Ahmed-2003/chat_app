import 'package:chat_app/core/themes/colors_app.dart';
import 'package:flutter/material.dart';

Widget customText({
  TextEditingController? controller,
  required TextInputType type,
  Function(String)? onChanged,
  FormFieldValidator<String>? validator,
  String? label,
  String? hint,
  IconData? prefix,
  bool obscureText = false,
  IconData? suffix,
  Function()? suffixPressed,
  Function()? onTap,
  bool? enable,
}) =>
    TextFormField(
      style: const TextStyle(
        fontSize: 14,
      ),
      onTap: onTap,
      enabled: enable,
      controller: controller,
      keyboardType: type,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: const OutlineInputBorder(
          //borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: ColorApp.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
