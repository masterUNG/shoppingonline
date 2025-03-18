// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/utility/app_constant.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final GFButtonType? type;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      color: AppConstant.primaryColor,
      shape: GFButtonShape.pills,
      padding: EdgeInsets.symmetric(horizontal: 32),
      textStyle: AppConstant.h3Style(fontWeight: FontWeight.w600, color: ((type == GFButtonType.transparent) || (type == GFButtonType.outline) || (type == GFButtonType.outline2x)) ?  AppConstant.primaryColor : null ),
      type: type ?? GFButtonType.solid,
    );
  }
}
