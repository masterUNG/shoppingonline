// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddressDeliveryModel {
  final String nameAddressDelivery;
  final String? docId;
  final GeoPoint geoPoint;
  final Timestamp timestamp;
  AddressDeliveryModel({
    required this.nameAddressDelivery,
    this.docId,
    required this.geoPoint,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameAddressDelivery': nameAddressDelivery,
      'docId': docId,
      'geoPoint': geoPoint,
      'timestamp': timestamp,
    };
  }

  factory AddressDeliveryModel.fromMap(Map<String, dynamic> map) {
    return AddressDeliveryModel(
      nameAddressDelivery: (map['nameAddressDelivery'] ?? '') as String,
      docId: (map['docId'] ?? '') as String,
      geoPoint: (map['geoPoint']),
      timestamp: (map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressDeliveryModel.fromJson(String source) => AddressDeliveryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
