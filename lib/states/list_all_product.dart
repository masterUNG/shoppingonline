// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/states/detail_product.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class ListAllProduct extends StatelessWidget {
  const ListAllProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('สินค้าแนะนำ', style: AppConstant.h2Style(fontSize: 20))),
      body: FutureBuilder(
        future: AppService().readAllProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WidgetProgress();
          } else {
            List<ProductModel> productModels = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1 / 1.3),
              itemCount: productModels.length,
              itemBuilder: (context, index) => InkWell(onTap: () => Get.to(DetailProduct(productModel: productModels[index])),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: GFColors.LIGHT,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              productModels[index].urlImage,
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productModels[index].name,
                            style: AppConstant.h2Style(fontSize: 14),
                            maxLines: 1,
                          ),
                          Text(
                            productModels[index].detail,
                            style: AppConstant.h3Style(fontSize: 11),
                            maxLines: 2,
                          ),
                          Text(
                            '฿${productModels[index].price}',
                            style: AppConstant.h2Style(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
