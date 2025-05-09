// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shoppingonline/utility/app_constant.dart';

class WidgetTextRich extends StatelessWidget {
  const WidgetTextRich({
    super.key,
    required this.head,
    required this.body,
    this.size,
  });

  final String head;
  final String body;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      text: head,
      style: AppConstant.h3Style(color: AppConstant.primaryColor, fontWeight: FontWeight.bold, fontSize: size),
      children: [
        TextSpan(
            text: body,
            style: AppConstant.h3Style(color: Colors.black, fontWeight: FontWeight.normal, fontSize: size)),
      ],
    ));
  }
}