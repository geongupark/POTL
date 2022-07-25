import 'package:flutter/material.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:potl/util/confing.dart';
import 'package:potl/view/post/location.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      primary: potlGrey,
                      side: BorderSide(
                        color: potlGrey,
                      ),
                      backgroundColor: potlWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LocationPage(),
                      ),
                    ),
                    label: Text('위치 추가'),
                    icon: Icon(POTLIcons.location_small),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: potlLightGrey,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height * 0.13,
                  bottom: 0,
                  child: Column(
                    children: [
                      Icon(
                        POTLIcons.camera,
                        color: potlGrey,
                        size: MediaQuery.of(context).size.width * 0.089,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Text(
                        "인물 사진을 올려주세요 :)",
                        style: TextStyle(
                          color: potlGrey,
                        ),
                      ),
                      Text(
                        "풍경, 음식, 동물 등 사람이 포함되지 않을 경우",
                        style: TextStyle(
                          color: potlGrey,
                        ),
                      ),
                      Text(
                        "삭제 조치됨을 알려드립니다.",
                        style: TextStyle(
                          color: potlGrey,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        // width: MediaQuery.of(context).size.width * 0.4,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            primary: potlBlack,
                            side: BorderSide(color: potlBlack),
                            backgroundColor: potlWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31.0),
                            ),
                          ),
                          onPressed: () {},
                          label: Text('사진 추가하기'),
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.065,
              // alignment: Alignment.center,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: potlGrey,
                  side: BorderSide(
                    color: potlWhite,
                  ),
                  backgroundColor: potlLightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {},
                child: Text('등록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
