import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/bottom_sheet/term_condition_bottom_sheet.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            elementTop(),
            Positioned(
              top: 72,
              child: SizedBox(
                width: Get.width,
                height: Get.height - 72 - 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: ListView(
                        children: [
                          SizedBox(height: 16),
                          WidgetText(text: AppConstant.signInDescrip),
                          SizedBox(height: 16),
                          WidgetForm(
                            label: 'ชื่อ :',
                          ),
                          SizedBox(height: 16),
                          WidgetForm(
                            label: 'อีเมล์ :',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16),
                          WidgetForm(
                            label: 'รหัสผ่าน :',
                          ),
                          SizedBox(height: 16),
                          CheckboxListTile(
                            value: false,
                            onChanged: (value) {
                              Get.bottomSheet(TermConditionBottomSheet(),
                                  isDismissible: false,
                                  isScrollControlled: true);
                            },
                            title: WidgetText(text: 'ยอมรับเงื่อนไข'),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          SizedBox(height: 16),
                          WidgetButton(
                            text: 'สมัครสมาชิก',
                            onPressed: () {},
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            elementBottom(),
          ],
        ),
      )),
    );
  }

  Positioned elementBottom() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetText(text: 'ถ้ามี Account แล้ว คลิก '),
            WidgetButton(
              text: 'ลงชื่อเข้าใช้งาน',
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Positioned elementTop() => Positioned(
      left: 16,
      top: 16,
      child: Row(
        children: [
          WidgetBackButton(),
          SizedBox(width: 16),
          WidgetText(text: 'สมัครสมาชิก', textStyle: AppConstant.h2Style()),
        ],
      ));
}
