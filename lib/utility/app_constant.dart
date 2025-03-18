import 'package:flutter/material.dart';

class AppConstant {
  static String keyApp = '-ung';

  static Color mainColor = Color(0xff4a822b);
  static Color primaryColor = Color(0xff316729);
  static Color light1Color = Color(0xffebed9a);
  static Color light2Color = Color(0xffbed85d);
  static Color light3Color = Color(0xff82b055);

  static TextStyle h1Style() => TextStyle(
      fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'Kodchasan');
  static TextStyle h2Style({double? fontSize}) => TextStyle(
      fontSize: fontSize ?? 24, fontWeight: FontWeight.bold, fontFamily: 'Kodchasan');
  static TextStyle h3Style({FontWeight? fontWeight, Color? color}) => TextStyle(
      color: color,
      fontSize: 15,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: 'Kodchasan');

  static String slogan1 = 'ช้อปสะดวก ขายสบาย';
  static String slogan2 = 'มั่นใจทุกดีล';
  static String subSlogan =
      'แอปซื้อขายออนไลน์ที่ใช้งานง่าย รวดเร็ว และปลอดภัยที่สุด ให้คุณเลือกซื้อสินค้าหลากหลาย หรือเปิดร้านขายของได้ในไม่กี่คลิก พร้อมระบบชำระเงินที่เชื่อถือได้และการรับประกันความพึงพอใจ';

  static String signInDescrip =
      'สมัครสมาชิกวันนี้! ช้อปง่าย ขายสะดวก รับดีลสุดพิเศษก่อนใคร มั่นใจทุกการซื้อขาย ปลอดภัย 100% โหลดเลย!';

  static String termCondition = """ <!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เงื่อนไขและข้อตกลงสำหรับผู้ซื้อ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
        }
        h1, h2 {
            color: #333;
        }
        ul {
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <h1>เงื่อนไขและข้อตกลงสำหรับผู้ซื้อ</h1>
    
    <h2>1. การสมัครสมาชิก</h2>
    <ul>
        <li>ผู้ใช้ต้องให้ข้อมูลที่ถูกต้องและเป็นปัจจุบันในการสมัครสมาชิก</li>
        <li>ผู้ใช้ต้องมีอายุไม่ต่ำกว่า 18 ปี หรือได้รับความยินยอมจากผู้ปกครอง</li>
        <li>การสมัครสมาชิกถือว่าผู้ใช้ยอมรับข้อตกลงและเงื่อนไขของแพลตฟอร์ม</li>
    </ul>

    <h2>2. การใช้งานบัญชีผู้ใช้</h2>
    <ul>
        <li>ผู้ใช้ต้องรักษาข้อมูลบัญชีและรหัสผ่านเป็นความลับ</li>
        <li>ห้ามให้บุคคลอื่นใช้บัญชีแทน</li>
        <li>หากพบพฤติกรรมที่น่าสงสัย กรุณาแจ้งทีมงานทันที</li>
    </ul>
    
    <h2>3. การสั่งซื้อสินค้า</h2>
    <ul>
        <li>ผู้ใช้สามารถเลือกซื้อสินค้าและชำระเงินผ่านช่องทางที่กำหนด</li>
        <li>เมื่อกดยืนยันคำสั่งซื้อ ถือว่าผู้ใช้ยอมรับเงื่อนไขของผู้ขาย</li>
        <li>หากมีปัญหาเกี่ยวกับสินค้า ให้ติดต่อผู้ขายหรือฝ่ายสนับสนุนภายในเวลาที่กำหนด</li>
    </ul>
    
    <h2>4. การชำระเงินและนโยบายคืนเงิน</h2>
    <ul>
        <li>ผู้ใช้ต้องทำการชำระเงินให้ถูกต้องตามเงื่อนไขที่กำหนด</li>
        <li>การคืนเงินเป็นไปตามนโยบายของแพลตฟอร์มและเงื่อนไขของผู้ขาย</li>
    </ul>
    
    <h2>5. ความปลอดภัยและพฤติกรรมการใช้งาน</h2>
    <ul>
        <li>ห้ามโพสต์เนื้อหาหรือกระทำการใด ๆ ที่เป็นการละเมิดกฎหมาย</li>
        <li>แพลตฟอร์มมีสิทธิ์ระงับหรือปิดบัญชีผู้ใช้ที่ทำผิดกฎ</li>
    </ul>
    
    <h2>6. การเปลี่ยนแปลงเงื่อนไข</h2>
    <ul>
        <li>แพลตฟอร์มสามารถปรับเปลี่ยนเงื่อนไขได้ตามความเหมาะสม</li>
        <li>หากมีการเปลี่ยนแปลงสำคัญ ระบบจะแจ้งให้ผู้ใช้ทราบล่วงหน้า</li>
    </ul>
    
    <h2>7. การติดต่อฝ่ายสนับสนุน</h2>
    <p>หากมีข้อสงสัยหรือปัญหาเกี่ยวกับการใช้งาน กรุณาติดต่อทีมงานผ่าน <a href="#">[ช่องทางติดต่อ]</a></p>
    
</body>
</html>
 """;
}
