import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:potl/util/confing.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import 'login.dart';

class POTLAppBar extends StatefulWidget with PreferredSizeWidget {
  const POTLAppBar({
    Key? key,
    required this.context,
    required this.titleName,
    required this.pageNum,
  }) : super(key: key);

  final BuildContext context;
  final String? titleName;
  final int pageNum;

  @override
  State<POTLAppBar> createState() => _POTLAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).size.height * 0.1);
}

class _POTLAppBarState extends State<POTLAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.02, 0, 0),
        child: widget.pageNum == 0
            ? Image.asset(
                'assets/images/common/POTL.png',
                height: MediaQuery.of(context).size.height * 0.046,
              )
            : Text(
                widget.titleName!,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
      ),
      actions: widget.pageNum == 3
          ? [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme: DividerThemeData(
                    color: Colors.black,
                  ),
                  iconTheme: IconThemeData(color: potlGrey),
                ),
                child: PopupMenuButton<int>(
                  color: potlWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  onSelected: (item) {
                    if (item == 0) {
                      context.read<AuthService>().signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Center(
                        child: Text('로그아웃'),
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text('탈퇴하기'),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : null,
      centerTitle: true,
      elevation: 1,
      backgroundColor: Colors.white,
    );
  }
}
