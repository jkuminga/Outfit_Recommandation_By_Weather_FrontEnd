import 'package:flutter/material.dart';
import 'package:outfit_fe/models/closet_item.dart';
import 'package:outfit_fe/screens/add_new_cloth_screen.dart';
import 'package:outfit_fe/widgets/done_button.dart';

class AddHistoryScreen extends StatefulWidget {
  const AddHistoryScreen({super.key});

  @override
  State<AddHistoryScreen> createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistoryScreen> {
  final double fixedWidth = 450; // 값 수정
  final double fixedHeight = 844; // 값 수정

  late String _currentState; // 현재 화면에서 출력 중인 옷 분류 ex) 상의, 하의,...
  late String
  _selectedCategory; // 현재 화면에서 출력 중인 특정 옷 분류의 세부 카테고리 ex) 맨투맨, 후드티 등...

  final List<String> states = ['TOP', 'BOTTOM', 'OUTER', 'ETC']; // 상태 문자열 목록
  final List<String> categories = ['맨투맨', '반팔']; // 세부 카테고리 목록
  final TextEditingController controller =
      TextEditingController(); // 검색 위젯 컨트롤러

  List<ClosetItem?> selectedItem = List.generate(
    4,
    (index) => null,
  ); // 오늘 입을 옷을 각 분류마다 하나씩 입력 ex) [흰색 맨투맨, 반바지, 외투없음, 내복없음]

  // 화면에 출력할 옷 분류를 변경하는 함수
  void changeState(String state) {
    setState(() {
      _currentState = state;
    });
  }

  // 화면에 출력할 카테고리 설정 함수

  @override
  void initState() {
    setState(() {
      changeState(states[0]);
      _selectedCategory = categories[0];
    });

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
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.7), blurRadius: 10),
            ],
          ),
          width: boxWidth,
          height: boxHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.chevron_left),
                        iconSize: 35,
                      ),
                      Text(
                        '새로운 기록 추가',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      DoneButton(doneFunction: () {}),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.done, color: Colors.blue.shade700),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemSeletectWidget(
                        title: states[0],
                        item: selectedItem[0],
                        changeState: changeState,
                      ),
                      ItemSeletectWidget(
                        title: states[1],
                        item: selectedItem[1],
                        changeState: changeState,
                      ),
                      ItemSeletectWidget(
                        title: states[2],
                        item: selectedItem[2],
                        changeState: changeState,
                      ),
                      ItemSeletectWidget(
                        title: states[3],
                        item: selectedItem[3],
                        changeState: changeState,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  // 검색 위젯
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black45, blurRadius: 5),
                      ],
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                hint: Text('Search Item'),
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(),
                              ),
                              controller: controller,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            _currentState,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 20),
                          DropdownButton(
                            value: _selectedCategory,
                            items: categories
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewClothScreen(),
                            ),
                          );
                        },
                        child: Text('옷 추가'),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black45, blurRadius: 3),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/rainy.png',
                                  width: 100,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Cloth name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: Icon(Icons.edit),
                                  ),
                                ],
                              ),

                              Text('category   thickness'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 화면 상단에 옷의 대분류를 선택하는 위젯
// 각 버튼을 누르면 각 분류에 해당하는 옷 목록을 보여준다
// 옷 목록에서 아이템을 선택하면 + 아이콘이 없어지고, 아이템 이미지 + 이름으로 바뀐다.

class ItemSeletectWidget extends StatelessWidget {
  final String title;
  final ClosetItem? item;
  final Function(String) changeState;
  //TODO : add Setstate Variables
  const ItemSeletectWidget({
    super.key,
    required this.title,
    required this.item,
    required this.changeState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: () {
            changeState(title);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
              borderRadius: BorderRadius.circular(90),
            ),
            width: 90,
            height: 90,
            child: (item != null)
                ? Image.asset('assets/images/rainy.png')
                : Icon(Icons.add),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text((item != null) ? item!.name : '-'),
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.red,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
