import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class AddAddressBottomSheet extends StatelessWidget {
  const AddAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        width: Get.width,height: Get.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView(padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
              SizedBox(height: 16),
            Row(
              children: [
                WidgetBackButton(),
              ],
            ),
              SizedBox(height: 16),
            Container(decoration: BoxDecoration(border: Border.all()),width: Get.width,height: Get.width *0.6,
              child: Text('data')),
              SizedBox(height: 16),
            WidgetForm(label: 'Name Address Delivery :'),
              SizedBox(height: 16),
            WidgetButton(text: 'Save', onPressed: () {
              
            },fullWidthButton: true),
          ],
        ),
      ),
    );
  }
}
