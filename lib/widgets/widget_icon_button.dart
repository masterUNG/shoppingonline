// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/utility/app_constant.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.type,
  });

  final IconData icon;
  final Function() onPressed;
  final GFButtonType? type;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: AppConstant.primaryColor,
      type: type ?? GFButtonType.transparent,
      shape: GFIconButtonShape.circle,
    );
  }
}
