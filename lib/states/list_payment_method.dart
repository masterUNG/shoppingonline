import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/widgets/widget_image_asset.dart';

class ListPaymentMethod extends StatefulWidget {
  const ListPaymentMethod({super.key});

  @override
  State<ListPaymentMethod> createState() => _ListPaymentMethodState();
}

class _ListPaymentMethodState extends State<ListPaymentMethod> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Payment Method', style: AppConstant.h2Style())),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            Container(
                decoration: AppConstant.bgGrey(),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Obx(() => RadioListTile(
                    value: 0,
                    groupValue: appController.indexChoosePaymentMethod.value,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Row(
                      children: [
                        WidgetImageAsset(
                            pathImage: 'images/pay_cash.png',
                            width: 36,
                            height: 36),
                        SizedBox(width: 8),
                        Text('เก็บเงินปลายทาง\n(Cash on Delivery - COD)'),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      appController.indexChoosePaymentMethod.value = value!;
                    }))),
            Container(
                decoration: AppConstant.bgGrey(),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Obx(() => RadioListTile(
                    value: 1,
                    groupValue: appController.indexChoosePaymentMethod.value,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Row(
                      children: [
                        WidgetImageAsset(
                            pathImage: 'images/pay_bank.png',
                            width: 36,
                            height: 36),
                        SizedBox(width: 8),
                        Text('โอนผ่านแอปธนาคาร\n(Mobile Banking)'),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      appController.indexChoosePaymentMethod.value = value!;
                    }))),
            Container(
                decoration: AppConstant.bgGrey(),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Obx(() => RadioListTile(
                    value: 2,
                    groupValue: appController.indexChoosePaymentMethod.value,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Row(
                      children: [
                        WidgetImageAsset(
                            pathImage: 'images/pay_cardit_card.png',
                            width: 36,
                            height: 36),
                        SizedBox(width: 8),
                        Text('บัตรเครดิต\n(Credit Card)'),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      appController.indexChoosePaymentMethod.value = value!;
                    }))),
            Container(
                decoration: AppConstant.bgGrey(),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Obx(() => RadioListTile(
                    value: 3,
                    groupValue: appController.indexChoosePaymentMethod.value,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Row(
                      children: [
                        WidgetImageAsset(
                            pathImage: 'images/pay_money.png',
                            width: 36,
                            height: 36),
                        SizedBox(width: 8),
                        Text('พร้อมเพย์\n(PromptPay / QR Code)'),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      appController.indexChoosePaymentMethod.value = value!;
                    }))),
          ],
        ));
  }
}
