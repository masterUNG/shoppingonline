import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' as html;

class TermConditionBottomSheet extends StatefulWidget {
  const TermConditionBottomSheet({super.key});

  @override
  State<TermConditionBottomSheet> createState() =>
      _TermConditionBottomSheetState();
}

class _TermConditionBottomSheetState extends State<TermConditionBottomSheet> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: SizedBox(
            width: Get.width,
            height: Get.height * 0.6,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              children: [
                html.HtmlWidget(AppConstant.termCondition),
                SizedBox(height: 16),
                SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WidgetButton(
                        text: 'ยอมรับ เงื่อนไข',
                        onPressed: () {
                          appController.acceptTermAndCondition.value = true;
                          Get.back();
                        },
                      ),
                      WidgetButton(
                        text: 'ยกเลิก',
                        onPressed: () {
                          Get.back();
                        },
                        type: GFButtonType.outline2x,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
