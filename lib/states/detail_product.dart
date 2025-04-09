// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text(widget.productModel.detail, style: AppConstant.h3Style()),
              ],
            ),
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetIconButton(
                    icon: Icons.remove_circle,
                    onPressed: () {},
                    size: GFSize.LARGE,
                    colorIcon: GFColors.DANGER,
                  ),
                  Text(appController.amount.toString(),
                      style: AppConstant.h2Style()),
                  WidgetIconButton(
                      icon: Icons.add_circle,
                      onPressed: () {},
                      size: GFSize.LARGE),
                ],
              ),
              WidgetButton(text: 'ใส่ตระกร้า', onPressed: () {
                
              }),
            ],
          ),
        ],
      ),
    );
  }
}
