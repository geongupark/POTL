import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isChecked14 = false;
  bool isChecked = false;
  bool get isButtonEnabled =>
      emailText.isNotEmpty &&
      passwordText.isNotEmpty &&
      nicknameText.isNotEmpty &&
      isChecked14;
  TextEditingController emailCon = TextEditingController();
  String emailText = '';
  TextEditingController passwordCon = TextEditingController();
  String passwordText = '';
  TextEditingController nicknameCon = TextEditingController();
  String nicknameText = '';

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
                      "회원가입",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            emailText = value;
                          });
                        },
                        controller: emailCon,
                        decoration: InputDecoration(
                          labelText: "이메일 주소",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            passwordText = value;
                          });
                        },
                        controller: passwordCon,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            nicknameText = value;
                          });
                        },
                        controller: nicknameCon,
                        decoration: InputDecoration(
                          labelText: "닉네임",
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked14,
                      onChanged: (value) {
                        setState(() {
                          isChecked14 = value!;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Color.fromRGBO(217, 217, 217, 1),
                      side: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                    Text("[필수] 만 14세 이상이며 동의합니다."),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Color.fromRGBO(217, 217, 217, 1),
                      side: BorderSide(
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                    Text("[선택] 광고성 정보 수신에 동의합니다."),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    margin: EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        print(nicknameCon.text.isNotEmpty);
                      },
                      child: Text("가입하기"),
                      style: ElevatedButton.styleFrom(
                        primary: isButtonEnabled
                            ? Color.fromRGBO(196, 49, 216, 1)
                            : Color.fromRGBO(217, 217, 217, 1),
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
