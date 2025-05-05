import 'package:flutter/material.dart';
import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class BodyOnGoing extends StatelessWidget {
  const BodyOnGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: AppService().readMyOrder(status: 'Place'), builder: (context, snapshot) {
      
      if (snapshot.connectionState == ConnectionState.waiting) {
        return WidgetProgress();
      } else {
        
        List<OrderModel> orderModels = snapshot.data!;
        if (orderModels.isEmpty) {
          return SizedBox();
        } else {
          return ListView.builder(itemCount: orderModels.length,padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) => Container(decoration: AppConstant.bgGrey(),margin: EdgeInsets.only(bottom: 8),padding: EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ref-${orderModels[index].docId!}', style: AppConstant.h3Style(fontSize: 12)),
                  Text('time'),
                ],
              )));
        }
      }
    },);
  }
}
