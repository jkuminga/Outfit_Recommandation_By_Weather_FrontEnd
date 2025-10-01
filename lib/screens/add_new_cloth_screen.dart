import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:outfit_fe/models/category.dart';
import 'package:outfit_fe/models/widget_styles.dart';
import 'package:outfit_fe/widgets/done_button.dart';

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
  late String selectedClothCategory; // 선택된 옷 분류

  late List<List<String>> currentCategoryList; // 선택된 옷 분류 세부 카테고리 목록
  late List<String>
  selectedDetailCategory; // 현재 선택된 옷의 세부카테고리 (default 는 첫번째 값))

  final TextEditingController nameController =
      TextEditingController(); // 이름 컨트롤러

  final List<String> thickness = ['얇음', '보통', '두꺼움']; // 두꼐감 항목
  late String selectedThickness; // 선택한 두께감

  final List<Color> commonClothesColors = [
    Color(0xFF000000), // 블랙
    Color(0xFFFFFFFF), // 화이트
    Color(0xFF808080), // 그레이
    Color(0xFF000080), // 네이비
    Color(0xFF2F4F4F), // 다크 차콜 (슬랙스, 코트류에서 자주 쓰임)
    Color(0xFF8B4513), // 브라운 (가죽, 니트류에서 많이 입음)
    Color(0xFF556B2F), // 올리브/카키 (아우터, 캐주얼 자주 등장)
  ];
  Color pickerColor = Color(0xff443a49);
  Color? currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void showColorChangeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [],
          content: Column(
            children: [
              ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  changeColor(color);
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() => currentColor = pickerColor);
                  Navigator.of(context).pop();
                },
                child: Text('done'),
              ),
            ],
          ),
        );
      },
    );
  }

  //두꼐감 변경 함수
  void changeThickness(String thickness) {
    setState(() {
      selectedThickness = thickness;
    });
  }

  // 카테고리 선택 함수
  void selectClothCategory(String category) {
    setState(() {
      selectedClothCategory = category;
      isCategorySelected = true;

      // 선택된 분류에 따라서 그 세부 카테고리 목록을 currentCategoryList에 할당해준다.
      if (selectedClothCategory == "Top") {
        currentCategoryList = Category.topCategories;
      } else if (selectedClothCategory == 'Bottom') {
        currentCategoryList = Category.bottomCategories;
      } else {
        currentCategoryList = Category.outerCategories;
      }
      // print(currentCategoryList);
      // 선택될 세부 카테고리 값의 초기값을 첫번째 값으로 선택한다.
      selectedDetailCategory = currentCategoryList[0];
      // print(selectedDetailCategory);
    });
  }

  @override
  void initState() {
    selectedThickness = thickness[1];
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
              // 옷 대분류 카테고리 선택화면
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(Icons.chevron_left),
                          iconSize: 40,
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
                            image: Image.asset(
                              'assets/images/top_icons/t-shirt.png',
                            ),
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
                            image: Image.asset(
                              'assets/images/bottom_icons/long.png',
                            ),
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
              // 옷 대분류 선택이 끝난 후 세부 카테고리를 정해서 옷을 등록하는 화면
              : Center(
                  child: Column(
                    children: [
                      // appBar
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
                              icon: Icon(Icons.chevron_left, size: 35),
                            ),
                            Text(
                              '옷 추가 :  $selectedClothCategory',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            DoneButton(doneFunction: () {}),
                          ],
                        ),
                      ),
                      // 세부 카테고리 목록 + 선택 버튼 리스트뷰
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: currentCategoryList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 4,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDetailCategory =
                                          currentCategoryList[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          (selectedDetailCategory[0] ==
                                              currentCategoryList[index][0])
                                          ? Colors.blue
                                          : Colors.white,
                                      boxShadow: WidgetStyles.boxShadow,
                                      borderRadius: BorderRadius.circular(360),
                                    ),
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        currentCategoryList[index][0],
                                        style: TextStyle(
                                          color:
                                              (selectedDetailCategory[0] ==
                                                  currentCategoryList[index][0])
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // 선택한 세부 카테고리에 등록된 아이콘 이미지 출력
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset(
                          selectedDetailCategory[1],
                          height: 200,
                        ),
                      ),
                      // 원하는 경우 이미지 추가
                      // TODO : 이미지 추가 시 아이콘 이미지가 보여지는 영역에 선택한 이미지가 보이도록 해야함
                      TextButton(onPressed: () {}, child: Text('이미지 추가')),
                      // 이름 입력 텍스트 필드
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 50,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "옷 이름",
                              hintStyle: TextStyle(color: Colors.blue.shade400),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 옷 색상 선택
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '색상 선택',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: currentColor,
                                border: Border.all(),
                              ),
                              width: 70,
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...commonClothesColors.map(
                              (e) => ColorButton(
                                color: e,
                                onChange: () {
                                  setState(() => currentColor = e);
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: showColorChangeDialog,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                width: 30,
                                height: 30,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 두께감 선택 영역
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '두께감 선택',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ThicknessButton(
                              thickness: thickness[0],
                              onTapAction: () => changeThickness(thickness[0]),
                              isSelected: (selectedThickness == thickness[0]),
                            ),
                            ThicknessButton(
                              thickness: thickness[1],
                              onTapAction: () => changeThickness(thickness[1]),
                              isSelected: (selectedThickness == thickness[1]),
                            ),
                            ThicknessButton(
                              thickness: thickness[2],
                              onTapAction: () => changeThickness(thickness[2]),
                              isSelected: (selectedThickness == thickness[2]),
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

class ColorButton extends StatelessWidget {
  final Color color;
  final VoidCallback onChange;
  const ColorButton({super.key, required this.color, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
          borderRadius: BorderRadius.circular(90),
        ),
        width: 30,
        height: 30,
      ),
    );
  }
}

class ThicknessButton extends StatelessWidget {
  final VoidCallback onTapAction;
  final String thickness;
  final bool isSelected;

  const ThicknessButton({
    super.key,
    required this.thickness,
    required this.onTapAction,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        width: 90,
        height: 90,
        child: Center(
          child: Text(
            thickness,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.blue.shade500,
              fontSize: 18,
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
                fontSize: 18,
                fontWeight: FontWeight.w500,
                // color: Colors.white,
                color: const Color.fromARGB(255, 0, 75, 137),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
