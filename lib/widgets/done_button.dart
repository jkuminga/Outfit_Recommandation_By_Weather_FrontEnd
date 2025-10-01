import 'package:flutter/material.dart';
import 'package:outfit_fe/models/widget_styles.dart';

class DoneButton extends StatelessWidget {
  final VoidCallback doneFunction;
  const DoneButton({super.key, required this.doneFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: WidgetStyles.boxShadow,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(45),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.done, color: Colors.white),
      ),
    );
  }
}
