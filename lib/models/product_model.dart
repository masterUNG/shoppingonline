// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {

  final String name;
  final String detail;
  final String docIdCatigory;
  final String price;
  final String urlImage;
  final Timestamp timestamp;
  final String? docId;
  final String nameCatigory;



  
  ProductModel({
    required this.name,
    required this.detail,
    required this.docIdCatigory,
    required this.price,
    required this.urlImage,
    required this.timestamp,
    this.docId,
    required this.nameCatigory,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'detail': detail,
      'docIdCatigory': docIdCatigory,
      'price': price,
      'urlImage': urlImage,
      'timestamp': timestamp,
      'docId': docId,
      'nameCatigory': nameCatigory,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: (map['name'] ?? '') as String,
      detail: (map['detail'] ?? '') as String,
      docIdCatigory: (map['docIdCatigory'] ?? '') as String,
      price: (map['price'] ?? '') as String,
      urlImage: (map['urlImage'] ?? '') as String,
      timestamp: (map['timestamp']),
      docId: (map['docId'] ?? '') as String,
      nameCatigory: (map['nameCatigory'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
