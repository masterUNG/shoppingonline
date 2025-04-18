// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  
  final Timestamp timestamp;
  final String docIdProduct;
  final num amount;
  final String? docId;




  CartModel({
    required this.timestamp,
    required this.docIdProduct,
    required this.amount,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'docIdProduct': docIdProduct,
      'amount': amount,
      'docId': docId,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      timestamp: (map['timestamp'] ),
      docIdProduct: (map['docIdProduct'] ?? '') as String,
      amount: (map['amount'] ?? 0) as num,
      docId: (map['docId'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
