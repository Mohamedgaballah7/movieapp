
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

typedef OnValidator = String? Function(String?);
class CustomTextField extends StatelessWidget {
  Color colorBorderSide;
  Color? cursorColor;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController? controller;
  OnValidator? validator;
  TextInputType? keyboardType;
  bool obscureText ;
  int? maxLines;
  TextStyle? style;

  CustomTextField({super.key,
     this.colorBorderSide = AppColors.greyLightColor,
     this.cursorColor,
     this.hintText,
     this.hintStyle,
     this.labelText,
     this.labelStyle,
     this.prefixIcon,
     this.suffixIcon,
     required this.controller,
     this.validator,
     this.keyboardType = TextInputType.text,
     this.obscureText = false,
     this.maxLines,
     this.style,
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
        focusedBorder: builtDecorationBorder(colorBorderSide: colorBorderSide),
        errorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
        focusedErrorBorder: builtDecorationBorder(colorBorderSide: AppColors.redColor),
        hintText: hintText,
        hintStyle: hintStyle?? AppStyles.medium12Gray,
        labelText: labelText,
        labelStyle: labelStyle?? AppStyles.medium12Gray,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: AppStyles.medium14White.copyWith(color: AppColors.redColor),
      ),
      cursorColor: cursorColor,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines ?? 1,
      style: style,
    );
  }
  OutlineInputBorder builtDecorationBorder({required Color colorBorderSide}){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorBorderSide,
        width: 1,
      ),
    );
  }
}
