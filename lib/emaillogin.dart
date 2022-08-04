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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios),
                      color: Color.fromRGBO(background: rgba(198, 198, 200, 1);
),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "이메일로 로그인",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "아이디",
                      hintText: "이메일 주소",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "비밀번호",
                      hintText: "영문, 숫자, 특수문자 조합 8자리 이상",
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
                  Container(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
