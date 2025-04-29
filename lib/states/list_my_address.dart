import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/bottom_sheet/add_address_bottom_sheet.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class ListMyAddress extends StatelessWidget {
  const ListMyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Address Delivery')),
      body: Text('data'),
      floatingActionButton: WidgetIconButton(
        icon: Icons.add_circle,
        size: GFSize.LARGE,
        onPressed: () {

          Get.bottomSheet(AddAddressBottomSheet(), isScrollControlled: true);
        },
      ),
    );
  }
}
