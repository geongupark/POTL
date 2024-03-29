import 'package:flutter/material.dart';
import 'package:potl/view/map/map_page.dart';

import '../../util/POTL_icons.dart';
import '../../util/confing.dart';
import '../home/home.dart';
import '../my_page/my_page.dart';
import '../post/post.dart';
import 'appbar.dart';
import 'package:flutter/services.dart';

class PotlWidget extends StatefulWidget {
  const PotlWidget({Key? key}) : super(key: key);

  @override
  State<PotlWidget> createState() => _PotlWidgetState();
}

class _PotlWidgetState extends State<PotlWidget> {
  int _selectedIndex = 0;
  DateTime currentBackPressTime = DateTime.now();
  PreferredSizeWidget? getAppBarView(BuildContext context, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return POTLAppBar(
          context: context,
          titleName: null,
          pageNum: 0,
        );
      case 2:
        return POTLAppBar(
          context: context,
          titleName: "게시물 등록",
          pageNum: 2,
        );
      case 3:
        return POTLAppBar(
          context: context,
          titleName: "마이 페이지",
          pageNum: 3,
        );
      default:
        return null;
    }
  }

  static List<Widget> _bodyView = <Widget>[
    HomePage(),
    MapPage(
      title: 'map',
    ),
    PostPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
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
      ),
    );
  }

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(milliseconds: 1800)) {
      currentBackPressTime = now;
      final _msg = '뒤로 버튼 한 번 더 누르면 종료됩니다.';
      final snackBar = SnackBar(
          duration: const Duration(milliseconds: 1800), content: Text(_msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return Future.value(true);
  }
}
