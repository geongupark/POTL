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
        elevation: 1, // 그림자 없애기
        backgroundColor: Colors.white, // 배경 색상
        centerTitle: true, // title 중앙 정렬
        iconTheme: IconThemeData(color: Colors.black), // app bar icon color
        title: Text(
          "게시물 등록",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        primary: Color.fromRGBO(198, 198, 200, 1),
                        side: BorderSide(
                          color: Color.fromRGBO(198, 198, 200, 1),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: Size(380, 44),
                      ),
                      onPressed: () {},
                      label: Text('위치 추가'),
                      icon: Icon(Icons.gps_fixed),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: 415.0,
                    height: 370.0,
                    color: Color.fromRGBO(242, 242, 246, 1),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 105,
                    bottom: 0,
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Color.fromRGBO(198, 198, 200, 1),
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "인물 사진을 올려주세요 :)",
                          style: TextStyle(
                            color: Color.fromRGBO(198, 198, 200, 1),
                          ),
                        ),
                        Text(
                          "풍경, 음식, 동물 등 사람이 포함되지 않을 경우",
                          style: TextStyle(
                            color: Color.fromRGBO(198, 198, 200, 1),
                          ),
                        ),
                        Text(
                          "삭제 조치됨을 알려드립니다.",
                          style: TextStyle(
                            color: Color.fromRGBO(198, 198, 200, 1),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.black),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31.0),
                              ),
                            ),
                            onPressed: () {},
                            label: Text('사진 추가하기'),
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(380, 44),
                    primary: Colors.grey,
                    side: BorderSide(
                      color: Color.fromRGBO(242, 242, 246, 1),
                    ),
                    backgroundColor: Color.fromRGBO(242, 242, 246, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('등록하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
