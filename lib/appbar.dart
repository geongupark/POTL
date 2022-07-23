import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class POTLAppBar extends StatelessWidget with PreferredSizeWidget {
  const POTLAppBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;
  // final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.02, 0, 0),
        child: Image.asset(
          'assets/images/common/POTL.png',
          height: MediaQuery.of(context).size.height * 0.046,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.02, 0, 0),
          child: IconButton(
            icon: Icon(CupertinoIcons.line_horizontal_3, color: Colors.black),
            onPressed: () {},
          ),
        )
      ],
      centerTitle: true,
      elevation: 1,
      backgroundColor: Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).size.height * 0.1);
}
