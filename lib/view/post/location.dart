import 'package:flutter/material.dart';
import 'package:potl/util/POTL_icons.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1, // 그림자 없애기
        backgroundColor: Colors.white, // 배경 색상
        centerTitle: true, // title 중앙 정렬
        iconTheme: IconThemeData(color: Colors.black), // app bar icon color
        title: Text(
          "위치추가",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
          color: Color.fromRGBO(138, 138, 141, 1),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.1),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.04,
              MediaQuery.of(context).size.height * 0.01,
              MediaQuery.of(context).size.width * 0.04,
              MediaQuery.of(context).size.height * 0.02,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.064,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "장소명을 입력하세요.",
                  // 테두리
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  /// 돋보기 아이콘
                  suffixIcon: IconButton(
                    icon: Icon(POTLIcons.search),
                    onPressed: () {
                      // 돋보기 아이콘 클릭
                    },
                  ),
                ),
                onSubmitted: (v) {
                  // 엔터를 누르는 경우
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
