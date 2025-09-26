import 'package:flutter/material.dart';
import 'package:outfit_fe/models/closet_item.dart';
import 'package:outfit_fe/screens/add_history_screen.dart';
import 'package:outfit_fe/widgets/closet_items_carousel_viewer.dart';
import 'package:outfit_fe/widgets/shadow_effected_text.dart';

class ClosetItemWidget extends StatelessWidget {
  final Color bgColor;
  const ClosetItemWidget({super.key, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShadowEffectedText(text: '내 옷장', size: 16),
                    SingleItemViewer(
                      item: ClosetItem.fromJson({
                        "name": "상의",
                        "category": '맨투맨',
                        "thickness": "두꺼움",
                        "image": "이미지",
                      }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.white)),
                      ),
                    ),
                    SingleItemViewer(
                      item: ClosetItem.fromJson({
                        "name": "상의",
                        "category": '맨투맨',
                        "thickness": "두꺼움",
                        "image": "이미지",
                      }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.white)),
                      ),
                    ),
                    SingleItemViewer(
                      item: ClosetItem.fromJson({
                        "name": "상의",
                        "category": '맨투맨',
                        "thickness": "두꺼움",
                        "image": "이미지",
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddHistoryScreen()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Center(
                  child: ShadowEffectedText(text: '오늘 입을 옷 선택/기록하기', size: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
