
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/states/widget_delivery_address.dart';
import 'package:shoppingonline/states/widget_payment_method.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
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
            WidgetButton(
                text: 'Place Order',
                onPressed: () async {
                  List<Map<String, dynamic>> listCarts = [];
                  for (var element in appController.cartModels) {
                    listCarts.add(element.toMap());
                  }

                  OrderModel orderModel = OrderModel(
                      uidOrder: appController.currentUserModels.last.uid,
                      status: AppConstant.statusOrders[0],
                      paymentMethod: AppConstant.paymentMethods[
                          appController.indexChoosePaymentMethod.value],
                      docIdAddressDelivery: appController
                          .currentUserModels.last.docIdAddressDelivery!,
                      deliveryCost: appController.deliveryCosts.last,
                      listCarts: listCarts,
                      cartsCost: appController.cartCosts.last,
                      timestampPlaceOrder: Timestamp.fromDate(DateTime.now()));

                  DocumentReference documentReference =
                      FirebaseFirestore.instance.collection('order${AppConstant.keyApp}').doc();

                  await documentReference.set(orderModel.toMap()).whenComplete(
                    () async {

                      Map<String, dynamic> map = orderModel.toMap();
                      map['docId'] = documentReference.id;

                      await FirebaseFirestore.instance
                          .collection('order${AppConstant.keyApp}')
                          .doc(documentReference.id)
                          .update(map)
                          .whenComplete(
                        () async {
                          

                          for (var element in appController.cartModels) {
                            await FirebaseFirestore.instance
                                .collection('user${AppConstant.keyApp}')
                                .doc(appController.currentUserModels.last.uid)
                                .collection('cart')
                                .doc(element.docId)
                                .delete();
                          }

                          Get.back(result: true);
                        },
                      );
                    },
                  );
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
            Text('฿${appController.cartCosts.last}',
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('ค่าขนส่ง', style: AppConstant.h3Style()),
            Text('฿${appController.deliveryCosts.last}',
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('รวมราคาทั้งหมด',
                style: AppConstant.h3Style(fontWeight: FontWeight.bold)),
            Text('฿${appController.cartCosts.last}',
                style: AppConstant.h3Style(
                    fontWeight: FontWeight.bold,
                    color: AppConstant.primaryColor)),
          ]),
        ],
      ),
    );
  }
}
