import 'package:flutter/material.dart';

import 'login_email.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                Image.asset(
                  "assets/images/common/POTL.png",
                  height: 150,
                ),
                SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => LoginEmail(),
                    ),
                  )
                      .then((result) {
                    setState(() {});
                  }),
                  child: Image.asset(
                    "assets/images/common/email.png",
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
