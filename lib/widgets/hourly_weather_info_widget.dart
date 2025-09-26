import 'package:flutter/material.dart';
import 'package:outfit_fe/widgets/shadow_effected_text.dart';

class HourlyWeatherInfoWidget extends StatelessWidget {
  final Color bgColor;
  final int precip, temp, wind, hour;
  final String status;

  const HourlyWeatherInfoWidget({
    super.key,
    required this.bgColor,
    required this.precip,
    required this.temp,
    required this.wind,
    required this.hour,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 1)),
        ],
      ),
      width: 80,
      height: 160,
      child: Center(
        child: Column(
          children: [
            ShadowEffectedText(
              text: '$hour시',
              size: 16,
              fontweight: FontWeight.w300,
            ),
            ShadowEffectedText(text: '$temp℃', size: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Container(
                decoration: BoxDecoration(border: Border(top: BorderSide())),
              ),
            ),
            Icon(Icons.sunny, size: 50),
            Text('$precip%'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.north_west_outlined, size: 20),
                Text('$wind m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
