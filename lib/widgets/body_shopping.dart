import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/category_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_image_asset.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class BodyShopping extends StatelessWidget {
  const BodyShopping({
    super.key,
  });

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
                                          pathImage: AppConstant.imageCats[index],
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
                    Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: Get.width,
                        height: 150,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Banner')),
                    Text('สินค้าแนะนำ :',
                        style: AppConstant.h2Style(fontSize: 18)),
                    Text('Promotion :',
                        style: AppConstant.h2Style(fontSize: 18)),
                    Container(
                        decoration: BoxDecoration(border: Border.all()),
                        width: Get.width,
                        height: 350,
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Text('GridView Product')),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
