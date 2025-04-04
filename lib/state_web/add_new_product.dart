import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('เพิ่มสินค้าใหม่', style: AppConstant.h1Style()),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('รูปภาพสินค้า :',
                            style: AppConstant.h2Style(fontSize: 20)),
                        SizedBox(height: 16),
                        Container(
                            width: 400 - 8,
                            height: 400,
                            decoration: AppConstant.borderRadius(),
                            child: Center(child: Text('รูปภาพสินค้า'))),
                        WidgetIconButton(
                          icon: Icons.photo_outlined,
                          onPressed: () {},
                          size: GFSize.LARGE,
                        )
                      ],
                    )),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('ข้อมูลทั่วไป :',
                            style: AppConstant.h2Style(fontSize: 20)),
                        SizedBox(height: 16),
                        WidgetForm(label: 'ชื่อสินค้า :'),
                        SizedBox(height: 16),
                        WidgetForm(label: 'รายละเอียดสินค้า :'),
                        SizedBox(height: 16),
                        WidgetForm(label: 'ราคาสินค้า :'),
                        SizedBox(height: 16),
                        WidgetButton(
                            text: 'บันทึกสินค้า',
                            onPressed: () {},
                            textStyle:
                                AppConstant.h3Style(color: GFColors.WHITE),
                            fullWidthButton: true),
                      ],
                    )),
                  ],
                ),
              ],
            ))
      ]),
    );
  }

  
}
