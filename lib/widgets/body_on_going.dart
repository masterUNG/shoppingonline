import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/states/display_order.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';
import 'package:shoppingonline/widgets/widget_text_rich.dart';
import 'package:steps_indicator/steps_indicator.dart';

class BodyOnGoing extends StatelessWidget {
  const BodyOnGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppService().readMyOrder(status: 'Place'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WidgetProgress();
        } else {
          List<OrderModel> orderModels = snapshot.data!;
          if (orderModels.isEmpty) {
            return SizedBox();
          } else {




            return ListView.builder(
                itemCount: orderModels.length,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemBuilder: (context, index) => 
                
                
                Container(
                    decoration: AppConstant.bgGrey(),
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WidgetTextRich(head: 'TimeOrder : ', body: 'dd mm yyy HH:mm'),
                        WidgetTextRich(head: 'Status : ', body: orderModels[index].status),
                        SizedBox(height: 16),
                        StepsIndicator(
                                  lineLength: (800 - 64) / 4,
                                  nbSteps: 4,
                                  selectedStep: 0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: AppConstant.statusOrders
                                      .map(
                                        (e) => Text(
                                          e,
                                          style: AppConstant.h3Style(fontSize: 12),
                                        ),
                                      )
                                      .toList(),
                                ),
                        SizedBox(height: 16),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           WidgetTextRich(head: 'Ref-', body: orderModels[index].docId!, size: 12),
                           WidgetIconButton(icon: Icons.arrow_forward_ios,size: GFSize.SMALL,
                            onPressed: () {

                              Get.to(DisplayOrder(orderModel: orderModels[index]));
                             
                           }),
                         ],
                       ),
                      ],
                    ))
                    
                    
                    
                    
                    
                    
                    );
          }
        }
      },
    );
  }
}
