import 'package:flutter/material.dart';
import 'package:potl/service/auth_service.dart';
import 'package:potl/util/confing.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoginSetPasswordByEmail extends StatefulWidget {
  const LoginSetPasswordByEmail({Key? key}) : super(key: key);

  @override
  State<LoginSetPasswordByEmail> createState() =>
      _LoginSetPasswordByEmailState();
}

class _LoginSetPasswordByEmailState extends State<LoginSetPasswordByEmail> {
  TextEditingController emailController = TextEditingController();
  String emailText = '';
  DateTime _tappedSend = DateTime.now();

  bool isValidEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

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
                        "비밀번호 재설정",
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      margin: EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        onPressed: isValidEmailFormat(emailController.text)
                            ? () {
                                if (DateTime.now()
                                        .difference(_tappedSend)
                                        .inMilliseconds >
                                    buttonTime) {
                                  _tappedSend = DateTime.now();
                                  Loader.show(context);
                                  authService.setPasswordByEmail(
                                      email: emailController.text);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "메일 전송 완료 : " + emailController.text),
                                  ));
                                  Navigator.of(context).pop();
                                }
                              }
                            : null,
                        child: Text("메일 전송"),
                        style: ElevatedButton.styleFrom(
                          primary: isValidEmailFormat(emailController.text)
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
