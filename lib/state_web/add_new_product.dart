import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/models/category_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  AppController appController = Get.put(AppController());

  final keyForm = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    appController.display.value = false;

    if (appController.urlImages.isNotEmpty) {
      appController.urlImages.clear();
    }

    if (appController.chooseCategoryModels.last != null) {
      appController.chooseCategoryModels.clear();
      appController.chooseCategoryModels.add(null);
    }
  }

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
                            padding: EdgeInsets.all(4),
                            child: Obx(() => appController.urlImages.isEmpty
                                ? Center(
                                    child: Obx(() => Text(
                                          'รูปภาพสินค้า',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: appController.display.value
                                                  ? GFColors.DANGER
                                                  : Colors.black),
                                        )))
                                : Image.network(appController.urlImages.last,
                                    width: 400 - 8 - 8,
                                    height: 400 - 8,
                                    fit: BoxFit.cover))),
                        WidgetIconButton(
                          icon: Icons.photo_outlined,
                          onPressed: () async {
                            String? urlImage =
                                await AppService().findUrlImageByUpload(path: 'products');
                            print('##6april ==> $urlImage');

                            appController.urlImages.add(urlImage!);
                          },
                          size: GFSize.LARGE,
                        )
                      ],
                    )),
                    SizedBox(width: 16),
                    Expanded(
                        child: Form(
                      key: keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('ข้อมูลทั่วไป :',
                              style: AppConstant.h2Style(fontSize: 20)),
                          SizedBox(height: 16),
                          WidgetForm(
                            label: 'ชื่อสินค้า :',
                            controller: nameController,
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'กรุณากรอก ชื่อสินค้า';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          WidgetForm(
                            label: 'รายละเอียดสินค้า :',
                            controller: detailController,
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'กรุณากรอก รายละเอียดสินค้า';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          FutureBuilder(
                            future: AppService().readAllCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return WidgetProgress();
                              } else {
                                List<CategoryModel> categoryModels =
                                    snapshot.data!;

                                return Obx(() => DropdownButtonFormField(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'โปรดเลือก กลุ่มของสินค้า';
                                        } else {
                                          return null;
                                        }
                                      },
                                      isExpanded: true,
                                      value: appController
                                          .chooseCategoryModels.last,
                                      hint: Text('โปรดเลือก กลุ่มของสินค้า'),
                                      items: categoryModels
                                          .map((e) => DropdownMenuItem(
                                              child: Text(e.nameCategory),
                                              value: e))
                                          .toList(),
                                      onChanged: (value) {
                                        appController.chooseCategoryModels
                                            .add(value);
                                      },
                                    ));
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          WidgetForm(
                            label: 'ราคาสินค้า :',
                            controller: priceController,
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'กรุณากรอก ราคาสินค้า';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          WidgetButton(
                              text: 'บันทึกสินค้า',
                              onPressed: () async {
                                appController.display.value = true;

                                if (keyForm.currentState!.validate()) {
                                  if (appController.urlImages.isNotEmpty) {
                                    ProductModel productModel = ProductModel(
                                        name: nameController.text,
                                        detail: detailController.text,
                                        docIdCatigory: appController
                                                .chooseCategoryModels
                                                .last!
                                                .docId ??
                                            '',
                                        price: priceController.text,
                                        urlImage: appController.urlImages.last,
                                        timestamp:
                                            Timestamp.fromDate(DateTime.now()),
                                        nameCatigory: appController
                                            .chooseCategoryModels
                                            .last!
                                            .nameCategory);

                                    await FirebaseFirestore.instance
                                        .collection(
                                            'product${AppConstant.keyApp}')
                                        .doc()
                                        .set(productModel.toMap())
                                        .whenComplete(() => Get.back());
                                  }
                                }
                              },
                              textStyle:
                                  AppConstant.h3Style(color: GFColors.WHITE),
                              fullWidthButton: true),
                        ],
                      ),
                    )),
                  ],
                ),
              ],
            ))
      ]),
    );
  }
}
