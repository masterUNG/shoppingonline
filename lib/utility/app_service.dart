import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shoppingonline/models/address_delivery_model.dart';
import 'package:shoppingonline/models/cart_model.dart';
import 'package:shoppingonline/models/category_model.dart';
import 'package:shoppingonline/models/order_model.dart';
import 'package:shoppingonline/models/product_model.dart';
import 'package:shoppingonline/models/user_model.dart';
import 'package:shoppingonline/state_web/main_home_web.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';

class AppService {
  AppController appController = Get.put(AppController());

  String timeStameToString({required Timestamp timestamp}) {
    DateFormat dateFormat = DateFormat('dd/MMM/yy HH:mm');
    String string = dateFormat.format(timestamp.toDate());

    return string;
  }

  int findSelectedStep({required String orderStatus}) {
    int selectedStep = 0;

    if (orderStatus == AppConstant.statusOrders[1]) {
      selectedStep = 1;
    }
    if (orderStatus == AppConstant.statusOrders[2]) {
      selectedStep = 2;
    }
    if (orderStatus == AppConstant.statusOrders[3]) {
      selectedStep = 3;
    }

    return selectedStep;
  }

  Future<void> editOrder({required Map<String, dynamic> mapOrder}) async {
    await FirebaseFirestore.instance
        .collection('order${AppConstant.keyApp}')
        .doc(mapOrder['docId'])
        .update(mapOrder);
  }

  Future<List<OrderModel>> readMyOrder() async {
    var orderModels = <OrderModel>[];

    var querySnapshots = await FirebaseFirestore.instance
        .collection('order${AppConstant.keyApp}')
        .orderBy('timestampPlaceOrder', descending: true)
        .get();

    for (var element in querySnapshots.docs) {
      OrderModel orderModel = OrderModel.fromMap(element.data());

      if (orderModel.uidOrder == appController.currentUserModels.last.uid) {
        if (orderModel.status != AppConstant.statusOrders[3]) {
          orderModels.add(orderModel);
        }
      }
    }
    return orderModels;
  }

  Future<void> readAllOrder() async {
    if (appController.orderModels.isNotEmpty) {
      appController.orderModels.clear();
    }

    var querySnapshots = await FirebaseFirestore.instance
        .collection('order${AppConstant.keyApp}')
        .orderBy('timestampPlaceOrder', descending: true)
        .get();

    for (var element in querySnapshots.docs) {
      OrderModel orderModel = OrderModel.fromMap(element.data());

      appController.orderModels.add(orderModel);

      appController.displays.add(false);
    }
  }

  Future<AddressDeliveryModel?> findAddressDeliveryModelByDocId(
      {required String docId}) async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('user${AppConstant.keyApp}')
        .doc(appController.currentUserModels.last.uid)
        .collection('addressDelivery')
        .doc(docId)
        .get();
    if (documentSnapshot.data() != null) {
      return AddressDeliveryModel.fromMap(documentSnapshot.data()!);
    }
    return null;
  }

  Future<void> readAllAddressDeliveryModel() async {
    if (appController.addressDeliveryModels.isNotEmpty) {
      appController.addressDeliveryModels.clear();
    }

    var querySnapShots = await FirebaseFirestore.instance
        .collection('user${AppConstant.keyApp}')
        .doc(appController.currentUserModels.last.uid)
        .collection('addressDelivery')
        .get();

    if (querySnapShots.docs.isNotEmpty) {
      for (var element in querySnapShots.docs) {
        appController.addressDeliveryModels
            .add(AddressDeliveryModel.fromMap(element.data()));
      }
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // เช็คว่าเปิดบริการ location หรือยัง
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ถ้าไม่ได้เปิด ต้องแจ้งผู้ใช้ก่อน
      throw Exception('Location services are disabled.');
    }

    // ขอ permission ถ้ายังไม่ได้ให้
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ปฏิเสธ permission
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ถูกปฏิเสธแบบถาวร
      throw Exception('Location permissions are permanently denied.');
    }

    // ได้ permission แล้ว
    return await Geolocator.getCurrentPosition();
  }

  Future<void> editProfile({required Map<String, dynamic> mapProfile}) async {
    await FirebaseFirestore.instance
        .collection('user${AppConstant.keyApp}')
        .doc(appController.currentUserModels.last.uid)
        .update(mapProfile)
        .whenComplete(
          () => findCurrentUserModels(),
        );
  }

  Future<void> calculateSubtotal() async {
    appController.cartCosts.add(0.0);

    for (var i = 0; i < appController.cartModels.length; i++) {
      // ProductModel? productModel = await findProductById(
      //     docIdProduct: appController.cartModels[i].docIdProduct);

      appController.cartCosts.add(appController.cartCosts.last +
          num.parse((num.parse(appController.productModels[i].price) *
                  appController.amounts[i])
              .toString()));
    }
  }

  Future<ProductModel?> findProductById({required String docIdProduct}) async {
    ProductModel? productModel;

    var result = await FirebaseFirestore.instance
        .collection('product${AppConstant.keyApp}')
        .doc(docIdProduct)
        .get();
    if (result.data() != null) {
      productModel = ProductModel.fromMap(result.data()!);
    }

    return productModel;
  }

  Future<void> readAllCart() async {
    try {
      if (appController.cartModels.isNotEmpty) {
        appController.cartModels.clear();
      }

      if (appController.amounts.isNotEmpty) {
        appController.amounts.clear();
      }

      if (appController.productModels.isNotEmpty) {
        appController.productModels.clear();
      }

      var result = await FirebaseFirestore.instance
          .collection('user${AppConstant.keyApp}')
          .doc(appController.currentUserModels.last.uid)
          .collection('cart')
          .orderBy('timestamp')
          .get();

      if (result.docs.isNotEmpty) {
        for (var element in result.docs) {
          Map<String, dynamic> map = element.data();
          map['docId'] = element.id;

          appController.cartModels.add(CartModel.fromMap(map));

          appController.amounts.add(map['amount']);

          ProductModel? productModel =
              await findProductById(docIdProduct: map['docIdProduct']);

          appController.productModels.add(productModel!);
        }
      }
    } finally {
      appController.display.value = true;
    }
  }

  Future<void> findCurrentUserModels() async {
    var user = FirebaseAuth.instance.currentUser;

    var result = await FirebaseFirestore.instance
        .collection('user${AppConstant.keyApp}')
        .doc(user!.uid)
        .get();

    appController.currentUserModels.add(UserModel.fromMap(result.data()!));
  }

  Future<List<ProductModel>> readAllProduct() async {
    var productModels = <ProductModel>[];

    var result = await FirebaseFirestore.instance
        .collection('product${AppConstant.keyApp}')
        .orderBy('timestamp', descending: true)
        .get();
    for (var element in result.docs) {
      ProductModel productModel = ProductModel.fromMap(element.data());
      Map<String, dynamic> map = productModel.toMap();
      map['docId'] = element.id;

      productModels.add(ProductModel.fromMap(map));
    }

    return productModels;
  }

  Future<List<ProductModel>> readAllProductByCategory(
      {required String docIdCategory}) async {
    var productModels = <ProductModel>[];

    var result = await FirebaseFirestore.instance
        .collection('product${AppConstant.keyApp}')
        // .where('docIdCatigory', isEqualTo: docIdCategory)
        .orderBy('timestamp', descending: true)
        .get();

    for (var element in result.docs) {
      ProductModel productModel = ProductModel.fromMap(element.data());


      if (productModel.docIdCatigory == docIdCategory) {
  Map<String, dynamic> map = productModel.toMap();
  map['docId'] = element.id;
  
  productModels.add(ProductModel.fromMap(map));
}
    }

    return productModels;
  }

  Future<List<CategoryModel>> readAllCategory() async {
    var categoryModels = <CategoryModel>[];

    var result = await FirebaseFirestore.instance.collection('category').orderBy('nameCategory')
    .get();
    for (var element in result.docs) {
      CategoryModel categoryModel = CategoryModel.fromMap(element.data());
      Map<String, dynamic> map = categoryModel.toMap();

      map['docId'] = element.id;
      categoryModels.add(CategoryModel.fromMap(map));
    }

    return categoryModels;
  }

  Future<String?> findUrlImageByUpload({required String path}) async {
    String? urlImage;

    var result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      var imageByte = await result.readAsBytes();

      FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
          bucket: 'gs://shoppingonline-57e3c.firebasestorage.app');
      Reference reference = firebaseStorage
          .ref()
          .child('$path/${DateTime.now().toIso8601String()}.jpg');
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
