import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class OrderShop extends StatefulWidget {
  const OrderShop({super.key});

  @override
  State<OrderShop> createState() => _OrderShopState();
}

class _OrderShopState extends State<OrderShop> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().readAllOrder();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 800,
        child: Scaffold(
          body: Obx(() => appController.orderModels.isEmpty
              ? SizedBox()
              : ListView.builder(
                  itemCount: appController.orderModels.length,
                  itemBuilder: (context, index) => WidgetText(
                      text: appController
                          .orderModels[index].docIdAddressDelivery),
                )),
        ));
  }
}
