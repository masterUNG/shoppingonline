// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shoppingonline/utility/app_constant.dart';

import 'package:shoppingonline/widgets/widget_image_asset.dart';
import 'package:shoppingonline/widgets/widget_text.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var pathImages = <String>[
    'images/intro1.png',
    'images/intro2.png',
    'images/intro3.png',
  ];

  var titles = <String>[
    'ช้อปง่าย ขายคล่อง',
    'ดีลเด็ด ราคาดี',
    'ปลอดภัย มั่นใจทุกการซื้อขาย',
  ];

  var subTitles = <String>[
    'ซื้อหรือขายก็สะดวก ใช้งานง่ายไม่ยุ่งยาก ค้นหาสินค้าไว ลงขายได้ภายในไม่กี่ขั้นตอน',
    'รวมสินค้าหลากหลายหมวดหมู่ พร้อมข้อเสนอพิเศษและส่วนลดสุดคุ้ม อัปเดตดีลใหม่ทุกวัน',
    'ระบบป้องกันการโกง รองรับการชำระเงินที่ปลอดภัย พร้อมทีมซัพพอร์ตช่วยเหลือทุกปัญหา',
  ];

  List<PageViewModel> pages = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < pathImages.length; i++) {
      pages.add(PageViewModel(
          image: WidgetImageAsset(pathImage: pathImages[i]),
          titleWidget:
              WidgetText(text: titles[i], textStyle: AppConstant.h2Style()),
          bodyWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: WidgetText(text: subTitles[i]),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: IntroductionScreen(
        pages: pages,
        onDone: () {},
        done: WidgetText(text: 'ลงชื่อใช้งาน'),
        showNextButton: true,
        next: WidgetText(text: 'ต่อไป'),
        showSkipButton: true,
        skip: WidgetText(text: 'ข้าม'),
        bodyPadding: EdgeInsets.only(top: Get.height * 0.1),
      ),
    ));
  }
}
