import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/states/widget_delivery_address.dart';
import 'package:shoppingonline/states/widget_payment_method.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Check Out', style: AppConstant.h2Style())),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
           
            WidgetDeliveryAddress(),
            WidgetPaymentMethod(),
            Text('Itme List :', style: AppConstant.h2Style(fontSize: 18)),
          ],
        ));
  }
}
