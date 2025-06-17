import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoppingonline/states/widget_delivery_address.dart';
import 'package:shoppingonline/states/widget_payment_method.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_dialog.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_icon_button.dart';
import 'package:shoppingonline/widgets/widget_image_asset.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({
    super.key,
  });

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    children: [
                      Obx(() => appController
                              .currentUserModels.last.avatar!.isEmpty
                          ? WidgetImageAsset(
                              pathImage: 'images/profile.png',
                              width: 250,
                              height: 250)
                          : GFAvatar(
                              backgroundImage: NetworkImage(
                                  appController.currentUserModels.last.avatar!),
                              backgroundColor: GFColors.LIGHT,
                              radius: 125)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: WidgetIconButton(
                            icon: Icons.edit_square,
                            onPressed: () async {
                              String? urlAvatar = await AppService()
                                  .findUrlImageByUpload(path: 'profile');
                              if (urlAvatar != null) {
                                debugPrint(
                                    '##26april urlAvatar --> $urlAvatar');

                                Map<String, dynamic> map = appController
                                    .currentUserModels.last
                                    .toMap();
                                map['avatar'] = urlAvatar;
                                AppService().editProfile(mapProfile: map);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appController.currentUserModels.last.name,
                    style: AppConstant.h2Style()),
                WidgetIconButton(
                    icon: Icons.edit_square,
                    onPressed: () async {
                      appController.display.value = false;

                      TextEditingController textEditingController =
                          TextEditingController();
                      textEditingController.text =
                          appController.currentUserModels.last.name;

                      AppDialog().normalDialog(
                          title: WidgetText(
                              text: 'Edit Name',
                              textStyle: AppConstant.h2Style()),
                          content: WidgetForm(
                              controller: textEditingController,
                              onChanged: (p0) {
                                appController.display.value = true;
                              },
                              label: 'Name :'),
                          firstAction: Obx(() => appController.display.value ? WidgetButton(
                                text: 'Save',
                                type: GFButtonType.outline2x,
                                onPressed: () async{

                                  if (textEditingController.text.isNotEmpty) {
                                    
                                    Map<String,dynamic> map = appController.currentUserModels.last.toMap();
                                    map['name'] = textEditingController.text;

                                    await AppService().editProfile(mapProfile: map).whenComplete(() => Get.back());
                                  }
                                },
                              ) : SizedBox()));
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appController.currentUserModels.last.email,
                    style: AppConstant.h3Style()),
              ],
            ),
            SizedBox(height: 16),
            WidgetDeliveryAddress(),
            SizedBox(height: 16),
            WidgetPaymentMethod(),
            SizedBox(height: 16),
          ],
        ));
  }
}
