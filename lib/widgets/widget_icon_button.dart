// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/utility/app_constant.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.type,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final Function() onPressed;
  final GFButtonType? type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: AppConstant.primaryColor,
      type: type ?? GFButtonType.transparent,
      shape: GFIconButtonShape.circle,size: size ?? GFSize.MEDIUM,
    );
  }
}
