import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingonline/models/address_delivery_model.dart';
import 'package:shoppingonline/utility/app_constant.dart';
import 'package:shoppingonline/utility/app_controller.dart';
import 'package:shoppingonline/utility/app_service.dart';
import 'package:shoppingonline/widgets/widget_back_button.dart';
import 'package:shoppingonline/widgets/widget_button.dart';
import 'package:shoppingonline/widgets/widget_form.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class AddAddressBottomSheet extends StatefulWidget {
  const AddAddressBottomSheet({super.key});

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final keyForm = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();

  Position? position;

  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                WidgetBackButton(),
              ],
            ),
            SizedBox(height: 16),
            Container(
                decoration: BoxDecoration(border: Border.all()),
                width: Get.width,
                height: Get.width * 0.6,
                child: FutureBuilder(
                  future: AppService().determinePosition(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return WidgetProgress();
                    } else {
                      position = snapshot.data!;

                      Marker marker = Marker(
                          markerId: MarkerId('id'),
                          position:
                              LatLng(position!.latitude, position!.longitude),
                          infoWindow: InfoWindow(title: 'ตำแหน่งของคุณ'));

                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target:
                                LatLng(position!.latitude, position!.longitude),
                            zoom: 16),
                        markers: {marker},
                      );
                    }
                  },
                )),
            SizedBox(height: 16),
            Form(
              key: keyForm,
              child: WidgetForm(
                label: 'Name Address Delivery :',
                controller: textEditingController,
                validator: (p0) {
                  if (p0?.isEmpty ?? true) {
                    return 'Please Fill Name Address';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            WidgetButton(
                text: 'Save',
                onPressed: () async {
                  if (keyForm.currentState!.validate()) {
                    if (position != null) {
                      AddressDeliveryModel addressDeliveryModel =
                          AddressDeliveryModel(
                              nameAddressDelivery: textEditingController.text,
                              geoPoint: GeoPoint(
                                  position!.latitude, position!.longitude),
                              timestamp: Timestamp.fromDate(DateTime.now()));

                      print('model ---> ${addressDeliveryModel.toMap()}');

                      DocumentReference documentReference = FirebaseFirestore
                          .instance
                          .collection('user${AppConstant.keyApp}')
                          .doc(appController.currentUserModels.last.uid)
                          .collection('addressDelivery')
                          .doc();

                      await documentReference
                          .set(addressDeliveryModel.toMap())
                          .whenComplete(
                        () async {
                          Map<String, dynamic> map =
                              addressDeliveryModel.toMap();
                          map['docId'] = documentReference.id;

                          await FirebaseFirestore.instance
                              .collection('user${AppConstant.keyApp}')
                              .doc(appController.currentUserModels.last.uid)
                              .collection('addressDelivery')
                              .doc(documentReference.id)
                              .update(map).whenComplete(() => Get.back());
                        },
                      );
                    }
                  }
                },
                fullWidthButton: true),
          ],
        ),
      ),
    );
  }
}
