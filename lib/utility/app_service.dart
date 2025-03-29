import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/state_web/main_home_web.dart';
import 'package:shoppingonline/utility/app_constant.dart';

class AppService {
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
              primarySnackBar(title: 'ลงชื่อเข้าใช้งาน ไม่ถูกต้อง', massage: 'ต้องใช้ Account สำหรับ ร้านค้า เท่านั้น');
            }
          } else {
            //for Mobile
             Get.offAllNamed('/mainHome');
          }


         
        })
        .catchError((onError) {
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
