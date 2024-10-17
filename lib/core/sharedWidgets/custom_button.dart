// import 'package:flutter/material.dart';

// Widget customButton({
//   required String text,
//   required VoidCallback func,
//   Color? textColor,
//   double? width,
//   double? height,
//   double? fontSize,
//   double? borderRadius,
//   Color? backgroundColor,
// }) =>
//     ElevatedButton(
//       onPressed: onPressed,
//       child: Text(
//         label,
//         style: TextStyle(
//           color: textColor,
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//         ),
//       ),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(color),
//         minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(radius),
//           ),
//         ),
//         elevation: MaterialStateProperty.all<double>(elevation),
//         side: MaterialStateProperty.all<BorderSide>(
//           BorderSide(
//             color: borderColor,
//             width: borderWidth,
//           ),
//         ),
//       ),
//     );

import 'package:chat_app/core/themes/colors_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback func;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  const CustomButton({super.key,required this.text,required this.func,this.textColor,this.width,this.height = 43,this.fontSize,this.borderRadius,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: func,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorApp.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 48),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(24),
            ),
          ),
          child: Text(
            text,
            style: Styles.textSytle24
          ),
        ),
      ),
    );
  }
}