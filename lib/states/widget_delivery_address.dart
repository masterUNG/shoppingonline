import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/address_delivery_model.dart';
import 'package:shoppingonline/states/list_my_address.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class WidgetDeliveryAddress extends StatefulWidget {
  const WidgetDeliveryAddress({
    super.key,
  });

  @override
  State<WidgetDeliveryAddress> createState() => _WidgetDeliveryAddressState();
}

class _WidgetDeliveryAddressState extends State<WidgetDeliveryAddress> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Delivery Address :', style: AppConstant.h2Style(fontSize: 18)),
        Container(
            decoration: AppConstant.bgGrey(),
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => appController
                                .currentUserModels.last.docIdAddressDelivery ==
                            null
                        ?  Icon(Icons.question_mark, color: GFColors.DANGER,) : Icon(Icons.home_outlined, color: Colors.black)),
                    SizedBox(width: 6),
                    Obx(() => appController
                                .currentUserModels.last.docIdAddressDelivery ==
                            null
                        ? Text(
                            'ยังไม่ได้กำหนด',
                            style: AppConstant.h3Style(
                                color: GFColors.DANGER, fontSize: 14),
                          )
                        : FutureBuilder(
                            future: AppService()
                                .findAddressDeliveryModelByDocId(
                                    docId: appController.currentUserModels.last
                                        .docIdAddressDelivery!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return WidgetProgress();
                              } else {
                                if (snapshot.hasData) {
                                  AddressDeliveryModel addressDeliveryModel =
                                      snapshot.data!;
                                  return Text(
                                    addressDeliveryModel.nameAddressDelivery,
                                    style: AppConstant.h3Style(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }
                            },
                          )),
                  ],
                ),
                WidgetIconButton(
                    size: GFSize.SMALL,
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Get.to(ListMyAddress());
                    }),
              ],
            )),
      ],
    );
  }
}
