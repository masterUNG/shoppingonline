import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_button.dart';

class AppDialog {
  void normalDialog({
    Widget? icon,
    Widget? title,
    Widget? content,
    Widget? firstAction,
  }) {
    Get.dialog(
        AlertDialog(icon: icon, title: title, content: content, actions: [
      firstAction ?? SizedBox(),
      WidgetButton(
          text: 'Cancel',
          textStyle: AppConstant.h3Style(color: GFColors.WHITE),
          onPressed: () => Get.back())
    ]));
  }
}
