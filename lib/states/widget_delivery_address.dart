import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/states/list_my_address.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class WidgetDeliveryAddress extends StatelessWidget {
  const WidgetDeliveryAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Delivery Address :', style: AppConstant.h2Style(fontSize: 18)),
        Container(
            decoration: AppConstant.bgGrey(),
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_outlined),
                    SizedBox(width: 6),
                    Text('data'),
                  ],
                ),
                WidgetIconButton(
                    size: GFSize.SMALL,
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Get.to(ListMyAddress());
                    }),
              ],
            )),
      ],
    );
  }
}
