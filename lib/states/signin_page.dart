import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AppController appController = Get.put(AppController());

  final keyForm = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: SafeArea(
            child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Stack(children: [
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
                                child: ListView(children: [
                                  SizedBox(height: 16),
                                  WidgetText(text: AppConstant.signInDescrip),
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
                                    hintText: 'อีเมล์ :',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 16),
                                  Obx(() => WidgetForm(
                                        obscureText: appController.redEye.value,
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
                                        hintText: 'รหัสผ่าน :',
                                        suffixIcon: WidgetIconButton(
                                          icon: appController.redEye.value
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined,
                                          onPressed: () {
                                            appController.redEye.value =
                                                !appController.redEye.value;
                                          },
                                        ),
                                      )),
                                  SizedBox(height: 16),
                                  WidgetButton(
                                      text: 'ลงชื่อเข้าใช้งาน',
                                      onPressed: () {
                                        if (keyForm.currentState!.validate()) {

                                          context.loaderOverlay.show();

                                          AppService().processCheckAuthen(
                                              email: emailController.text,
                                              password: passwordController.text).whenComplete(() {
                                                
                                                context.loaderOverlay.hide();
                                              },);
                                        }
                                      })
                                ]))),
                      ],
                    ),
                  ),
                ),
              ])),
        )),
      ),
    );
  }

  Positioned elementTop() => Positioned(
      left: 16,
      top: 16,
      child: Row(
        children: [
          WidgetBackButton(
            onPress: () {
              Get.offAllNamed('/signinsignup');
            },
          ),
          SizedBox(width: 16),
          WidgetText(
              text: 'ลงชื่อเข้าใช้งาน', textStyle: AppConstant.h2Style()),
        ],
      ));
}
