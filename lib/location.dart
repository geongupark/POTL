import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // 그림자 없애기
        backgroundColor: Colors.white, // 배경 색상
        centerTitle: true, // title 중앙 정렬
        iconTheme: IconThemeData(color: Colors.black), // app bar icon color
        title: Text(
          "위치추가",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close),
          color: Color.fromRGBO(138, 138, 141, 1),
        ),
      ),
      body: Column(
        children: [
          /// 검색
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 44,
              width: 380,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "장소명을 입력하세요.",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(198, 198, 200, 1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(198, 198, 200, 1),
                    ),
                  ),
                  // 돋보기 아이콘
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("돋보기 아이콘 클릭");
                    },
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}
