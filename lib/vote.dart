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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                  Text("사용자 ID"),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Image.network(
                  "https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/ambp0i_ap5ok1f.jpg?fit=around|600:*&crop=600:*;*,*&output-format=jpg&output-quality=80",
                  height: 411,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 35,
                  left: 370,
                  child: Text(
                    "3334",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.place, color: Colors.white),
                      ),
                      Text(
                        "명소 이름",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 280),
                        child: Icon(Icons.star_outline, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("인생샷 명소 주소"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {},
                    child: Text("길찾기"),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                // 지도
                Image.network(
                  "https://greenblog.co.kr/wp-content/uploads/2020/03/%ED%81%AC%EA%B8%B0%EB%B3%80%ED%99%98_%EC%9A%B0%EB%A6%AC%EB%82%98%EB%9D%BC-%EC%A7%80%EB%8F%84.jpg",
                  height: 124,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
