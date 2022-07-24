import 'package:flutter/material.dart';
import 'util/confing.dart';
import 'util/POTL_icons.dart';
import 'view/home/home.dart';
import 'view/common/appbar.dart';
import './view/my_page/my_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  PreferredSizeWidget? getAppBarView(BuildContext context, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return POTLAppBar(
          context: context,
          titleName: null,
        );
      case 3:
        return POTLAppBar(
          context: context,
          titleName: "My Page",
        );
      default:
        return null;
    }
  }

  static const List<Widget> _bodyView = <Widget>[
    HomePage(),
    Text(
      'Index 1: add post',
    ),
    Text(
      'Index 2: my post',
    ),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return SafeArea(
      child: Scaffold(
        appBar: getAppBarView(context, _selectedIndex),
        body: _bodyView[_selectedIndex],
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.087,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(POTLIcons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(POTLIcons.map),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(POTLIcons.potl_add),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(POTLIcons.user),
                label: "",
              ),
            ],
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            elevation: 0.0,
            selectedItemColor: potlPurple,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
