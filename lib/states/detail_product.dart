// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shoppingonline/models/cart_model.dart';

import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    appController.amount.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
            title: Text('รายละเอียดสินค้า',
                style: AppConstant.h2Style(fontSize: 20))),
        body: Column(
          children: [
            SizedBox(
                width: Get.width,
                height: Get.width,
                child: Image.network(widget.productModel.urlImage,
                    fit: BoxFit.cover)),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.productModel.name,
                          style: AppConstant.h2Style(fontSize: 18)),
                      Text('฿${widget.productModel.price}',
                          style: AppConstant.h2Style(
                              fontSize: 18, color: AppConstant.primaryColor)),
                    ],
                  ),
                  Text('Detail', style: AppConstant.h2Style(fontSize: 18)),
                  Text(widget.productModel.detail,
                      style: AppConstant.h3Style()),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetIconButton(
                      icon: Icons.remove_circle,
                      onPressed: () {
                        if (appController.amount.value > 1) {
                          appController.amount.value--;
                        }
                      },
                      size: GFSize.LARGE,
                      colorIcon: GFColors.DANGER,
                    ),
                    Obx(() => Text(appController.amount.toString(),
                        style: AppConstant.h2Style())),
                    WidgetIconButton(
                        icon: Icons.add_circle,
                        onPressed: () {
                          appController.amount.value++;
                        },
                        size: GFSize.LARGE),
                  ],
                ),
                WidgetButton(
                    text: 'ใส่ตระกร้า',
                    onPressed: () async {
                      context.loaderOverlay.show();

                      CartModel cartModel = CartModel(
                          timestamp: Timestamp.fromDate(DateTime.now()),
                          docIdProduct: widget.productModel.docId!,
                          amount: appController.amount.value);

                      debugPrint('## cartModel --> ${cartModel.toMap()}');

                      await FirebaseFirestore.instance
                          .collection('user${AppConstant.keyApp}')
                          .doc(appController.currentUserModels.last.uid)
                          .collection('cart')
                          .doc()
                          .set(cartModel.toMap())
                          .whenComplete(
                        () {
                          Get.back();

                          Get.snackbar('ใส่ตระกร้า สำเร็จ',
                              ' ${widget.productModel.name} ใส่ตระกร้า เรียบร้อย',
                              backgroundColor: AppConstant.light2Color);
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
