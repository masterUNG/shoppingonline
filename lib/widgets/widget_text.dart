// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shoppingonline/utility/app_constant.dart';

class WidgetText extends StatelessWidget {
  const WidgetText({
    super.key,
    required this.text,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle ?? AppConstant.h3Style(), );
  }

  
}
