import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import '../../service/home_service.dart';
import '../../util/POTL_icons.dart';
import '../../util/confing.dart';
import 'slider_template.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

Widget getSlider(String postId, String imageUrl, String locationName) {
  return SliderTemplate(
      postId: postId, imageUrl: imageUrl, locationName: locationName);
}

class _HomePageState extends State<HomePage> {
  // for carousel slider
  final List<String> imgList = [];

  // for carouselslider
  int _currentSlide = 0;
  final CarouselController _controller = CarouselController();

  // week, month, year
  int _selectedRange = 0;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return Consumer<HomeService>(
      builder: (context, postService, chihld) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Text(
                      "Best shot",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRange = 0;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "주간",
                          style: TextStyle(
                            fontWeight:
                                _selectedRange == 0 ? FontWeight.bold : null,
                            color: _selectedRange == 0 ? potlPurple : null,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRange = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "월간",
                          style: TextStyle(
                            fontWeight:
                                _selectedRange == 1 ? FontWeight.bold : null,
                            color: _selectedRange == 1 ? potlPurple : null,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRange = 2;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "연간",
                          style: TextStyle(
                            fontWeight:
                                _selectedRange == 2 ? FontWeight.bold : null,
                            color: _selectedRange == 2 ? potlPurple : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<QuerySnapshot>(
                future: postService.read(),
                builder: (context, snapshot) {
                  final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
                  final targetDocs = getTargetDocs(docs);
                  if (targetDocs.isEmpty) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Center(
                        child: Text("사진을 올려주세요 ㅜㅜ"),
                      ),
                    );
                  }
                  imgList.clear();
                  for (var i = 0; i < targetDocs.length; i++) {
                    imgList.add(targetDocs[i].id);
                  }
                  return Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: targetDocs.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          final doc = targetDocs[itemIndex];
                          String imageUrl = doc.get("image_url");
                          String locationName = doc.get("location_name");
                          String postId = doc.id;
                          return getSlider(postId, imageUrl, locationName);
                        },
                        carouselController: _controller,
                        options: CarouselOptions(
                            disableCenter: true,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 15 / 14,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentSlide = index;
                              });
                            }),
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imgList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.fromLTRB(3, 15, 3, 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : potlPurple)
                                          .withOpacity(
                                              _currentSlide == entry.key
                                                  ? 0.9
                                                  : 0.3)),
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                print("tap see all");
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  children: [
                                    Text("See all "),
                                    Icon(POTLIcons.potl_arrow_right),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<QueryDocumentSnapshot<Object?>> getTargetDocs(
      List<QueryDocumentSnapshot<Object?>> docs) {
    List<QueryDocumentSnapshot<Object?>> targetDocs = [];
    DateTime today = DateTime.now();
    DateTime startDay;
    DateTime endDay;
    if (_selectedRange == 0) {
      startDay = today.subtract(Duration(days: today.weekday - 1));
      endDay = today.subtract(Duration(days: today.weekday - 7));
    } else if (_selectedRange == 1) {
      startDay = DateTime(today.year, today.month, 1);
      endDay = DateTime(today.year, today.month + 1, 0);
    } else if (_selectedRange == 2) {
      startDay = DateTime(today.year, 1, 1);
      endDay = DateTime(today.year + 1, 0, 0);
    } else {
      return [];
    }
    for (int i = 0; i < docs.length; i++) {
      DateTime postTime = docs[i].get("time").toDate();
      if (startDay.isBefore(postTime) && endDay.isAfter(postTime)) {
        targetDocs.add(docs[i]);
      }
      if (targetDocs.length >= 5) {
        break;
      }
    }
    return targetDocs;
  }
}
