import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class BasicBottomSheet extends StatelessWidget {
  const BasicBottomSheet({super.key});

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
          height: Get.height,
          child: Stack(
            children: [
              Positioned(left: 16, top: 16, child: WidgetBackButton()),
              Positioned(
                  left: 16,
                  top: 65,
                  child: WidgetText(
                      text: 'Title', textStyle: AppConstant.h2Style())),
            ],
          ),
        ),
      ),
    );
  }
}
