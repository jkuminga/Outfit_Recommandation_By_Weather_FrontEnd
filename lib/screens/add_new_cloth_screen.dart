import 'package:flutter/material.dart';
import 'package:outfit_fe/models/widget_styles.dart';

class AddNewClothScreen extends StatefulWidget {
  const AddNewClothScreen({super.key});

  @override
  State<AddNewClothScreen> createState() => _AddNewClothScreenState();
}

class _AddNewClothScreenState extends State<AddNewClothScreen> {
  final double fixedWidth = 450; // 값 수정
  final double fixedHeight = 844; // 값 수정

  bool isCategorySelected = false;
  final List<String> clothesCategories = ['Top', 'Bottom', 'Outer'];
  late String selectedClothCategory;

  // 카테고리 선택 함수
  void selectClothCategory(String category) {
    setState(() {
      selectedClothCategory = category;
      isCategorySelected = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
          ),
          width: boxWidth,
          height: boxHeight,
          child: (!isCategorySelected)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.chevron_left),
                          iconSize: 40,
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: WidgetStyles.boxShadow,
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 190,
                            height: 190,
                            child: Center(
                              child: Text(
                                '등록할 옷의\n분류를 선택하세요',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          CategoryButton(
                            onTap: () {
                              selectClothCategory(clothesCategories[0]);
                            },
                            text: '상의',
                            image: Image.asset('assets/images/rainy.png'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CategoryButton(
                            onTap: () {
                              selectClothCategory(clothesCategories[1]);
                            },
                            text: '하의',
                            image: Image.asset('assets/images/rainy.png'),
                          ),
                          SizedBox(width: 10),
                          CategoryButton(
                            onTap: () {
                              selectClothCategory(clothesCategories[2]);
                            },
                            text: '외투',
                            image: Image.asset('assets/images/rainy.png'),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isCategorySelected = false;
                                });
                              },
                              icon: Icon(
                                Icons.chevron_left,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              '옷 추가 :  $selectedClothCategory',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.done,
                                color: Colors.blue,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Image image;
  const CategoryButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: WidgetStyles.boxShadow,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 190,
        height: 190,
        child: Column(
          children: [
            Flexible(
              child: Padding(padding: const EdgeInsets.all(12.0), child: image),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
