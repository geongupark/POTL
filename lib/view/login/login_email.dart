import 'package:flutter/material.dart';
import 'package:potl/util/confing.dart';
import 'package:potl/view/login/login_set_password_by_email.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import '../common/potl_page.dart';
import 'login_email_signup.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DateTime _tappedTime = DateTime.now();

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
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "아이디",
                            hintText: "이메일 주소",
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: passwordController,
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
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginSetPasswordByEmail(),
                          ),
                        ),
                        child: Text('비밀번호 찾기'),
                        style: TextButton.styleFrom(
                          primary: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => LoginEmailSignup(),
                          ),
                        )
                            .then((result) {
                          setState(() {
                            emailController.text = "";
                            passwordController.text = "";
                          });
                        }),
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
                        onPressed: () {
                          if (DateTime.now()
                                  .difference(_tappedTime)
                                  .inMilliseconds >
                              buttonTime) {
                            _tappedTime = DateTime.now();
                            Loader.show(context);
                            // 로그인
                            authService.signIn(
                              email: emailController.text,
                              password: passwordController.text,
                              onSuccess: () {
                                // 로그인 성공
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("로그인 성공"),
                                ));

                                // HomePage로 이동
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PotlWidget()),
                                );
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
                        },
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
        );
      },
    );
  }
}
