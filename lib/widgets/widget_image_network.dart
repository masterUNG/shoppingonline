import 'package:flutter/material.dart';
import 'package:shoppingonline/widgets/widget_progress.dart';

class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    super.key,
    required this.urlImage,
    this.width,
    this.height,
  });

  final String urlImage;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      urlImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return WidgetProgress();
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
    );
  }
}
