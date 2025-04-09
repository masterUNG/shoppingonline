import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/category_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/states/detail_product.dart';
import 'package:shoppingonline/states/list_all_product.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_image_asset.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class BodyShopping extends StatefulWidget {
  const BodyShopping({
    super.key,
  });

  @override
  State<BodyShopping> createState() => _BodyShoppingState();
}

class _BodyShoppingState extends State<BodyShopping> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: WidgetForm(
                  hintText: 'ค้นหา สินค้า', suffixIcon: Icon(Icons.search))),
          Positioned(
              top: 66,
              child: SizedBox(
                width: Get.width,
                height: Get.height - 66,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Text('กลุ่มสินค้า :',
                        style: AppConstant.h2Style(fontSize: 18)),
                    Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        width: Get.width,
                        height: 100,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: FutureBuilder(
                          future: AppService().readAllCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return WidgetProgress();
                            } else {
                              List<CategoryModel> categoryModles =
                                  snapshot.data!;
                              return ListView.builder(
                                itemCount: categoryModles.length,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                  width: 80,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            color: GFColors.LIGHT),
                                        child: WidgetImageAsset(
                                          pathImage:
                                              AppConstant.imageCats[index],
                                          width: 36,
                                        ),
                                      ),
                                      Text(
                                        categoryModles[index].nameCategory,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        )),
                    Text('Promotion :',
                        style: AppConstant.h2Style(fontSize: 18)),
                    SizedBox(height: 16),
                    FutureBuilder(
                      future: AppService().readAllProduct(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return WidgetProgress();
                        } else {
                          List<ProductModel> productModels = snapshot.data!;
                          return GFCarousel(
                              viewportFraction: 1.0,
                              enlargeMainPage: true,
                              height: 160,
                              items: productModels
                                  .map(
                                    (e) => Container(
                                        width: Get.width - 32,
                                        padding: EdgeInsets.all(16),
                                        // height: 150,
                                        decoration: BoxDecoration(
                                            color: GFColors.LIGHT,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Text('20%',
                                                    style:
                                                        AppConstant.h1Style()),
                                                Text('ซื้อทันที ลดทันที',
                                                    style: AppConstant.h3Style(
                                                        fontSize: 12)),
                                                WidgetButton(
                                                  text: 'Order New',
                                                  onPressed: () {},
                                                  // type: GFButtonType.outline,
                                                )
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                SizedBox(
                                                    width: 120,
                                                    height: 120,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child: Image.network(
                                                          e.urlImage,
                                                          fit: BoxFit.cover,
                                                        ))),
                                                // Text(e.name),
                                              ],
                                            )),
                                          ],
                                        )),
                                  )
                                  .toList());
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('สินค้าแนะนำ :',
                            style: AppConstant.h2Style(fontSize: 18)),
                        WidgetButton(
                          text: 'ดูทั้งหมด',
                          onPressed: () {
                            Get.to(ListAllProduct());
                          },
                          type: GFButtonType.transparent,
                        )
                      ],
                    ),
                    Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        width: Get.width,
                        // height: 350,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: FutureBuilder(
                          future: AppService().readAllProduct(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return WidgetProgress();
                            } else {
                              List<ProductModel> productModels = snapshot.data!;
                              return GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 1 / 1.3),
                                itemCount: 4,
                                itemBuilder: (context, index) => InkWell(onTap: () => Get.to(DetailProduct(productModel: productModels[index])),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                        color: GFColors.LIGHT,
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                productModels[index].urlImage,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productModels[index].name,
                                              style: AppConstant.h2Style(
                                                  fontSize: 14),
                                              maxLines: 1,
                                            ),
                                            Text(
                                              productModels[index].detail,
                                              style: AppConstant.h3Style(
                                                  fontSize: 11),
                                              maxLines: 2,
                                            ),
                                            Text(
                                              '฿${productModels[index].price}',
                                              style: AppConstant.h2Style(
                                                  fontSize: 14),
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
                        )),
                    SizedBox(height: 200),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
