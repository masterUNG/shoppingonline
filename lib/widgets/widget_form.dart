// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.label,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(onChanged: onChanged,
        obscureText: obscureText ?? false,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: AppConstant.h3Style(),
        decoration: InputDecoration(
            filled: true,fillColor: GFColors.LIGHT,
            border: InputBorder.none,
            labelText: label,
            labelStyle: AppConstant.h3Style(),
            errorStyle: AppConstant.h3Style(color: GFColors.DANGER),
            hintText: hintText,
            hintStyle: AppConstant.h3Style(),
            suffixIcon: suffixIcon));
  }
}
