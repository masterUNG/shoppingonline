import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/states/widget_delivery_address.dart';
import 'package:shoppingonline/states/widget_payment_method.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    // AppService().readAllCart().whenComplete(() {
    //   AppService().calculateSubtotal();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Check Out', style: AppConstant.h2Style())),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            WidgetDeliveryAddress(),
            WidgetPaymentMethod(),
            Text('Itme List : ', style: AppConstant.h2Style(fontSize: 18)),
            SizedBox(height: 16),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: appController.cartModels.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 110,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: GFColors.LIGHT,
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: appController.productModels.isEmpty
                                  ? SizedBox()
                                  : Image.network(
                                      appController
                                          .productModels[index].urlImage,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width - 16 - 16 - 80 - 16 - 16 - 16,
                              child: Text(
                                  appController.productModels[index].name,
                                  maxLines: 1,
                                  style: AppConstant.h2Style(fontSize: 15)),
                            ),
                            SizedBox(
                              width: Get.width - 16 - 16 - 80 - 16 - 16 - 16,
                              child: Text(
                                  appController.productModels[index].detail,
                                  maxLines: 1,
                                  style: AppConstant.h3Style()),
                            ),
                            SizedBox(
                              width: Get.width - 16 - 16 - 80 - 16 - 16 - 16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '฿${appController.productModels[index].price}',
                                      style: AppConstant.h2Style(fontSize: 15)),
                                  Text(
                                      'x${appController.cartModels[index].amount}',
                                      style: AppConstant.h2Style(fontSize: 15)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(height: 16),
            totalPanal(),
            SizedBox(height: 16),
            WidgetButton(text: 'Place Order', onPressed: ()async {

              





            }),
            SizedBox(height: 16),
          ],
        ));
  }

  Container totalPanal() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: GFColors.LIGHT, borderRadius: BorderRadius.circular(10)),
      width: Get.width - 16,
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('จำนวนรายการ', style: AppConstant.h3Style()),
            Text(appController.cartModels.length.toString(),
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('รวมราคา', style: AppConstant.h3Style()),
            Text('฿${appController.subTotals.last}',
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('ค่าขนส่ง', style: AppConstant.h3Style()),
            Text('฿${appController.deliverys.last}',
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('รวมราคาทั้งหมด',
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
            Text('฿${appController.subTotals.last}',
                style: AppConstant.h3Style(
                    fontWeight: FontWeight.bold,
                    color: AppConstant.primaryColor)),
          ]),
        ],
      ),
    );
  }
}
