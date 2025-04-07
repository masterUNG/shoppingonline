import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingonline/models/category_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/state_web/main_home_web.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<List<ProductModel>> readAllProduct() async {

    var productModels = <ProductModel>[];

    var result = await FirebaseFirestore.instance.collection('product${AppConstant.keyApp}').orderBy('timestamp', descending: true).get();
    for (var element in result.docs) {
      
      ProductModel productModel = ProductModel.fromMap(element.data());
      Map<String,dynamic> map = productModel.toMap();

      productModels.add(ProductModel.fromMap(map));
    }

    return productModels;

  }

  Future<List<CategoryModel>> readAllCategory() async {

    var categoryModels = <CategoryModel>[];

    var result = await FirebaseFirestore.instance.collection('category').get();
    for (var element in result.docs) {

      CategoryModel categoryModel = CategoryModel.fromMap(element.data());
      Map<String,dynamic> map = categoryModel.toMap();

      map['docId'] = element.id;
      categoryModels.add(CategoryModel.fromMap(map));
      
    }


    return categoryModels;
  }

  Future<String?> findUrlImageByUploadWeb() async {
    String? urlImage;

    var result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      var imageByte = await result.readAsBytes();

      FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
          bucket: 'gs://shoppingonline-57e3c.firebasestorage.app');
      Reference reference = firebaseStorage
          .ref()
          .child('products/${DateTime.now().toIso8601String()}.jpg');
      UploadTask uploadTask = reference.putData(
          imageByte, SettableMetadata(contentType: 'image/jpeg'));

      await uploadTask.whenComplete(
        () async {
          urlImage = await reference.getDownloadURL();
        },
      );
    }

    return urlImage;
  }

  Future<void> processCheckAuthen({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((onValue) {
      if (GetPlatform.isWeb) {
        //for Web
        if (email == 'admin${AppConstant.keyApp}@abc.com') {
          Get.offAll(MainHomeWeb());
        } else {
          primarySnackBar(
              title: 'ลงชื่อเข้าใช้งาน ไม่ถูกต้อง',
              massage: 'ต้องใช้ Account สำหรับ ร้านค้า เท่านั้น');
        }
      } else {
        //for Mobile
        Get.offAllNamed('/mainHome');
      }
    }).catchError((onError) {
      primarySnackBar(
          title: 'ลงชื่อเข้าใช้งาน ไม่ถูกต้อง',
          massage: 'อีเมล์ หรือ รหัสผ่าน ไม่ถูกต้อง กรุณาลองใหม่');
    });
  }

  void primarySnackBar({
    required String title,
    required String massage,
  }) {
    Get.snackbar(title, massage,
        backgroundColor: AppConstant.primaryColor,
        colorText: GFColors.WHITE,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.warning_amber_outlined,
          color: GFColors.WHITE,
          size: GFSize.LARGE,
        ),
        padding: EdgeInsets.all(16));
  }
}
