// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/state_web/add_new_product.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_image_network.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

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
          body: FutureBuilder(
            future: AppService().readAllProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return WidgetProgress();
              } else {
                List<ProductModel> productModels = snapshot.data!;
                if (productModels.isEmpty) {
                  return Text('ไม่มี Product');
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 1 / 1.4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4),
                    itemCount: productModels.length,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetImageNetwork(
                              urlImage: productModels[index].urlImage,
                              width: 110,
                              height: 110),
                          SizedBox(height: 16),
                          Text(productModels[index].name,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              maxLines: 1),
                          Text(productModels[index].nameCatigory),
                        ],
                      ),
                    ),
                  );
                }
              }
            },
          ),
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
