import 'package:flutter/material.dart';
import 'package:potl/service/auth_service.dart';
import 'package:potl/util/confing.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoginEmailSignup extends StatefulWidget {
  const LoginEmailSignup({Key? key}) : super(key: key);

  @override
  State<LoginEmailSignup> createState() => _LoginEmailSignupState();
}

class _LoginEmailSignupState extends State<LoginEmailSignup> {
  bool isChecked14 = false;
  bool isChecked = false;
  bool get isButtonEnabled =>
      emailText.isNotEmpty &&
      passwordText.isNotEmpty &&
      nicknameText.isNotEmpty &&
      isChecked14;
  TextEditingController emailController = TextEditingController();
  String emailText = '';
  TextEditingController passwordController = TextEditingController();
  String passwordText = '';
  TextEditingController nicknameController = TextEditingController();
  String nicknameText = '';
  DateTime _tappedJoin = DateTime.now();

  @override
  void dispose() {
    Loader.hide();
    print("Called dispose");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
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
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
                          controller: emailController,
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
                          controller: passwordController,
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
                          controller: nicknameController,
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
                          if (isButtonEnabled) {
                            // 회원가입
                            if (DateTime.now()
                                    .difference(_tappedJoin)
                                    .inMilliseconds >
                                buttonTime) {
                              _tappedJoin = DateTime.now();
                              Loader.show(context);
                              authService.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                nick_name: nicknameController.text,
                                onSuccess: () {
                                  // 회원가입 성공
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("회원가입 성공"),
                                  ));
                                  Navigator.of(context).pop();
                                },
                                onError: (err) {
                                  // 에러 발생
                                  Loader.hide();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(err),
                                  ));
                                },
                              );
                            }
                          }
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
        );
      },
    );
  }
}
