import 'package:flutter/material.dart';

class WidgetProgress extends StatelessWidget {
  const WidgetProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
