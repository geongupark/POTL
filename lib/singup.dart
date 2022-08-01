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
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "회원가입",
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
                      labelText: "이메일 주소",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "비밀번호",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "닉네임",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    margin: EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("가입하기"),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 189, 65, 211),
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
