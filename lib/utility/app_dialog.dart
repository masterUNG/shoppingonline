import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/widgets/widget_button.dart';

class AppDialog {

  Future<bool> pinCodeDialog({required BuildContext context, String? pinCodetrue}) async {
  Completer<bool> completer = Completer<bool>();

  Get.dialog(AlertDialog(
    title: Text('Enter 4-digit PIN'),
    content: PinCodeTextField(
      length: 4,
      obscureText: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedColor: Colors.blue,
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: false,
      keyboardType: TextInputType.number,
      onCompleted: (value) {
        bool result;

        if (pinCodetrue != null) {
          result = value == pinCodetrue;
        } else {
          AppController appController = Get.put(AppController());
          result = value == appController.currentUserModels.last.pinCode.toString();
        }

        completer.complete(result); // ✅ ส่งค่าผลลัพธ์กลับไป
        Get.back(); // ปิด dialog
      },
      appContext: context,
    ),
    actions: [
      TextButton(
        child: Text('Cancel'),
        onPressed: () {
          completer.complete(false); // ถ้ายกเลิก -> false
          Get.back();
        },
      ),
    ],
  ));

  return completer.future; // ⏳ คืนค่าเมื่อผู้ใช้กรอก/ยกเลิก
}


  
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
