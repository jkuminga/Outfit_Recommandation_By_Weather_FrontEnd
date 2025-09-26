import 'package:flutter/material.dart';
import 'package:outfit_fe/widgets/shadow_effected_text.dart';

class OutfitCombination extends StatelessWidget {
  final Color bgColor;
  const OutfitCombination({super.key, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 추천 카테고리
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShadowEffectedText(text: '오늘의 옷차림 추천', size: 16),
              Center(
                child: SizedBox(height: 150, child: Text('Will be added')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
