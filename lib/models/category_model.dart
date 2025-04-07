import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  
  final String nameCategory;
  final String? docId;




  CategoryModel({
    required this.nameCategory,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameCategory': nameCategory,
      'docId': docId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      nameCategory: (map['nameCategory'] ?? '') as String,
      docId: (map['docId'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
