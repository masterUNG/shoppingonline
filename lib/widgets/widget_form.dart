// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shoppingonline/utility/app_constant.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.label,
    this.keyboardType,
  }) : super(key: key);

  final String? label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: AppConstant.h3Style(),
      decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          labelText: label,
          labelStyle: AppConstant.h3Style()),
    );
  }
}
