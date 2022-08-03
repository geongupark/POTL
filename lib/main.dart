import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:potl/service/auth_service.dart';
import 'package:potl/service/home_service.dart';
import 'package:potl/service/my_page_service.dart';
import 'package:potl/view/common/potl_page.dart';
import 'package:provider/provider.dart';

import 'service/post_service.dart';
import 'service/vote_service.dart';
import 'view/common/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => HomeService()),
        ChangeNotifierProvider(create: (context) => VoteService()),
        ChangeNotifierProvider(create: (context) => PostService()),
        ChangeNotifierProvider(create: (context) => MyPageService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : PotlWidget(),
    );
  }
}
