import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class WidgetBackButton extends StatelessWidget {
  const WidgetBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetIconButton(
      icon: Icons.arrow_back,
      onPressed: () {
        Get.back();
      },
      type: GFButtonType.outline,
    );
  }
}
