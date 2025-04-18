import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/cart_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppService().readAllCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WidgetProgress();
        } else {
          List<CartModel> cartModels = snapshot.data!;
          if (cartModels.isEmpty) {
            return Text('ไม่มีสินค้าใน ตระกล้า', style: AppConstant.h2Style());
          } else {
            return SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.5,
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: cartModels.length,
                        itemBuilder: (context, index) => FutureBuilder(
                              future: AppService().findProductById(
                                  docIdProduct: cartModels[index].docIdProduct),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return WidgetProgress();
                                } else {
                                  if (snapshot.hasData) {
                                    ProductModel productModel = snapshot.data!;
                                    return Container(
                                      height: 120,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          color: GFColors.LIGHT,
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                                child: Image.network(
                                                  productModel.urlImage,
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
                                                child: Text(productModel.name,
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
                                                child: Text(productModel.detail,
                                                    maxLines: 2,
                                                    style:
                                                        AppConstant.h3Style()),
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
                                                        '฿${productModel.price}',
                                                        style:
                                                            AppConstant.h2Style(
                                                                fontSize: 15)),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        WidgetIconButton(
                                                          icon: Icons
                                                              .remove_circle,
                                                          onPressed: () {
                                                            if (appController
                                                                    .amount
                                                                    .value >
                                                                1) {
                                                              appController
                                                                  .amount
                                                                  .value--;
                                                            }
                                                          },
                                                          size: GFSize.SMALL,
                                                          colorIcon:
                                                              GFColors.DANGER,
                                                        ),
                                                        Obx(() => Text(
                                                            appController.amount
                                                                .toString(),
                                                            style: AppConstant
                                                                .h2Style(
                                                                    fontSize:
                                                                        15))),
                                                        WidgetIconButton(
                                                            icon: Icons
                                                                .add_circle,
                                                            onPressed: () {
                                                              appController
                                                                  .amount
                                                                  .value++;
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
                                  } else {
                                    return SizedBox();
                                  }
                                }
                              },
                            )),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(color: Colors.grey,
                      width: Get.width,
                      height: Get.height * 0.5 -180,
                      child: Column(
                        children: [
                          Text('data'),
                          Spacer(),
                          WidgetButton(
                              text: 'Process to CheckOut', onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
