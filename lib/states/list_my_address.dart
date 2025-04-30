import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/bottom_sheet/add_address_bottom_sheet.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class ListMyAddress extends StatefulWidget {
  const ListMyAddress({super.key});

  @override
  State<ListMyAddress> createState() => _ListMyAddressState();
}

class _ListMyAddressState extends State<ListMyAddress> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().readAllAddressDeliveryModel();

    appController.chooseDocIdAddressDelicerys
        .add(appController.currentUserModels.last.docIdAddressDelivery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Address Delivery')),
      body: Obx(
        () => appController.addressDeliveryModels.isEmpty
            ? SizedBox()
            : ListView.builder(padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: appController.addressDeliveryModels.length,
                itemBuilder: (context, index) => Obx(() {
                  return Container(
                    decoration: AppConstant.bgGrey(),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: RadioListTile(
                      title: Text(appController
                          .addressDeliveryModels[index].nameAddressDelivery),
                      value: appController.addressDeliveryModels[index].docId,
                      groupValue:
                          appController.chooseDocIdAddressDelicerys.last,
                      onChanged: (value) async {
                        appController.chooseDocIdAddressDelicerys.add(value);

                        Map<String, dynamic> map =
                            appController.currentUserModels.last.toMap();
                        map['docIdAddressDelivery'] = value;
                        await AppService().editProfile(mapProfile: map);
                      },
                    ),
                  );
                }),
              ),
      ),
      floatingActionButton: WidgetIconButton(
        icon: Icons.add_circle,
        size: GFSize.LARGE,
        onPressed: () {
          Get.bottomSheet(AddAddressBottomSheet(), isScrollControlled: true)
              .then(
            (value) {
              AppService().readAllAddressDeliveryModel();
            },
          );
        },
      ),
    );
  }
}
