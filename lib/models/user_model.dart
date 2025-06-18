import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String? avatar;
  final String? docIdAddressDelivery;
  final num? pinCode;





  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    this.avatar,
    this.docIdAddressDelivery,
    this.pinCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'docIdAddressDelivery': docIdAddressDelivery,
      'pinCode': pinCode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: (map['uid'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      docIdAddressDelivery: map['docIdAddressDelivery'] != null ? map['docIdAddressDelivery'] as String : null,
      pinCode: (map['pinCode'] ?? 1234) as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
