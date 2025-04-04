import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/widgets/widget_button.dart';

class AppDialog {
  void normalDialog({
    Widget? icon,
    Widget? title,
    Widget? content,
  }) {
    Get.dialog(AlertDialog(
        icon: icon,
        title: title,
        content: content,
        actions: [WidgetButton(text: 'Cancel', onPressed: () => Get.back())]));
  }
}
