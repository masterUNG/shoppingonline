// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImageAsset extends StatelessWidget {
  const WidgetImageAsset({
    Key? key,
    required this.pathImage,
    this.width,
    this.height,
  }) : super(key: key);

  final String pathImage;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(pathImage, width: width, height: height,);
  }
}
