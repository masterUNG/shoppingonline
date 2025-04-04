import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/state_web/add_new_product.dart';
import 'package:shoppingonline/widgets/widget_button.dart';

class ProductShop extends StatefulWidget {
  const ProductShop({super.key});

  @override
  State<ProductShop> createState() => _ProductShopState();
}

class _ProductShopState extends State<ProductShop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 800,
        child: Scaffold(
          body: Text('Product'),
          floatingActionButton: WidgetButton(
              text: 'เพิ่มสินค้าใหม่',
              onPressed: () {
                Get.to(AddNewProduct())?.then(
                  (value) {
                    setState(() {});
                  },
                );
              },
              type: GFButtonType.outline2x),
        ));
  }
}
