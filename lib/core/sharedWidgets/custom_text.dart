import 'package:chat_app/core/themes/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      style: TextStyle(
        fontSize: 14.sp,
      ),
      onTap: onTap,
      enabled: enable,
      controller: controller,
      keyboardType: type,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 14.sp),
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefix,
          size: 15.w,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix,size: 15.w,),
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
