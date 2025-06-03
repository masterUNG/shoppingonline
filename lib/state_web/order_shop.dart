import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_dialog.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_image_network.dart';
import 'package:shoppingonline/widgets/widget_text_rich.dart';
import 'package:steps_indicator/steps_indicator.dart';

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
                  itemBuilder: (context, index) => Container(
                      decoration: AppConstant.bgGrey(),
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetTextRich(
                              head: 'TimeOrder : ', body: AppService().timeStameToString(timestamp: appController.orderModels[index].timestampPlaceOrder)),
                          WidgetTextRich(
                              head: 'Status : ',
                              body: appController.orderModels[index].status),
                          SizedBox(height: 16),
                          StepsIndicator(
                            lineLength: 800 / 4,
                            nbSteps: 4,
                            selectedStep: AppService().findSelectedStep(orderStatus: appController.orderModels[index].status),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: AppConstant.statusOrders
                                .map(
                                  (e) => Text(
                                    e,
                                    style: AppConstant.h3Style(fontSize: 12),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WidgetTextRich(
                                  head: 'Ref-',
                                  body: appController.orderModels[index].docId!,
                                  size: 12),
                              Obx(() {
                                return WidgetIconButton(
                                    icon: appController.displays[index]
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    size: GFSize.LARGE,
                                    onPressed: () {
                                      appController.displays[index] =
                                          !appController.displays[index];
                                    });
                              }),
                            ],
                          ),
                          Obx(() => appController.displays[index]
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Text('Itme List : ',
                                        style:
                                            AppConstant.h2Style(fontSize: 18)),
                                    SizedBox(height: 16),
                                    ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        // padding: EdgeInsets.symmetric(horizontal: 16),
                                        itemCount: appController
                                            .orderModels[index]
                                            .listCarts
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return FutureBuilder(
                                            future: AppService()
                                                .findProductById(
                                                    docIdProduct: appController
                                                            .orderModels[index]
                                                            .listCarts[index2]
                                                        ['docIdProduct']),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                ProductModel productModel =
                                                    snapshot.data!;

                                                return Container(
                                                  height: 110,
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                      color: GFColors.LIGHT,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  padding: EdgeInsets.all(16),
                                                  margin: EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 80,
                                                        height: 80,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            child: WidgetImageNetwork(
                                                                urlImage:
                                                                    productModel
                                                                        .urlImage)),
                                                      ),
                                                      SizedBox(width: 16),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 800 -
                                                                16 -
                                                                16 -
                                                                80 -
                                                                16 -
                                                                16 -
                                                                16,
                                                            child: Text(
                                                                productModel
                                                                    .name,
                                                                maxLines: 1,
                                                                style: AppConstant
                                                                    .h2Style(
                                                                        fontSize:
                                                                            15)),
                                                          ),
                                                          SizedBox(
                                                            width: 800 -
                                                                16 -
                                                                16 -
                                                                80 -
                                                                16 -
                                                                16 -
                                                                16,
                                                            child: Text(
                                                                productModel
                                                                    .detail,
                                                                maxLines: 1,
                                                                style: AppConstant
                                                                    .h3Style()),
                                                          ),
                                                          SizedBox(
                                                            width: 800 -
                                                                16 -
                                                                16 -
                                                                80 -
                                                                16 -
                                                                16 -
                                                                16,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    '฿${productModel.price}',
                                                                    style: AppConstant.h2Style(
                                                                        fontSize:
                                                                            15)),
                                                                Text(
                                                                    'x${appController.orderModels[index].listCarts[index2]['amount']}',
                                                                    style: AppConstant.h2Style(
                                                                        fontSize:
                                                                            15)),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            },
                                          );
                                        }),
                                    SizedBox(height: 16),
                                    //panal
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: GFColors.FOCUS,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      width: Get.width - 16,
                                      height: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('จำนวนรายการ',
                                                    style: AppConstant.h3Style(
                                                        color: GFColors.LIGHT)),
                                                Text(
                                                    appController
                                                        .orderModels[index]
                                                        .listCarts
                                                        .length
                                                        .toString(),
                                                    style: AppConstant.h3Style(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: GFColors.LIGHT)),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('รวมราคา',
                                                    style: AppConstant.h3Style(
                                                        color: GFColors.LIGHT)),
                                                Text(
                                                    '฿${appController.orderModels[index].cartsCost}',
                                                    style: AppConstant.h3Style(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: GFColors.LIGHT)),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('ค่าขนส่ง',
                                                    style: AppConstant.h3Style(
                                                        color: GFColors.LIGHT)),
                                                Text(
                                                    '฿${appController.orderModels[index].deliveryCost}',
                                                    style: AppConstant.h3Style(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: GFColors.LIGHT)),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('รวมราคาทั้งหมด',
                                                    style: AppConstant.h3Style(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: GFColors.LIGHT)),
                                                Text(
                                                    '฿${appController.orderModels[index].cartsCost}',
                                                    style: AppConstant.h3Style(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            GFColors.WARNING)),
                                              ]),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    appController.orderModels[index].status == AppConstant.statusOrders.first ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        WidgetButton(
                                            text: 'Plate -> Prepared',
                                            type: GFButtonType.outline,
                                            onPressed: () {
                                              
                                              AppDialog().normalDialog(
                                                  title: Text('เปลี่ยน Status',
                                                      style: AppConstant
                                                          .h2Style()),
                                                  content: Text(
                                                      'ต้องการเปลี่ยน Status จาก Plate ไปเป็น Prepared โปรด Confirm',
                                                      style: AppConstant
                                                          .h3Style()), firstAction: WidgetButton(text: 'Confirm', textStyle: AppConstant.h3Style(color: GFColors.WHITE),
                                                           onPressed: ()async {

                                                            Map<String,dynamic> map = appController.orderModels[index].toMap();
                                                            map['status'] = AppConstant.statusOrders[1];

                                                            await AppService().editOrder(mapOrder: map).whenComplete(() {
                                                              
                                                              appController.orderModels[index] = OrderModel.fromMap(map);

                                                              Get.back();
                                                            },);
                                                            
                                                          },));
                                            }),
                                      ],
                                    ) : SizedBox(),
                                    SizedBox(height: 16),
                                  ],
                                )
                              : SizedBox()),
                        ],
                      )),
                )),
        ));
  }
}
