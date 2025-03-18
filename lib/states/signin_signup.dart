import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_image_asset.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class SignInSignUp extends StatelessWidget {
  const SignInSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32),
          WidgetImageAsset(pathImage: 'images/intro4.png'),
          SizedBox(height: 16),
          WidgetText(
              text: AppConstant.slogan1, textStyle: AppConstant.h2Style()),
              
          WidgetText(
              text: AppConstant.slogan2, textStyle: AppConstant.h2Style()),
              SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: WidgetText(text: AppConstant.subSlogan),
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            WidgetButton(text: 'ลงชื่อใช้งาน', onPressed: () {}),
            WidgetButton(text: 'สมัครใช้งาน', onPressed: () {}),
          ]),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
