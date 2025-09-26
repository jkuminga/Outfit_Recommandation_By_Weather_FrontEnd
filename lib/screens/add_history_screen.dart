import 'package:flutter/material.dart';
import 'package:outfit_fe/models/closet_item.dart';

class AddHistoryScreen extends StatefulWidget {
  const AddHistoryScreen({super.key});

  @override
  State<AddHistoryScreen> createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistoryScreen> {
  final double fixedWidth = 450; // 값 수정
  final double fixedHeight = 844; // 값 수정

  late String _currentState;
  late String _selectedCategory;

  final List<String> states = ['TOP', 'BOTTOM', 'OUTER', 'ETC'];
  final List<String> categories = ['맨투맨', '반팔'];
  final TextEditingController controller = TextEditingController();

  List<ClosetItem?> selectedItem = List.generate(4, (index) => null);

  void changeState(String state) {
    setState(() {
      _currentState = state;
    });
  }

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
                SizedBox(height: 10),
                Row(
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
                    SizedBox(width: 50),
                  ],
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
                    child: Row(
                      children: [
                        SizedBox(width: 15),
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
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                      ],
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
                      TextButton(onPressed: () {}, child: Text('옷 추가')),
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
