import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:outfit_fe/models/widget_styles.dart';
import 'package:outfit_fe/widgets/closet_item_widget.dart';
import 'package:outfit_fe/widgets/hourly_weather_info_widget.dart';
import 'package:outfit_fe/widgets/outfit_combination.dart';
import 'package:outfit_fe/widgets/shadow_effected_text.dart';
import 'package:outfit_fe/widgets/toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double fixedWidth = 450; // 값 수정
  final double fixedHeight = 844; // 값 수정

  final String clear = 'clear',
      rainy = 'rainy',
      snowy = 'snowy',
      cloudy = 'cloudy';

  final Map<String, Color> bgColors = {
    'clear': Color(0xffB5DEFF),
    '흐림': Color(0xffE8E8E8),
    '비': Color(0xffB8B8B8),
  };

  final Map<String, Color> widgetColors = {
    'clear': Color.fromARGB(255, 155, 208, 251),
    '흐림': Color(0xffE8E8E8),
    '비': Color(0xffB8B8B8),
  };

  @override
  void initState() {
    // TODO : 날씨 데이터를 불러오는 API 연결 후 then()으로 그 데이터를 홈화면 전역에서 처리
    // 이 중 sky_status을 불러와서 화면 + 위젯의 배경색상을 선택하게 될 것
    // 혹은 색상이 아니라 애니메이션을 사용할 수도 있을 것 같다

    // 아니면 그냥 Scaffold 전체를 FutureBuilder로 감싸도 됨
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double boxWidth = screenWidth > fixedWidth ? fixedWidth : screenWidth;
    final double boxHeight = screenHeight > fixedHeight
        ? fixedHeight
        : screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: bgColors['clear'],
            boxShadow: WidgetStyles.boxShadow,
          ),
          width: boxWidth,
          height: boxHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 40),
                      ToggleButton(
                        width: 120,
                        height: 30,
                        // toggleBackgroundColor: widgetColorss['clear']!,
                        toggleBackgroundColor: Colors.white,
                        toggleColor: widgetColors['clear']!,
                        // toggleColor: Colors.white,
                        activeTextColor: Colors.white,
                        inactiveTextColor: Colors.black,
                        leftDescription: '오늘',
                        rightDescription: '내일',
                        onLeftToggleActive: () {},
                        onRightToggleActive: () {},
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 22,
                            color: Colors.white,
                            shadows: WidgetStyles.textShadow,
                          ),
                          ShadowEffectedText(text: '울산광역시', size: 19),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Opacity(
                                  opacity: 1,
                                  child: Image.asset(
                                    'assets/images/sunny.png',
                                    width: 120,
                                  ),
                                ),
                                ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10.0,
                                      sigmaY: 10.0,
                                    ),
                                    child: Image.asset(
                                      'assets/images/sunny.png',
                                      width: 120,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '30℃',
                                        style: TextStyle(
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: WidgetStyles.textShadow,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          bottom: 9,
                                        ),
                                        child: Text(
                                          '19℃ / 34℃',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            shadows: WidgetStyles.textShadow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '맑음',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      shadows: WidgetStyles.textShadow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HourlyWeatherInfoWidget(
                                  precip: 30,
                                  wind: 5,
                                  bgColor: widgetColors['clear']!,
                                  temp: 32,
                                  hour: 03,
                                  status: clear,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      OutfitCombination(bgColor: widgetColors['clear']!),
                      ClosetItemWidget(bgColor: widgetColors['clear']!),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
