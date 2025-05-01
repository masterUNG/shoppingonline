// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {

  final String ref;
  final String uidOrder;
  final String status;
  final String paymentMethod;
  final String docIdAddressDelivery;
  final num deliveryCost;
  final List<Map<String, dynamic>> listCarts;
  final num cartsCost;
  final Timestamp timestampPlaceOrder;


  


  OrderModel({
    required this.ref,
    required this.uidOrder,
    required this.status,
    required this.paymentMethod,
    required this.docIdAddressDelivery,
    required this.deliveryCost,
    required this.listCarts,
    required this.cartsCost,
    required this.timestampPlaceOrder,
  });




  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ref': ref,
      'uidOrder': uidOrder,
      'status': status,
      'paymentMethod': paymentMethod,
      'docIdAddressDelivery': docIdAddressDelivery,
      'deliveryCost': deliveryCost,
      'listCarts': listCarts,
      'cartsCost': cartsCost,
      'timestampPlaceOrder': timestampPlaceOrder,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      ref: (map['ref'] ?? '') as String,
      uidOrder: (map['uidOrder'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      paymentMethod: (map['paymentMethod'] ?? '') as String,
      docIdAddressDelivery: (map['docIdAddressDelivery'] ?? '') as String,
      deliveryCost: (map['deliveryCost'] ?? 0) as num,
      listCarts: List<Map<String, dynamic>>.from(map['listCarts'] ),
      cartsCost: (map['cartsCost'] ?? 0) as num,
      timestampPlaceOrder: (map['timestampPlaceOrder']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
