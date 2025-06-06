import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/bottom_sheet/term_condition_bottom_sheet.dart';
import 'package:shoppingonline/models/user_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AppController appController = Get.put(AppController());

  final keyForm = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: Stack(
            children: [
              elementTop(),
              Positioned(
                top: 72,
                child: SizedBox(
                  width: Get.width,
                  height: Get.height - 72 - 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.8,
                        child: Form(
                          key: keyForm,
                          child: ListView(
                            children: [
                              SizedBox(height: 16),
                              WidgetText(text: AppConstant.signUpDescrip),
                              SizedBox(height: 16),
                              WidgetForm(
                                controller: nameController,
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return 'โปรดกรอก ชื่อ ด้วย คะ';
                                  } else {
                                    return null;
                                  }
                                },
                                label: 'ชื่อ :',
                              ),
                              SizedBox(height: 16),
                              WidgetForm(
                                controller: emailController,
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return 'โปรดกรอก อีเมล์ ด้วย คะ';
                                  } else if (!(p0!.isEmail)) {
                                    return 'อีเมล์ ผิด abc@abc.com';
                                  } else {
                                    return null;
                                  }
                                },
                                label: 'อีเมล์ :',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 16),
                              WidgetForm(
                                controller: passwordController,
                                validator: (p0) {
                                  if (p0?.isEmpty ?? true) {
                                    return 'โปรดกรอก รหัสผ่าน ด้วย คะ';
                                  } else if (p0!.length < 6) {
                                    return 'รหัสผ่าน ต้องมี 6 ตัวอักษร ขึ้นไป';
                                  } else {
                                    return null;
                                  }
                                },
                                label: 'รหัสผ่าน :',
                              ),
                              SizedBox(height: 16),
                              Obx(() => CheckboxListTile(
                                    value: appController
                                        .acceptTermAndCondition.value,
                                    onChanged: (value) {
                                      if (!appController
                                          .acceptTermAndCondition.value) {
                                        Get.bottomSheet(
                                            TermConditionBottomSheet(),
                                            isDismissible: false,
                                            isScrollControlled: true);
                                      }
                                    },
                                    title: WidgetText(text: 'ยอมรับเงื่อนไข'),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  )),
                              Obx(() => appController.displayErrorAccept.value
                                  ? appController.acceptTermAndCondition.value
                                      ? SizedBox()
                                      : WidgetText(
                                          text: 'โปรด ยอมรับเงื่อนไข',
                                          textStyle: AppConstant.h3Style(
                                              color: GFColors.DANGER))
                                  : SizedBox()),
                              SizedBox(height: 16),
                              WidgetButton(
                                text: 'สมัครสมาชิก',
                                onPressed: () async {
                                  appController.displayErrorAccept.value = true;
            
                                  if (keyForm.currentState!.validate()) {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then(
                                      (value) async {
                                        String uid = value.user!.uid;
            
                                        UserModel userModel = UserModel(
                                            uid: uid,
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text);
                                        await FirebaseFirestore.instance
                                            .collection(
                                                'user${AppConstant.keyApp}')
                                            .doc(uid)
                                            .set(userModel.toMap())
                                            .whenComplete(
                                          () {
                                            Get.snackbar('สมัคร สมาชิกสำเร็จ',
                                                'เชื่อคุณ ${nameController.text} ลงชื่อเข้าใช้งาน คร้บ',
                                                backgroundColor:
                                                    AppConstant.primaryColor,
                                                colorText: GFColors.WHITE);
            
                                            Get.offAllNamed('/signIn');
                                          },
                                        );
                                      },
                                    ).catchError((onError) {
                                      debugPrint('## onError --> ${onError.code}');
                                      debugPrint('## onError --> ${onError.message}');
            
                                      Get.snackbar('ไม่สามารถ สมัครได้',
                                          'เปลี่ยน Email ใหม่ Email นี้สมัครไปแล้ว',
                                          backgroundColor:
                                              AppConstant.primaryColor,
                                          colorText: GFColors.WHITE,
                                          snackPosition: SnackPosition.BOTTOM);
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              elementBottom(),
            ],
                    ),
                  ),
          )),
    );
  }

  Positioned elementBottom() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetText(text: 'ถ้ามี Account แล้ว คลิก '),
            WidgetButton(
              text: 'ลงชื่อเข้าใช้งาน',
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Positioned elementTop() => Positioned(
      left: 16,
      top: 16,
      child: Row(
        children: [
          WidgetBackButton(),
          SizedBox(width: 16),
          WidgetText(text: 'สมัครสมาชิก', textStyle: AppConstant.h2Style()),
        ],
      ));
}
