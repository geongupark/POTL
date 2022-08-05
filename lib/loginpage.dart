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
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios),
                      color: Color.fromRGBO(198, 198, 200, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "이메일로 로그인",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "아이디",
                          hintText: "이메일 주소",
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호",
                          hintText: "영문, 숫자, 특수문자 조합 8자리 이상",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('아이디 찾기'),
                      style: TextButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('비밀번호 찾기'),
                      style: TextButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('회원가입'),
                      style: TextButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    margin: EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("로그인"),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(196, 49, 216, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
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
