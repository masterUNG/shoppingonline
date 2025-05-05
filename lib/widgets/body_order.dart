import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/body_on_going.dart';

class BodyOrder extends StatelessWidget {
  const BodyOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                ButtonsTabBar(decoration: BoxDecoration(color: AppConstant.primaryColor),
                      unselectedDecoration: BoxDecoration(color: GFColors.LIGHT),
                    labelStyle: AppConstant.h3Style(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: AppConstant.h3Style(
                        color: AppConstant.primaryColor,
                        fontWeight: FontWeight.w700),
                    radius: 30,
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    tabs: <Widget>[
                      Tab(text: 'OnGoing'),
                      Tab(text: 'Complete'),
                      Tab(text: 'Cancel'),
                    ]),
                Expanded(
                  child: TabBarView(children: <Widget>[
                    BodyOnGoing(),
                    Text('Complete'),
                    Text('Cancel'),
                  ]),
                ),
              ],
            )));
  }
}
