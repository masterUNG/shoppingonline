import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/states/check_out.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_dialog.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class BodyCart extends StatefulWidget {
  const BodyCart({
    super.key,
  });

  @override
  State<BodyCart> createState() => _BodyCartState();
}

class _BodyCartState extends State<BodyCart> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    appController.display.value = false;

    AppService().readAllCart().whenComplete(() {
      AppService().calculateSubtotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appController.display.value
          ? SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                children: [
                  appController.productModels.isEmpty
                      ? SizedBox()
                      : SizedBox(
                          width: Get.width,
                          height: Get.height * 0.5 + 50,
                          child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: appController.cartModels.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 140,
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
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: appController
                                                    .productModels.isEmpty
                                                ? SizedBox()
                                                : Image.network(
                                                    appController
                                                        .productModels[index]
                                                        .urlImage,
                                                    fit: BoxFit.cover,
                                                  )),
                                      ),
                                      SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width -
                                                16 -
                                                16 -
                                                80 -
                                                16 -
                                                16 -
                                                16,
                                            child: Text(
                                                appController
                                                    .productModels[index].name,
                                                maxLines: 1,
                                                style: AppConstant.h2Style(
                                                    fontSize: 15)),
                                          ),
                                          SizedBox(
                                            width: Get.width -
                                                16 -
                                                16 -
                                                80 -
                                                16 -
                                                16 -
                                                16,
                                            child: Text(
                                                appController
                                                    .productModels[index]
                                                    .detail,
                                                maxLines: 2,
                                                style: AppConstant.h3Style()),
                                          ),
                                          SizedBox(
                                            width: Get.width -
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
                                                    '฿${appController.productModels[index].price}',
                                                    style: AppConstant.h2Style(
                                                        fontSize: 15)),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    WidgetIconButton(
                                                      icon: Icons.remove_circle,
                                                      onPressed: () {
                                                        if (appController
                                                                    .amounts[
                                                                index] >
                                                            1) {
                                                          appController
                                                              .amounts[index]--;

                                                          AppService()
                                                              .calculateSubtotal();
                                                        } else {
                                                          AppDialog()
                                                              .normalDialog(
                                                                  title: WidgetText(
                                                                      text:
                                                                          'Delete Item',
                                                                      textStyle:
                                                                          AppConstant
                                                                              .h2Style()),
                                                                  content:
                                                                      WidgetText(
                                                                          text:
                                                                              'ต้องการลบ ${appController.productModels[index].name} ออกจาก ตระกล้า กรุณา Confirm'),
                                                                  firstAction:
                                                                      WidgetButton(
                                                                    text:
                                                                        'Confirm',
                                                                    type: GFButtonType
                                                                        .outline,
                                                                    onPressed:
                                                                        () async {
                                                                      debugPrint(
                                                                          '##29june docId --> ${appController.cartModels[index].docId}');

                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'user${AppConstant.keyApp}')
                                                                          .doc(appController
                                                                              .currentUserModels
                                                                              .last
                                                                              .uid)
                                                                          .collection(
                                                                              'cart')
                                                                          .doc(appController
                                                                              .cartModels[index]
                                                                              .docId)
                                                                          .delete()
                                                                          .then(
                                                                        (value) {
                                                                          Get.back();

                                                                          AppService()
                                                                              .readAllCart()
                                                                              .whenComplete(() {
                                                                            AppService().calculateSubtotal();
                                                                          });

                                                                          // appController.cartModels.removeAt(index);
                                                                        },
                                                                      );
                                                                    },
                                                                  ));
                                                        }
                                                      },
                                                      size: GFSize.SMALL,
                                                      colorIcon:
                                                          GFColors.DANGER,
                                                    ),
                                                    Obx(() => Text(
                                                        appController
                                                            .amounts[index]
                                                            .toString(),
                                                        style:
                                                            AppConstant.h2Style(
                                                                fontSize: 15))),
                                                    WidgetIconButton(
                                                        icon: Icons.add_circle,
                                                        onPressed: () {
                                                          appController
                                                              .amounts[index]++;

                                                          AppService()
                                                              .calculateSubtotal();
                                                        },
                                                        size: GFSize.SMALL),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  Positioned(
                    bottom: 50,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: GFColors.LIGHT,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: Get.width - 16,
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('จำนวนรายการ',
                                    style: AppConstant.h3Style()),
                                Text(appController.cartModels.length.toString(),
                                    style: AppConstant.h3Style(
                                        fontWeight: FontWeight.bold)),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('รวมราคา', style: AppConstant.h3Style()),
                                Text('฿${appController.cartCosts.last}',
                                    style: AppConstant.h3Style(
                                        fontWeight: FontWeight.bold)),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ค่าขนส่ง', style: AppConstant.h3Style()),
                                Text('฿${appController.deliveryCosts.last}',
                                    style: AppConstant.h3Style(
                                        fontWeight: FontWeight.bold)),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('รวมราคาทั้งหมด',
                                    style: AppConstant.h3Style(
                                        fontWeight: FontWeight.bold)),
                                Text('฿${appController.cartCosts.last}',
                                    style: AppConstant.h3Style(
                                        fontWeight: FontWeight.bold,
                                        color: AppConstant.primaryColor)),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 8,
                    child: SizedBox(
                      width: Get.width - 16,
                      // margin: EdgeInsets.symmetric(horizontal: 8),
                      child: WidgetButton(
                        text: 'Process to CheckOut',
                        onPressed: () {
                          Get.to(CheckOut())?.then(
                            (value) {
                              if (value ?? false) {
                                AppService().readAllCart().whenComplete(() {
                                  AppService().calculateSubtotal();
                                });
                              }
                            },
                          );
                        },
                        // fullWidthButton: true,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox();
    });
  }
}
