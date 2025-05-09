// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/address_delivery_model.dart';

import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/states/widget_delivery_address.dart';
import 'package:shoppingonline/states/widget_payment_method.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class DisplayOrder extends StatefulWidget {
  const DisplayOrder({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  State<DisplayOrder> createState() => _DisplayOrderState();
}

class _DisplayOrderState extends State<DisplayOrder> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Display Order', style: AppConstant.h2Style())),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            Text('Delivery Address :',
                style: AppConstant.h2Style(fontSize: 18)),
            Container(
              decoration: AppConstant.bgGrey(),
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FutureBuilder(
                future: AppService().findAddressDeliveryModelByDocId(
                    docId: widget.orderModel.docIdAddressDelivery),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return WidgetProgress();
                  } else {
                    if (snapshot.hasData) {
                      AddressDeliveryModel addressDeliveryModel =
                          snapshot.data!;
                      return Row(
                        children: [

                          Icon(Icons.home_outlined),
                SizedBox(width: 6),

                          Text(
                            addressDeliveryModel.nameAddressDelivery,
                            style: AppConstant.h3Style(fontSize: 14),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  }
                },
              ),
            ),

            Text('Payment Method  :', style: AppConstant.h2Style(fontSize: 18)),

            Container(
            decoration: AppConstant.bgGrey(),
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              
              children: [
                Icon(Icons.payment_outlined),
                SizedBox(width: 6),
                Text(widget.orderModel.paymentMethod, style: AppConstant.h3Style(fontSize: 14)),
              ],
            )),
            
            // WidgetPaymentMethod(),

            Text('Itme List : ', style: AppConstant.h2Style(fontSize: 18)),
            SizedBox(height: 16),



            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.orderModel.listCarts.length,
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

                  DocumentReference documentReference = FirebaseFirestore
                      .instance
                      .collection('order${AppConstant.keyApp}')
                      .doc();

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
