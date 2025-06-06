// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/widgets/widget_icon_button.dart';

class WidgetBackButton extends StatelessWidget {
  const WidgetBackButton({
    super.key,
    this.onPress,
  });

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return WidgetIconButton(
      icon: Icons.arrow_back,
      onPressed: onPress ?? () => Get.back(),
      type: GFButtonType.outline,size: GFSize.SMALL,
    );
  }
}
