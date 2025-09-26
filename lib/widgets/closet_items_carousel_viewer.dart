import 'package:flutter/material.dart';
import 'package:outfit_fe/models/closet_item.dart';
import 'package:outfit_fe/widgets/shadow_effected_text.dart';

class ClosetItemsCarouselViewer extends StatelessWidget {
  final List<ClosetItem> items;
  const ClosetItemsCarouselViewer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SingleItemViewer extends StatelessWidget {
  final ClosetItem item;
  const SingleItemViewer({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              width: 100,
              height: 100,
              // child: Image.network(item.image),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadowEffectedText(
                  // text: item.name,
                  text: '아이템 이름',
                  size: 22,
                  fontweight: FontWeight.w800,
                ),
                ShadowEffectedText(text: '상의 세부 카테고리', size: 15),
                ShadowEffectedText(text: '두께감', size: 15),
                // ShadowEffectedText(text: item.category, size: 15),
                // ShadowEffectedText(text: item.thickness, size: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
