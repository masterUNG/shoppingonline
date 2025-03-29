import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingonline/state_web/order_shop.dart';
import 'package:shoppingonline/state_web/product_shop.dart';
import 'package:shoppingonline/state_web/profile_shop.dart';
import 'package:shoppingonline/utility/app_controller.dart';

class MainHomeWeb extends StatefulWidget {
  const MainHomeWeb({super.key});

  @override
  State<MainHomeWeb> createState() => _MainHomeWebState();
}

class _MainHomeWebState extends State<MainHomeWeb> {
  AppController appController = Get.put(AppController());

  var titles = <String>['ออเตอร์', 'สินค้า', 'โปรไฟร์'];

  var iconDatas = <IconData>[Icons.money, Icons.food_bank, Icons.person];

  var items = <BottomNavigationBarItem>[];

  var bodys = <Widget>[OrderShop(), ProductShop(), ProfileShop()];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < titles.length; i++) {
      items.add(
          BottomNavigationBarItem(icon: Icon(iconDatas[i]), label: titles[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(title: Text(titles[appController.indexBody.value])),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 800,height: 300,
              color: Colors.grey,
              child: Row(
                children: [
                  bodys[appController.indexBody.value],
                  // Text('data')
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: appController.indexBody.value,
          items: items,
          onTap: (value) {
            appController.indexBody.value = value;
          },
        )));
  }
}
