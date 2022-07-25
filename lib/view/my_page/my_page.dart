import 'package:flutter/material.dart';
import 'package:potl/util/confing.dart';
import 'my_page_post.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final List<int> votes = [
    12,
    20,
    100,
    202,
    57,
  ];

  final List<String> images = [
    "https://cdn2.thecatapi.com/images/a9m.jpg",
    "https://cdn2.thecatapi.com/images/63g.jpg",
    "https://cdn2.thecatapi.com/images/a3h.jpg",
    "https://cdn2.thecatapi.com/images/a3h.jpg",
    "https://cdn2.thecatapi.com/images/aph.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.025,
                    0,
                    MediaQuery.of(context).size.height * 0.025,
                    0,
                  ),
                  width: MediaQuery.of(context).size.height * 0.13,
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://cdn2.thecatapi.com/images/b6.jpg"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.053,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "nick name",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.029,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: potlBlack,
                          ),
                          onPressed: () {},
                          child: Text('프로필 편집'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: potlGrey,
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 5,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                String imageUrl = images[index];
                int vote = votes[index];
                return MyPagePost(
                  imageUrl: imageUrl,
                  voteCnt: vote,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
